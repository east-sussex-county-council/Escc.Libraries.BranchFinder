using System;
using System.IO;
using System.Web.Mvc;

namespace Escc.Libraries.BranchFinder.Website
{
    public class DefaultController : Controller
    {
        // GET: Default
        public ActionResult Index(string postcode)
        {
            // Ensure there's one version of this URL so that the data is consistent in Google Analytics
            if (Path.GetFileName(Request.RawUrl).ToUpperInvariant() == "DEFAULT.ASPX")
            {
                return new RedirectResult(Url.Content("~/"), true);
            }

            return View(new LibrariesViewModel());
        }
    }
}