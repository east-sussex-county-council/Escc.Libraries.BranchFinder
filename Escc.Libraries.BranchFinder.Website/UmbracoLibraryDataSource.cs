using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using Escc.Net;
using Escc.Net.Configuration;
using Newtonsoft.Json;

namespace Escc.Libraries.BranchFinder.Website
{
    /// <summary>
    /// Gets library data from an Umbraco installation using an API defined in the Escc.CustomerFocusTemplates.Website project
    /// </summary>
    public class UmbracoLibraryDataSource : ILibraryDataSource
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Naming", "CA2204:Literals should be spelled correctly", MessageId = "LibraryDataUrl"), System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Naming", "CA2204:Literals should be spelled correctly", MessageId = "appSettings")]
        public void AddLibraries(DataTable table)
        {
            if (table == null) throw new ArgumentNullException("table");
            if (String.IsNullOrEmpty(ConfigurationManager.AppSettings["LibraryDataUrl"]))
            {
                throw new ConfigurationErrorsException("appSettings/LibraryDataUrl setting not found");
            }

            var url = ConfigurationManager.AppSettings["LibraryDataUrl"];
            var absoluteUrl = new Uri(HttpContext.Current.Request.Url, new Uri(url));
            var client = new HttpRequestClient(new ConfigurationProxyProvider());
            var request = client.CreateRequest(absoluteUrl);
#if DEBUG
            // Turn off SSL check in debug mode as it will always fail against a self-signed certificate used for development
            request.ServerCertificateValidationCallback += (sender, certificate, chain, sslPolicyErrors) => true;
#endif
            using (var response = request.GetResponse())
            {
                using (var reader = new StreamReader(response.GetResponseStream()))
                {
                    var json = reader.ReadToEnd();

                    var libraries = JsonConvert.DeserializeObject<List<LocationApiResult>>(json);

                    foreach (var library in libraries)
                    {
                        var row = table.NewRow();
                        row["Name"] = library.Name;
                        row["URL"] = library.Url;
                        row["Latitude"] = library.Latitude;
                        row["Longitude"] = library.Longitude;
                        row["Description"] = library.Description;
                        row["Town"] = library.Town;
                        row["LocationType"] = library.LocationType;
                        table.Rows.Add(row);
                    }
                }
            }
        }
    }

    [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Performance", "CA1812:AvoidUninstantiatedInternalClasses")]
    internal class LocationApiResult
    {
        public string Name { get; set; }
        public string LocationType { get; set; }
        public double Latitude { get; set; }
        public double Longitude { get; set; }
        public string Description { get; set; }
        public string Url { get; set; }
        public string Town { get; set; }
    }
}


