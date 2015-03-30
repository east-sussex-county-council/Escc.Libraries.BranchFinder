using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Escc.Geo;

namespace Escc.Libraries.BranchFinder.Website
{
    /// <summary>
    /// A fake postcode lookup implementation which always returns the coordinates of County Hall
    /// </summary>
    public class FakePostcodeLookup : IPostcodeLookup
    {
        public LatitudeLongitude CoordinatesAtCentreOfPostcode(string postcode)
        {
            return new LatitudeLongitude(50.872066, 0.0010903126);
        }
    }
}