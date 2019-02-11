using System;
using System.IO;
using System.Threading.Tasks;
using System.Web.Mvc;
using Escc.EastSussexGovUK.Mvc;
using Exceptionless;

namespace Escc.Libraries.BranchFinder.Website
{
    public class DefaultController : Controller
    {
        // GET: Default
        public async Task <ActionResult> Index(string postcode)
        {
            // Ensure there's one version of this URL so that the data is consistent in Google Analytics
            if (Path.GetFileName(Request.RawUrl).ToUpperInvariant() == "DEFAULT.ASPX")
            {
                return new RedirectResult(Url.Content("~/"), true);
            }

            var model= new LibrariesViewModel();
            var templateRequest = new EastSussexGovUKTemplateRequest(Request);
            try
            {
                model.WebChat = await templateRequest.RequestWebChatSettingsAsync();
            }
            catch (Exception ex)
            {
                // Catch and report exceptions - don't throw them and cause the page to fail
                ex.ToExceptionless().Submit();
            }
            try
            {
                model.TemplateHtml = await templateRequest.RequestTemplateHtmlAsync();
            }
            catch (Exception ex)
            {
                // Catch and report exceptions - don't throw them and cause the page to fail
                ex.ToExceptionless().Submit();
            }

            return View(model);
        }
    }
}