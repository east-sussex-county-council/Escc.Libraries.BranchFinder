using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Escc.Web;
using EsccWebTeam.EastSussexGovUK.MasterPages;

namespace Escc.Libraries.BranchFinder.Website
{
    public partial class DefaultPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
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
    }
}