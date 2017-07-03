using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Escc.EastSussexGovUK.Skins;
using Escc.EastSussexGovUK.Views;
using Escc.Web;
using Escc.EastSussexGovUK.WebForms;
using System.IO;
using System.Globalization;

namespace Escc.Libraries.BranchFinder.Website
{
    public partial class DefaultPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Ensure there's one version of this URL so that the data is consistent in Google Analytics
            if (Path.GetFileName(Request.RawUrl).ToUpperInvariant() == "DEFAULT.ASPX")
            {
                new HttpStatus().MovedPermanently(ResolveUrl("~/"));
            }

            var skinnable = Master as BaseMasterPage;
            if (skinnable != null)
            {
                skinnable.Skin = new CustomerFocusSkin(ViewSelector.CurrentViewIs(MasterPageFile));
            }
            
            // Sanitise postcode because spam bots keep feeding it to this page with a newline and causing an error 
            // saying newlines are not allowed in a redirect
            if (IsPostBack && !String.IsNullOrEmpty(this.postcode.Text))
            {
                var postcodeEncoded = Server.UrlEncode(Regex.Replace(this.postcode.Text, "[^a-z0-9 ]", String.Empty, RegexOptions.IgnoreCase));
                var redirectTo = new Uri("librarysearch.aspx?pc=" + postcodeEncoded + "&mobile=" + (this.mobiles.Checked ? 1 : 0), UriKind.Relative);
                new HttpStatus().SeeOther(new Uri(new Uri(Uri.UriSchemeHttps + "://" + HttpContext.Current.Request.Url.Authority + HttpContext.Current.Request.Url.AbsolutePath), redirectTo));
            }
        }

        /// <summary>
        /// Initializes the <see cref="T:System.Web.UI.HtmlTextWriter" /> object and calls on the child controls of the <see cref="T:System.Web.UI.Page" /> to render.
        /// </summary>
        /// <param name="writer">The <see cref="T:System.Web.UI.HtmlTextWriter" /> that receives the page content.</param>
        protected override void Render(HtmlTextWriter writer)
        {
            // Get the HTML to be rendered 
            TextWriter tempWriter = new StringWriter(CultureInfo.CurrentCulture);
            base.Render(new HtmlTextWriter(tempWriter));
            string modifiedHtml = tempWriter.ToString();

            // Add a reload parameter to the form action, so that postbacks can be distinguished from the initial load in Google Analytics
            modifiedHtml = modifiedHtml.Replace(" action=\"./\"", " action=\"./?reload\"");

            // Send new HTML to be rendered instead
            writer.Write(modifiedHtml);
        }
    }
}