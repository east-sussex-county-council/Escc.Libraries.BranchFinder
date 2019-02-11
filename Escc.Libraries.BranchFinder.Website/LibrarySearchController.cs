using Escc.EastSussexGovUK.Mvc;
using Escc.Exceptions.Soap;
using Escc.Geo;
using Escc.Net.Configuration;
using Exceptionless;
using System;
using System.Configuration;
using System.Data;
using System.Globalization;
using System.Threading.Tasks;
using System.Web.Caching;
using System.Web.Mvc;
using System.Web.Services.Protocols;

namespace Escc.Libraries.BranchFinder.Website
{
    public class LibrarySearchController : Controller
    {
        // GET: Default
        public async Task<ActionResult> Index(string pc)
        {
            var model = new LibrariesViewModel();
            model.Postcode = pc;

            if (!String.IsNullOrEmpty(model.Postcode))
            {
                try
                {
                    await GetAndBindData(model, HttpContext.Cache);
                }
                catch (SoapException ex)
                {
                    if (!ex.Message.Contains("The postcode entered appears to be incorrect.") &&
                        !ex.Message.Contains("The postcode entered could not be found."))
                    {
                        ex.ToExceptionless().Submit();
                    }

                    var helper = new SoapExceptionWrapper(ex);
                    model.PostcodeLookupError = String.Format(CultureInfo.InvariantCulture, Properties.Resources.ErrorFromWebService, helper.Message, helper.Description);
                }
            }

            var templateRequest = new EastSussexGovUKTemplateRequest(Request);
            try
            {
                // Do this if you want your page to support web chat. It should, unless you have a reason not to.
                model.WebChat = await templateRequest.RequestWebChatSettingsAsync();
            }
            catch (Exception ex)
            {
                // Catch and report exceptions - don't throw them and cause the page to fail
                ex.ToExceptionless().Submit();
            }
            try
            {
                // Do this to load the template controls.
                model.TemplateHtml = await templateRequest.RequestTemplateHtmlAsync();
            }
            catch (Exception ex)
            {
                // Catch and report exceptions - don't throw them and cause the page to fail
                ex.ToExceptionless().Submit();
            }

            return View(model);
        }

        /// <summary>
        /// Instantiates and uses web services to bind the repeater control with a list of nearest waste sites.
        /// Called from Page_Load and uses the values from the postcode textbox and the waste type and radial distance drop downs.
        /// The list is sorted in order of ascending distance and filtered on waste type if a type has been selected by the user.
        /// </summary>
        [NonAction]
        private async Task GetAndBindData(LibrariesViewModel model, Cache cache)
        {
            //clear any error messages
            model.PostcodeLookupError = string.Empty;

            // need to convert miles to metres 
            Int32 rad = (int)ConvertMilesToMetres(60);

            // call the appropriate method which returns a dataset
            DataSet ds = await GetNearestLibrariesRadialFromCms(rad, model.Postcode, cache);

            if (ds != null)
            {
                // get a default view on the dataset which we can then sort 
                DataView dv = ds.Tables[0].DefaultView;
                // sort by distance
                dv.Sort = "Miles ASC";

                // bind data
                foreach (DataRowView row in dv)
                {
                    var libraryResult = new LibraryResult();
                    libraryResult.Name = row["Name"].ToString();
                    libraryResult.Url = new Uri(row["URL"].ToString(), UriKind.RelativeOrAbsolute);
                    libraryResult.Description = row["Description"].ToString();
                    libraryResult.MilesAway = (double)row["Miles"];
                    model.Libraries.Add(libraryResult);
                }
            }

            if (model.Libraries.Count == 0)
            {
                model.PostcodeLookupError = Properties.Resources.ErrorNoLibrariesFound;
            }
        }

        /// <summary>
        /// Simple function for converting miles to metres.
        /// </summary>
        /// <param name="miles">A double.</param>
        /// <returns>Miles converted to metres as a double.</returns>
        private static Double ConvertMilesToMetres(Double miles)
        {
            double metres = (miles * 1.60934) * 1000;
            return metres;
        }

        /// <summary>
        /// Gets the libraries from CMS within a radius of the given postcode.
        /// </summary>
        /// <param name="dist">A distance, in metres, to build a 'circular' reference area from. Must not exceed 100000m.</param>	
        /// <param name="nearPostcode">A valid postcode.</param>
        /// <returns></returns>
        [NonAction]
        public async Task<DataSet> GetNearestLibrariesRadialFromCms(Double dist, string nearPostcode, Cache cache)
        {
            DataSet dsCms = await GetSiteData(cache);
            DataSet results;
            var postcodeLookup = new LocateApiPostcodeLookup(new Uri(ConfigurationManager.AppSettings["LocateApiAuthorityUrl"]), ConfigurationManager.AppSettings["LocateApiToken"], new ConfigurationProxyProvider());
            var centreOfPostcode = await postcodeLookup.CoordinatesAtCentreOfPostcodeAsync(nearPostcode);
            if (centreOfPostcode == null) return null;

            var distanceCalculator = new DistanceCalculator();

            results = dsCms.Clone();
            Double radius = dist;

            // need to loop through each row pull out the easting and northing for the site and run it through a method which checks if the
            // site is within the chosen radius
            foreach (DataRow dr in dsCms.Tables[0].Rows)
            {
                // missing live data will likely be null or empty string from the cms placeholder?
                if (!String.IsNullOrWhiteSpace(dr["Latitude"].ToString()) || !String.IsNullOrWhiteSpace(dr["Longitude"].ToString()))
                {
                    var locationToCheck = new LatitudeLongitude(Convert.ToDouble(dr["Latitude"], CultureInfo.InvariantCulture), Convert.ToDouble(dr["Longitude"], CultureInfo.InvariantCulture));

                    var howFarAway = distanceCalculator.DistanceBetweenTwoPoints(centreOfPostcode, locationToCheck);

                    if (howFarAway <= radius)
                    {
                        results.Tables[0].ImportRow(dr);
                    }
                }
            }

            return GenerateDistances(results, centreOfPostcode, distanceCalculator);
        }

        /// <summary>
        /// Adds distances to a dataset of sites retrieved from Microsoft CMS.
        /// </summary>
        /// <param name="ds">A dataset containing sites and eastings and northings for each site.</param>
        /// <param name="centreOfPostcode">The centre of the user's postcode.</param>
        /// <param name="distanceCalculator">The distance calculator.</param>
        /// <returns>
        /// An ADO.net DataSet.
        /// </returns>
        [NonAction]
        public static DataSet GenerateDistances(DataSet ds, LatitudeLongitude centreOfPostcode, DistanceCalculator distanceCalculator)
        {
            if (ds == null) throw new ArgumentNullException("ds");
            if (distanceCalculator == null) throw new ArgumentNullException("distanceCalculator");

            using (DataColumn dcK = new DataColumn("Kilometres", Type.GetType("System.Double")))
            {
                using (DataColumn dcM = new DataColumn("Miles", Type.GetType("System.Double")))
                {
                    ds.Tables[0].Columns.Add(dcK);
                    ds.Tables[0].Columns.Add(dcM);
                    foreach (DataRow dr in ds.Tables[0].Rows)
                    {
                        var latLongInDataRow = new LatitudeLongitude(Convert.ToDouble(dr["Latitude"].ToString(), CultureInfo.InvariantCulture), Convert.ToDouble(dr["Longitude"].ToString(), CultureInfo.InvariantCulture));
                        var kilometres = distanceCalculator.DistanceBetweenTwoPoints(centreOfPostcode, latLongInDataRow) / 1000;
                        dr["Kilometres"] = kilometres;
                        dr["Miles"] = Math.Round((kilometres * 0.6214), 2);
                    }
                    ds.AcceptChanges();
                    return ds;
                }
            }
        }

        /// <summary>
        /// Gets a DataSet of Libraries info from Application or calls GetDataSetFromCMS() if no cached version exists.
        /// </summary>
        /// <seealso cref="DataSetFromCms">
        /// The method which calls the CM Server web service.
        /// </seealso>
        /// <returns>An ADO.net DataSet.</returns>
        [NonAction]
        private async Task<DataSet> GetSiteData(Cache cache)
        {
            DataSet dsCms = cache["librarydata"] as DataSet;
            if (dsCms == null)
            {
                dsCms = await DataSetFromCms(Request.Url);
                cache.Insert("librarydata", dsCms, null, DateTime.Now.AddHours(1), Cache.NoSlidingExpiration);
            }
            return dsCms;
        }

        /// <summary>
        /// Gets a dataset of all libraries from the Content Management Server.
        /// </summary>
        /// <remarks>
        /// Extracts placeholder content and uses this to create a dataset. Also draws mobile library data from an xml file.
        /// </remarks>
        /// <returns>DataSet of all libraries.</returns>
        [NonAction]
        public async static Task<DataSet> DataSetFromCms(Uri requestUrl)
        {
            using (var ds = LibraryDataFormat.CreateDataSet())
            {
                if (String.IsNullOrEmpty(ConfigurationManager.AppSettings["LibraryDataUrl"]))
                {
                    throw new ConfigurationErrorsException("appSettings/LibraryDataUrl setting not found");
                }
                var libraryDataUrl = new Uri(requestUrl, new Uri(ConfigurationManager.AppSettings["LibraryDataUrl"]));
                var dataSource = new UmbracoLibraryDataSource(libraryDataUrl, new ConfigurationProxyProvider());
                await dataSource.AddLibraries(ds.Tables[0]);
                ds.AcceptChanges();
                return ds;
            }
        }
    }
}