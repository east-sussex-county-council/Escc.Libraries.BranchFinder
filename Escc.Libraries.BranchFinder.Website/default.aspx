<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="Escc.Libraries.BranchFinder.Website.DefaultPage" %>

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
    <Client:Css runat="server" Files="FormsSmall;ContentSmall" />
    <EastSussexGovUK:ContextContainer runat="server" Desktop="true">
        <Client:Css runat="server" Files="FormsMedium;ContentMedium" MediaConfiguration="Medium" />
        <Client:Css runat="server" Files="FormsLarge;ContentLarge" MediaConfiguration="Large" />
    </EastSussexGovUK:ContextContainer>
</asp:Content>
 
<asp:Content runat="server" ContentPlaceHolderID="content">
    <div class="article">
    <article>
        <div class="content text-content">
            <h1>Find your local library</h1>

            <p>There are 24 main libraries, one <a href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/mobile/">mobile library</a> and two village libraries in East Sussex. 
                Most of our libraries have <a href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/library-services-for-people-with-disabilities/disabled-access/">disabled access</a> for wheelchairs.
            </p>
    
            <div class="form simple-form" id="findLibrary">
            <div class="fields-with-checkbox">
                <div class="fields">
                    <asp:Label runat="server" AssociatedControlID="postCode">Postcode </asp:Label>
                    <asp:TextBox ID="postcode" runat="server" CssClass="postcode"></asp:TextBox>
                    <asp:CheckBox ID="mobiles" runat="server" CssClass="formControl checkbox" Text="Show mobile library stops"></asp:CheckBox>
                </div>
                <asp:Button ID="Go" runat="server" Text="Find your nearest" CssClass="button buttonBig" />
            </div>
            <p class="useList note"><span class="or">or</span> use our <a href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/">list of libraries</a></p>
            </div>

        <img width="455" height="344" alt="Map of libraries" class="mapNavigation" usemap="#Map" src="<%= ResolveUrl("~/img/librariesNew.png") %>" />
        
        <map name="Map" id="Map">
            <area shape="rect" coords="69,44,154,72" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/forestrow/" alt="Forest Row" title="Forest Row" />
            <area shape="rect" coords="190,71,277,88" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/wadhurst/" alt="Wadhurst" title="Wadhurst" />
            <area shape="rect" coords="77,77,148,94" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/crowborough/" alt="Crowborough" title="Crowborough" />
            <area shape="rect" coords="190,114,264,122" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/mayfield/" alt="Mayfield" title="Mayfield" />
            <area shape="rect" coords="122,150,152,170" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/uckfield/" alt="Uckfield" title="Uckfield" />
            <area shape="rect" coords="160,125,268,145" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/heathfield/" alt="Heathfield" title="Heathfield" />
            <area shape="rect" coords="80,177,158,208" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/ringmer/" alt="Ringmer" title="Ringmer" />
            <area shape="rect" coords="50,210,117,239" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/lewes/" alt="Lewes" title="Lewes" />
            <area shape="rect" coords="46,256,86,304" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/peacehaven/" alt="Peacehaven" title="Peacehaven" />
            <area shape="rect" coords="81,255,147,280" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/newhaven/" alt="Newhaven" title="Newhaven" />
            <area shape="rect" coords="97,282,138,305" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/seaford/" alt="Seaford" title="Seaford" />
            <area shape="rect" coords="155,262,197,272" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/willingdon/" alt="Willingdon" title="Willingdon" />
            
            <area shape="rect" coords="249,176,289,191" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/battle/" alt="Battle" title="Battle" />
            <area shape="rect" coords="269,199,309,226" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/hollington/" alt="Hollington" title="Hollington" />
            <area shape="rect" coords="337,206,396,220" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/ore/" alt="Ore" title="Ore" />
            <area shape="rect" coords="314,221,372,248" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/hastings/" alt="Hastings" title="Hastings" />
            <area shape="rect" coords="265,236,315,254" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/bexhill/" alt="Bexhill" title="Bexhill" />
            <area shape="rect" coords="186,218,251,242" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/hailsham/" alt="Hailsham" title="Hailsham" />
            <area shape="rect" coords="145,238,190,256" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/polegate/" alt="Polegate" title="Polegate" />
            <area shape="rect" coords="175,257,225,267" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/langney/" alt="Langney" title="Langney" />
            <area shape="rect" coords="309,137,358,167" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/northiam/" alt="Northiam" title="Northiam" />
            <area shape="rect" coords="180,290,220,305" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/eastbourne/" alt="Eastbourne" title="Eastbourne" />

            <area shape="rect" coords="232,257,270,280" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/pevenseybay/" alt="Pevensey Bay" title="Pevensey Bay" />
            <area shape="rect" coords="380,160,410,180" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/rye/" alt="Rye" title="Rye" />
            <area shape="rect" coords="195,277,250,290" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/hampdenpark/" alt="Hampden Park" title="Hampden Park" />
            <area shape="rect" coords="289,164,350,194" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/sedlescombe/" alt="Sedlescombe" title="Sedlescombe" />
        </map>

        <EastSussexGovUK:Share runat="server" />
        </div>
    </article>
    </div>
</asp:Content>