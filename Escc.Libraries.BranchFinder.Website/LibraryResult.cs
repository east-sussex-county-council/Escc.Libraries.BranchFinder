using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Escc.Libraries.BranchFinder.Website
{
    /// <summary>
    /// Data about an individual library, returned by a search
    /// </summary>
    public class LibraryResult
    {
        /// <summary>
        /// Gets or sets the URL of the page about the library.
        /// </summary>
        public Uri Url { get; set; }

        /// <summary>
        /// Gets or sets the name of the library
        /// </summary>
        public string Name { get; set; }

        /// <summary>
        /// Gets or sets the description of the library's facilities.
        /// </summary>
        public string Description { get; set; }

        /// <summary>
        /// Gets or sets how many miles the library is away from the postcode searched for.
        /// </summary>
        public double MilesAway { get; set; }
    }
}