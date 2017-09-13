<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="Escc.Libraries.BranchFinder.Website.DefaultPage" %>
<%@ Register tagPrefix="EastSussexGovUK" tagName="Share" src="~/share.ascx" %>

<asp:Content runat="server" ContentPlaceHolderID="metadata">
	<Metadata:MetadataControl id="headcontent" runat="server"
		Title="Find your local library" 
		Description="Information about public libraries in East Sussex, their services, opening hours and contact details." 
		Keywords="Libraries, Branch libraries, Children's libraries, Mobile libraries, Reference libraries,Library facilities, Children's library service, Mobile library services,library, libraries, book, books, reference, talking books, story cassettes, tapes, videos, dvds, music, scores, cds, compact discs, leaflets, local history, local studies, electoral register, registers, display, newspapers, magazines, periodicals, journals, photocopier, people's network, computers, pcs, internet, word processing, cd-roms, housebound, volunteer, children, storytimes, story time, activities, reading game, homework, research, information, enquiries, enquiry service, lifelong learning"
		DateIssued="2007-01-04"
		IpsvPreferredTerms="Libraries; Children's libraries; Mobile libraries; Public libraries; Reference libraries"
		IpsvNonPreferredTerms="Library facilities; Children's library service; Mobile library services; Joining a library"
		LgtlType="Website facilities;Search results"
		LgslNumbers="437"
	 />
    <EastSussexGovUK:ContextContainer runat="server" Desktop="true">
        <ClientDependency:Css runat="server" Files="FormsSmall" />
        <ClientDependency:Css runat="server" Files="FormsMedium" MediaConfiguration="Medium" />
        <ClientDependency:Css runat="server" Files="FormsLarge" MediaConfiguration="Large" />
    </EastSussexGovUK:ContextContainer>
    <ClientDependency:Script runat="server" Files="Tips;DescribedByTips" />
</asp:Content>
 
<asp:Content runat="server" ContentPlaceHolderID="content">
    <div class="article">
    <article>
        <div class="content text-content">
            <h1>Find your local library</h1>
            
            <EastSussexGovUK:ContextContainer runat="server" Before="2016-11-24">
            <div class="latest">
                <section>
                    <h2>Latest</h2>
                    <p><a href="https://www.eastsussex.gov.uk/libraries/locations/new-library-opening-times/?utm_source=librarieslatest-escc&amp;utm_medium=web&amp;utm_content=newlibraryopeningtimes&amp;utm_campaign=libraries">New library opening times start on 28 November 2016</a></p>
                </section>
            </div>
            </EastSussexGovUK:ContextContainer>

            <p>There are 24 main libraries and one <a href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/mobile/">mobile library</a> in East Sussex. 
                Most of our libraries have <a href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/library-services-for-people-with-disabilities/disabled-access/">disabled access</a> for wheelchairs.
            </p>
    
            <div class="form simple-form" id="findLibrary">
            <div class="fields-with-checkbox">
                <div class="fields">
                    <asp:Label runat="server" AssociatedControlID="postCode">Postcode </asp:Label>
                    <asp:TextBox ID="postcode" runat="server" CssClass="postcode describedby-tip" aria-describedby="postcode-help" data-tip-positions="top bottom"></asp:TextBox>
                    <p id="postcode-help">We won't keep or share your postcode.</p>
                    <asp:CheckBox ID="mobiles" runat="server" CssClass="formControl checkbox" Text="Show mobile library stops"></asp:CheckBox>
                </div>
                <asp:Button ID="Go" runat="server" Text="Find your nearest" CssClass="button buttonBig" />
            </div>
            <p class="useList note"><span class="or">or</span> use our <a href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/">list of libraries</a></p>
            </div>

        <img width="455" height="344" alt="Map of libraries" class="mapNavigation" usemap="#Map" src="<%= ResolveUrl("~/img/libraries.png") %>" />
        
        <map name="Map" id="Map">
<area alt="Forest Row" title="Forest Row" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/forestrow/" shape="rect" coords="64,23,133,56" />
<area alt="Crowborough" title="Crowborough" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/crowborough/" shape="rect" coords="91,55,176,90" />
<area alt="Wadhurst" title="Wadhurst" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/wadhurst/" shape="rect" coords="179,45,248,78" />
<area alt="Mayfield" title="Mayfield" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/mayfield/" shape="rect" coords="177,87,244,122" />
<area alt="Uckfield" title="Uckfield" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/uckfield/" shape="rect" coords="86,129,153,164" />
<area alt="Heathfield" title="Heathfield" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/heathfield/" shape="rect" coords="172,132,252,161" />
<area alt="Ringmer" title="Ringmer" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/ringmer/" shape="rect" coords="73,190,141,220" />
<area alt="Lewes" title="Lewes" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/lewes/" shape="rect" coords="40,217,84,247" />
<area alt="Peacehaven" title="Peacehaven" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/peacehaven/" shape="rect" coords="5,273,73,303" />
<area alt="Newhaven" title="Newhaven" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/newhaven/" shape="rect" coords="75,258,139,288" />
<area alt="Seaford" title="Seaford" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/seaford/" shape="rect" coords="98,287,166,309" />
<area alt="Hailsham" title="Hailsham" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/hailsham/" shape="rect" coords="154,201,214,229" />
<area alt="Polegate" title="Polegate" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/polegate/" shape="rect" coords="136,233,190,261" />
<area alt="Willingdon" title="Willingdon" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/willingdon/" shape="poly" coords="143,341,146,322,175,320,176,269,188,269,185,323,206,324,208,343" />
<area alt="Eastbourne" title="Eastbourne" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/eastbourne/" shape="poly" coords="190,293,203,295,214,305,259,308,260,325,192,323" />
<area alt="Hampden Park" title="Hampden Park" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/hampdenpark/" shape="poly" coords="193,276,229,287,307,288,309,304,227,306,187,289" />
<area alt="Langney" title="Langney" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/langney/" shape="rect" coords="203,266,309,284" />
<area alt="Pevensey Bay" title="Pevensey Bay" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/pevenseybay/" shape="rect" coords="196,235,267,264" />
<area alt="Bexhill" title="Bexhill" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/bexhill/" shape="rect" coords="268,217,310,246" />
<area alt="Battle" title="Battle" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/battle/" shape="rect" coords="255,172,309,197" />
<area alt="Hollington" title="Hollington" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/hollington/" shape="rect" coords="308,189,369,214" />
<area alt="Ore" title="Ore" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/ore/" shape="rect" coords="346,213,388,234" />
<area alt="Hastings" title="Hastings" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/hastings/" shape="poly" coords="335,224,348,232,369,237,371,261,313,261,314,236" />
<area alt="Rye" title="Rye" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/rye/" shape="rect" coords="390,145,436,174" />
        </map>

        <EastSussexGovUK:Share runat="server" />
        </div>
    </article>
    </div>
</asp:Content>