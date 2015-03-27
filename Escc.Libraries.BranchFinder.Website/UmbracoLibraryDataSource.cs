using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using EsccWebTeam.Data.Xml;
using Newtonsoft.Json;

namespace Escc.Libraries.BranchFinder.Website
{
    /// <summary>
    /// Gets library data from an Umbraco installation using an API defined in the Escc.CustomerFocusTemplates.Website project
    /// </summary>
    public class UmbracoLibraryDataSource : ILibraryDataSource
    {
        public void AddLibraries(DataTable table)
        {
            if (String.IsNullOrEmpty(ConfigurationManager.AppSettings["LibraryDataUrl"]))
            {
                throw new ConfigurationErrorsException("appSettings/LibraryDataUrl setting not found");
            }

            var url = ConfigurationManager.AppSettings["LibraryDataUrl"];
            var request = XmlHttpRequest.Create(new Uri(url));
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


