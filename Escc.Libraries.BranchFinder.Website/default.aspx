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
    <Client:Css runat="server" Files="FormsSmall" />
    <EastSussexGovUK:ContextContainer runat="server" Desktop="true">
        <Client:Css runat="server" Files="FormsMedium" MediaConfiguration="Medium" />
        <Client:Css runat="server" Files="FormsLarge" MediaConfiguration="Large" />
    </EastSussexGovUK:ContextContainer>
</asp:Content>
 
<asp:Content runat="server" ContentPlaceHolderID="content">
    <div class="article">
    <article>
        <h1 class="text">Find your local library</h1>

        <div class="text">
            <p>There are 24 main libraries, one <a href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/mobile/">mobile library</a> and two village libraries in East Sussex. 
                Most of our libraries have <a href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/library-services-for-people-with-disabilities/disabled-access/">disabled access</a> for wheelchairs.
            </p>
        </div>
    
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
        
        
        
        <%--<map name="Map" id="Map">
<area alt="Forest Row" title="" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/forestrow/" shape="rect" coords="195,126,314,170" style="outline:none;" target="_blank">
<area alt="Crowborough" title="" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/crowborough" shape="rect" coords="238,179,357,223" style="outline:none;" target="_blank">
<area alt="" title="" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/wadhurst/" shape="rect" coords="378,167,489,201" style="outline:none;" target="_blank">
<area alt="" title="" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/mayfield" shape="rect" coords="386,234,497,268" style="outline:none;" target="_blank">
<area alt="" title="" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/uckfield/" shape="rect" coords="245,322,356,361" style="outline:none;" target="_blank">
<area alt="Heathfield" title="" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/heathfield/" shape="rect" coords="329,290,440,329" style="outline:none;" target="_blank">
<area alt="Ringmer" title="" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/ringmer" shape="rect" coords="140,412,251,451" style="outline:none;" target="_blank">
<area alt="Lewes" title="" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/lewes/" shape="rect" coords="136,467,247,506" style="outline:none;" target="_blank">
<area alt="Peacehaven" title="" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/peacehaven/" shape="rect" coords="109,575,204,607" style="outline:none;" target="_blank">
<area alt="Newhaven" title="" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/newhaven/" shape="rect" coords="197,552,301,587" style="outline:none;" target="_blank">
<area alt="Seaford" title="" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/seaford/" shape="rect" coords="225,603,304,640" style="outline:none;" target="_blank">
<area alt="Hailsham" title="" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/hailsham" shape="rect" coords="393,463,487,505" style="outline:none;" target="_blank">
<area alt="Eastbourne" title="" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/eastbourne/" shape="rect" coords="377,601,471,643" style="outline:none;" target="_blank">
<area alt="Hampden Park" title="" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/hampdenpark" shape="rect" coords="418,573,552,599" style="outline:none;" target="_blank">
<area alt="Polegate" title="" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/polegate/" shape="rect" coords="333,518,408,545" style="outline:none;" target="_blank">
<area alt="Bexhill" title="" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/bexhill/" shape="rect" coords="570,500,651,537" style="outline:none;" target="_blank">
<area alt="Pevensey Bay" title="" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/pevenseybay/" shape="rect" coords="478,528,595,565" style="outline:none;" target="_blank">
<area alt="Hastings" title="" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/hastings/" shape="rect" coords="662,474,750,504" style="outline:none;" target="_blank">
<area alt="Hollington" title="" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/Hollington/" shape="rect" coords="564,430,660,460" style="outline:none;" target="_blank">
<area alt="Battle" title="" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/Battle/" shape="rect" coords="570,389,666,419" style="outline:none;" target="_blank">
<area alt="Sedlescombe" title="" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/sedlescombe/" shape="rect" coords="630,344,746,375" style="outline:none;" target="_blank">
<area alt="Northiam" title="" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/northiam/" shape="rect" coords="680,281,796,312" style="outline:none;" target="_blank">
<area alt="Ore" title="" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/ore/" shape="rect" coords="697,427,780,461" style="outline:none;" target="_blank">
<area alt="Rye" title="" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/rye/" shape="rect" coords="790,335,873,370" style="outline:none;" target="_blank">
<area alt="Langney" title="" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/langney/" shape="rect" coords="402,535,482,558" style="outline:none;" target="_blank">
<%--<area shape="rect" coords="958,718,960,720" alt="Image Map" style="outline:none;" title="Image Map" href="http://www.image-maps.com/index.php?aff=mapped_users_[msg]Er">--%>
</map>-->
        <map name="Map" id="Map">
            <area shape="rect" coords="69,44,154,72" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/forestrow/" alt="Forest Row" title="Forest Row" />
            <area shape="rect" coords="190,71,277,88" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/wadhurst/" alt="Wadhurst" title="Wadhurst" />
            <area shape="rect" coords="77,77,148,94" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/crowborough/" alt="Crowborough" title="Crowborough" />
            <area shape="rect" coords="190,114,264,122" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/mayfield/" alt="Mayfield" title="Mayfield" />
            <area shape="rect" coords="122,129,190,158" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/uckfield/" alt="Uckfield" title="Uckfield" />
            <area shape="rect" coords="180,135,268,166" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/heathfield/" alt="Heathfield" title="Heathfield" />
            <area shape="rect" coords="80,177,158,208" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/ringmer/" alt="Ringmer" title="Ringmer" />
            <area shape="rect" coords="50,210,117,239" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/lewes/" alt="Lewes" title="Lewes" />
            <area shape="rect" coords="46,256,86,304" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/peacehaven/" alt="Peacehaven" title="Peacehaven" />
            <area shape="rect" coords="81,255,147,280" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/newhaven/" alt="Newhaven" title="Newhaven" />
            <area shape="rect" coords="97,282,138,305" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/seaford/" alt="Seaford" title="Seaford" />
            <area shape="rect" coords="180,240,207,270" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/willingdon/" alt="Willingdon" title="Willingdon" />
            
            <area shape="rect" coords="269,176,329,191" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/battle/" alt="Battle" title="Battle" />
            <area shape="rect" coords="249,185,359,206" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/hollington/" alt="Hollington" title="Hollington" />
            <area shape="rect" coords="337,206,396,220" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/ore/" alt="Ore" title="Ore" />
            <area shape="rect" coords="314,221,372,248" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/hastings/" alt="Hastings" title="Hastings" />
            <area shape="rect" coords="265,236,315,254" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/bexhill/" alt="Bexhill" title="Bexhill" />
            <area shape="rect" coords="186,218,251,242" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/hailsham/" alt="Hailsham" title="Hailsham" />
            <area shape="rect" coords="170,228,190,256" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/polegate/" alt="Polegate" title="Polegate" />
            <area shape="rect" coords="175,257,225,267" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/langney/" alt="Langney" title="Langney" />
            <area shape="rect" coords="317,137,388,152" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/northiam/" alt="Northiam" title="Northiam" />
            <area shape="rect" coords="190,290,160,305" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/eastbourne/" alt="Eastbourne" title="Eastbourne" />

            <area shape="rect" coords="232,267,259,263" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/pevenseybay/" alt="Pevensey Bay" title="Pevensey Bay" />
            <area shape="rect" coords="391,160,400,160" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/rye/" alt="Rye" title="Rye" />
            <area shape="rect" coords="180,277,199,290" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/hampdenpark/" alt="Hampden Park" title="Hampden Park" />
            <area shape="rect" coords="309,154,310,174" href="<%= ConfigurationManager.AppSettings["UmbracoBaseUrl"] %>/libraries/locations/sedlescombe/" alt="Sedlescombe" title="Sedlescombe" />
        </map>

        <EastSussexGovUK:Share runat="server" />
    </article>
    </div>
</asp:Content>