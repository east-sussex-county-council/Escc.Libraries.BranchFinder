using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Services.Protocols;
using System.Web.UI;
using System.Web.UI.WebControls;
using Escc.EastSussexGovUK.Skins;
using Escc.EastSussexGovUK.Views;
using Escc.EastSussexGovUK.WebForms;
using Escc.Exceptions.Soap;
using Escc.Geo;
using Escc.Web;
using Exceptionless;
using Escc.Net;

namespace Escc.Libraries.BranchFinder.Website
{
    public partial class LibrarySearch : System.Web.UI.Page
    {
        protected void Page_Load(object sender, System.EventArgs e)
        {
            var skinnable = Master as BaseMasterPage;
            if (skinnable != null)
            {
                skinnable.Skin = new CustomerFocusSkin(ViewSelector.CurrentViewIs(MasterPageFile));
            }

            if (!IsPostBack)
            {
                if (Request.Params["pc"] != null)
                {
                    this.postcode.Text = Request.Params["pc"];
                }

                this.mobiles.Checked = (Request.QueryString["mobile"] == "1");

                try
                {
                    GetAndBindData();
                }
                catch (SoapException ex)
                {
                    if (!ex.Message.Contains("The postcode entered appears to be incorrect.") &&
                        !ex.Message.Contains("The postcode entered could not be found."))
                    {
                        ex.ToExceptionless().Submit();
                    }

                    var helper = new SoapExceptionWrapper(ex);
                    litError.Text = String.Format(CultureInfo.InvariantCulture, Properties.Resources.ErrorFromWebService, helper.Message, helper.Description);
                    litError.Text = FormatException(litError.Text);
                }
            }
            else
            {
                var currentUrl = new Uri(Uri.UriSchemeHttps + "://" + Request.Url.Authority + Request.Url.AbsolutePath);
                var redirectTo = new Uri(currentUrl, new Uri("librarysearch.aspx?pc=" + HttpUtility.UrlEncode(this.postcode.Text) + "&mobile=" + (this.mobiles.Checked ? "1" : "0"), UriKind.Relative));
                if (redirectTo.PathAndQuery != Request.Url.PathAndQuery)
                {
                    new HttpStatus().SeeOther(redirectTo);
                }
                else
                {
                    GetAndBindData();
                }
            }
        }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Design", "CA1054:UriParametersShouldNotBeStrings", MessageId = "1#"), 
        System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Design", "CA1055:UriReturnValuesShouldNotBeStrings")]
        public static string RenderLibraryUrl(string locationType, string url)
        {
            if (locationType == null) throw new ArgumentNullException("locationType");
            if (url == null) throw new ArgumentNullException("url");

            if (locationType.ToUpperInvariant().StartsWith("MOBILE", StringComparison.Ordinal))
            {
                url = ConfigurationManager.AppSettings["UmbracoBaseUrl"] + "/libraries/locations/mobile/";
            }

            return HttpUtility.HtmlEncode(url);
        }

        /// <summary>
        /// Selectively shows information based on whether the library is static or mobile.
        /// </summary>
        /// <param name="description">string. Description for a mobile library.</param>
        /// <param name="locationType">string. locationType the mobile library visits.</param>
        /// <param name="town">string. Town of visit.</param>
        /// <returns></returns>
        public static string RenderLibraryData(string description, string locationType, string town)
        {
            if (locationType == null) throw new ArgumentNullException("locationType");

            StringBuilder sb = new StringBuilder();
            if (locationType.ToUpperInvariant().StartsWith("MOBILE", StringComparison.Ordinal))
            {
                sb.Append("<dt>Town: </dt><dd>").Append(HttpUtility.HtmlEncode(town)).Append("</dd><dt>Description:</dt><dd>This is a mobile library stop. Check the full page for timetables.</dd>");
            }
            else
            {
                sb.Append("<dt>Description:</dt><dd>").Append(HttpUtility.HtmlEncode(description)).Append("</dd>");
            }
            return sb.ToString();
        }

        /// <summary>
        /// Creates a bullet point error message
        /// </summary>
        /// <param name="message">string</param>
        /// <returns>string</returns>
        private static string FormatException(string message)
        {
            string startTags = "<ul class=\"validationSummary\"><li>";
            string endTags = "</li></ul>";
            message = startTags + message + endTags;
            return message;
        }
        /// <summary>
        /// Instantiates and uses web services to bind the repeater control with a list of nearest waste sites.
        /// Called from Page_Load and uses the values from the postcode textbox and the waste type and radial distance drop downs.
        /// The list is sorted in order of ascending distance and filtered on waste type if a type has been selected by the user.
        /// </summary>
        private void GetAndBindData()
        {
            //clear any error messages
            litError.Text = string.Empty;

            // need to convert miles to metres 
            Int32 rad = (int)ConvertMilesToMetres(60);

            // call the appropriate method which returns a dataset
            DataSet ds = GetNearestLibrariesRadialFromCms(rad, this.postcode.Text);
            DataView dv = null;

            if (ds != null)
            {
                // get a default view on the dataset which we can then sort and filter
                dv = ds.Tables[0].DefaultView;
                // apply filtering if mobile libraries are deselected
                if (!this.mobiles.Checked)
                {
                    dv.RowFilter = "[LocationType] <> 'MobileLibraryStop'";
                }
                // sort by distance
                dv.Sort = "Miles ASC";

                // set up paging	
                //trim data
                pagingController.TrimRows(dv);
            }

            if (pagingController.TotalResults > 0)
            {
                // bind data
                rptResults.DataSource = dv;
                rptResults.DataBind();
            }
            else
            {
                litError.Text = FormatException(Properties.Resources.ErrorNoLibrariesFound);
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
        public DataSet GetNearestLibrariesRadialFromCms(Double dist, string nearPostcode)
        {
            DataSet dsCms = GetSiteData();
            DataSet results;
            var postcodeLookup = new LocateApiPostcodeLookup(new Uri(ConfigurationManager.AppSettings["LocateApiAuthorityUrl"]), ConfigurationManager.AppSettings["LocateApiToken"], new ConfigurationProxyProvider());
            var centreOfPostcode = postcodeLookup.CoordinatesAtCentreOfPostcode(nearPostcode);
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
                        var kilometres = distanceCalculator.DistanceBetweenTwoPoints(centreOfPostcode, latLongInDataRow)/1000;
                        dr["Kilometres"] = kilometres;
                        dr["Miles"] = Math.Round((kilometres*0.6214), 2);
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
        private DataSet GetSiteData()
        {
            DataSet dsCms = Cache.Get("librarydata") as DataSet;
            if (dsCms == null)
            {
                dsCms = DataSetFromCms();
                Cache.Insert("librarydata", dsCms, null, DateTime.Now.AddHours(1), System.Web.Caching.Cache.NoSlidingExpiration);
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
        public static DataSet DataSetFromCms()
        {
            using (var ds = LibraryDataFormat.CreateDataSet())
            {
                new UmbracoLibraryDataSource().AddLibraries(ds.Tables[0]);
                ds.AcceptChanges();
                return ds;
            }
        }
    }
}