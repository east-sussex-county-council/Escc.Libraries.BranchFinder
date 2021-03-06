﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Escc.Geo;
using System.Net;
using Escc.Net;
using System.IO;
using Newtonsoft.Json;
using System.Text.RegularExpressions;
using Exceptionless;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Threading.Tasks;

namespace Escc.Libraries.BranchFinder.Website
{
    /// <summary>
    /// Looks up a postcode using an implementation of the GOV.UK locate API defined at https://github.com/alphagov/locate-api
    /// </summary>
    /// <seealso cref="Escc.Libraries.BranchFinder.Website.IPostcodeLookup" />
    public class LocateApiPostcodeLookup : IPostcodeLookup
    {
        private readonly Uri _locateApiUrl;
        private readonly string _authenticationToken;
        private readonly IProxyProvider _proxyProvider;
        private static HttpClient _httpClient;

        /// <summary>
        /// Initializes a new instance of the <see cref="LocateApiPostcodeLookup" /> class.
        /// </summary>
        /// <param name="locateApiUrl">The locate API URL.</param>
        /// <param name="authenticationToken">The authentication token.</param>
        /// <param name="proxyProvider">The proxy provider.</param>
        /// <exception cref="System.ArgumentNullException">authenticationToken</exception>
        public LocateApiPostcodeLookup(Uri locateApiUrl, string authenticationToken, IProxyProvider proxyProvider)
        {
            if (locateApiUrl == null) throw new ArgumentNullException(nameof(locateApiUrl));
            if (String.IsNullOrEmpty(authenticationToken)) throw new ArgumentNullException(nameof(authenticationToken));

            _locateApiUrl = locateApiUrl;
            _authenticationToken = authenticationToken;
            _proxyProvider = proxyProvider;
        }

        /// <summary>
        /// Gets the coordinates at the centre of a postcode, based on the mean position of addresses rather than the geographic centre
        /// </summary>
        /// <param name="postcode">The postcode.</param>
        /// <returns></returns>
        public async Task<LatitudeLongitude> CoordinatesAtCentreOfPostcodeAsync(string postcode)
        {
            if (String.IsNullOrEmpty(postcode)) return null;

            try
            {
                if (_httpClient == null)
                {
                    var handler = new HttpClientHandler();
                    handler.Proxy = _proxyProvider?.CreateProxy();
                    _httpClient = new HttpClient();
                    _httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", _authenticationToken);
                }

                var queryUrl = String.Format(_locateApiUrl.ToString(), Regex.Replace(postcode, "[^A-Za-z0-9]", String.Empty));

                var json = await _httpClient.GetStringAsync(queryUrl);
                var result = JsonConvert.DeserializeObject<LocateApiResult>(json);
                return new LatitudeLongitude(result.latitude, result.longitude);
            }
            catch (HttpRequestException exception)
            {
                if (!exception.Message.Contains("(422) Unprocessable Entity"))
                {
                    exception.ToExceptionless().Submit();
                }
                return null;
            }
        }
    }
}