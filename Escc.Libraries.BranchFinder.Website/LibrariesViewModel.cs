using Escc.EastSussexGovUK.Mvc;
using System;
using System.Collections.Generic;

namespace Escc.Libraries.BranchFinder.Website
{
    /// <summary>
    /// Data returned about libraries and the search that found them
    /// </summary>
    /// <seealso cref="Escc.EastSussexGovUK.Mvc.BaseViewModel" />
    public class LibrariesViewModel : BaseViewModel
    {
        /// <summary>
        /// Gets or sets the postcode searched for.
        /// </summary>
        public string Postcode { get; set; }

        /// <summary>
        /// Gets or sets any error message resulting from the postcode lookup.
        /// </summary>
        public string PostcodeLookupError {  get; set; }

        /// <summary>
        /// Gets the libraries.
        /// </summary>
        public IList<LibraryResult> Libraries { get; } = new List<LibraryResult>();
    }
}