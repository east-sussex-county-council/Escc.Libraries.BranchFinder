﻿using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Services.Protocols;
using Escc.Exceptions.Soap;
using Escc.FormControls.WebForms.AddressFinder;
using Escc.Geo;

namespace Escc.Libraries.BranchFinder.Website
{
    /// <summary>
    /// Look up the central coordinates of a postcode using a web service that queries GIS data
    /// </summary>
    public class PostcodeLookupWebService : IPostcodeLookup
    {
        /// <summary>
        /// Gets the coordinates at the centre of a postcode.
        /// </summary>
        /// <param name="postcode">The postcode.</param>
        /// <returns></returns>
        public LatitudeLongitude CoordinatesAtCentreOfPostcode(string postcode)
        {
            using (var af = new AddressFinder())
            {
                try
                {
                    if (!String.IsNullOrEmpty(ConfigurationManager.AppSettings["ConnectToCouncilWebServicesAccount"]) &&
                        !String.IsNullOrEmpty(ConfigurationManager.AppSettings["ConnectToCouncilWebServicesPassword"]))
                    {
                        af.Credentials = new NetworkCredential(ConfigurationManager.AppSettings["ConnectToCouncilWebServicesAccount"], ConfigurationManager.AppSettings["ConnectToCouncilWebServicesPassword"]);
                    }
                    var eastingAndNorthing = af.AggregateEastingsAndNorthings(postcode);
                    var converter = new OrdnanceSurveyToLatitudeLongitudeConverter();
                    return converter.ConvertOrdnanceSurveyToLatitudeLongitude(eastingAndNorthing.Easting, eastingAndNorthing.Northing);
                }
                catch (SoapException ex)
                {
                    if (ex.Message.Contains("The postcode entered appears to be incorrect."))
                    {
                        return null;
                    }
                    else
                    {
                        throw SoapExceptionEngine.GetSoapException(ex.Message);
                    }
                }
            }
        }
    }
}