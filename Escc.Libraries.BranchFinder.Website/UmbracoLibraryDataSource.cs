using System;
using System.Collections.Generic;
using System.Data;
using System.Net.Http;
using System.Threading.Tasks;
using Escc.Net;
using Newtonsoft.Json;

namespace Escc.Libraries.BranchFinder.Website
{
    /// <summary>
    /// Gets library data from an Umbraco installation using an API defined in the Escc.EastSussexGovUK.Umbraco.Web project
    /// </summary>
    public class UmbracoLibraryDataSource : ILibraryDataSource
    {
        private static HttpClient _httpClient;
        private readonly Uri _libraryDataUrl;
        private readonly IProxyProvider _proxyProvider;

        public UmbracoLibraryDataSource(Uri libraryDataUrl, IProxyProvider proxyProvider)
        {
            _libraryDataUrl = libraryDataUrl ?? throw new ArgumentNullException(nameof(libraryDataUrl));
            if (!_libraryDataUrl.IsAbsoluteUri) throw new ArgumentException(nameof(libraryDataUrl), $"{nameof(libraryDataUrl)} must be an absolute URL");
            _proxyProvider = proxyProvider;
        }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Naming", "CA2204:Literals should be spelled correctly", MessageId = "LibraryDataUrl"), System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Naming", "CA2204:Literals should be spelled correctly", MessageId = "appSettings")]
        public async Task AddLibraries(DataTable table)
        {
            if (table == null) throw new ArgumentNullException("table");
            
            if (_httpClient == null)
            {
                var handler = new HttpClientHandler();
                handler.Proxy = _proxyProvider?.CreateProxy();
                _httpClient = new HttpClient(handler);
            }

            var json = await _httpClient.GetStringAsync(_libraryDataUrl);

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


