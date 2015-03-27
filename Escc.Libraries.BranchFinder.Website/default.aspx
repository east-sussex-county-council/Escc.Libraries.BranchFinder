<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="Escc.Libraries.BranchFinder.Website.DefaultPage" %>

<asp:Content runat="server" ContentPlaceHolderID="metadata">
	<Egms:MetadataControl id="headcontent" runat="server"
		Title="Find your local library" 
		Description="Information about public libraries in East Sussex, their services, opening hours and contact details." 
		Keywords="Libraries, Branch libraries, Children's libraries, Mobile libraries, Reference libraries,Library facilities, Children's library service, Mobile library services,library, libraries, book, books, reference, talking books, story cassettes, tapes, videos, dvds, music, scores, cds, compact discs, leaflets, local history, local studies, electoral register, registers, display, newspapers, magazines, periodicals, journals, photocopier, people's network, computers, pcs, internet, word processing, cd-roms, housebound, volunteer, children, storytimes, story time, activities, reading game, homework, research, information, enquiries, enquiry service, lifelong learning"
		DateIssued="2007-01-04"
		IpsvPreferredTerms="Libraries; Children's libraries; Mobile libraries; Public libraries; Reference libraries"
		IpsvNonPreferredTerms="Library facilities; Children's library service; Mobile library services; Joining a library"
		LgtlType="Website facilities;Search results"
		LgslNumbers="437"
	 />
    <Egms:Css runat="server" Files="FormsSmall" />
    <EastSussexGovUK:ContextContainer runat="server" Desktop="true">
        <Egms:Css runat="server" Files="FormsMedium" MediaConfiguration="Medium" />
        <Egms:Css runat="server" Files="FormsLarge" MediaConfiguration="Large" />
    </EastSussexGovUK:ContextContainer>
</asp:Content>
 
<asp:Content runat="server" ContentPlaceHolderID="content">
    <div class="article">
    <article>
        <h1 class="text">Find your local library</h1>

        <div class="text">
            <p>There are 24 main libraries, one <a href="http://www.eastsussex.gov.uk/libraries/find/mobile/download.htm">mobile library</a> and two village libraries in East Sussex. 
                Most of our libraries have <a href="/libraries/find/library-services-for-people-with-disabilities/disabled-access/">disabled access</a> for wheelchairs.
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
        <p class="useList note"><span class="or">or</span> use our <a href="/libraries/find/contact-library-and-information-services/list/">list of libraries</a></p>
    </div>

        <img width="455" height="344" alt="Map of libraries" class="mapNavigation" usemap="#Map" src="<%= ResolveUrl("~/img/libraries.png") %>" />
        <map name="Map" id="Map">
            <area shape="rect" coords="69,44,154,72" href="http://www.eastsussex.gov.uk/libraries/find/forestrow/default.htm" alt="Forest Row" title="Forest Row" />
            <area shape="rect" coords="208,71,291,88" href="http://www.eastsussex.gov.uk/libraries/find/wadhurst/default.htm" alt="Wadhurst" title="Wadhurst" />
            <area shape="rect" coords="123,77,208,94" href="http://www.eastsussex.gov.uk/libraries/find/crowborough/default.htm" alt="Crowborough" title="Crowborough" />
            <area shape="rect" coords="197,94,264,112" href="http://www.eastsussex.gov.uk/libraries/find/mayfield/default.htm" alt="Mayfield" title="Mayfield" />
            <area shape="rect" coords="102,129,180,158" href="http://www.eastsussex.gov.uk/libraries/find/uckfield/default.htm" alt="Uckfield" title="Uckfield" />
            <area shape="rect" coords="180,135,268,166" href="http://www.eastsussex.gov.uk/libraries/find/heathfield/default.htm" alt="Heathfield" title="Heathfield" />
            <area shape="rect" coords="80,177,158,208" href="http://www.eastsussex.gov.uk/libraries/find/ringmer/default.htm" alt="Ringmer" title="Ringmer" />
            <area shape="rect" coords="50,210,117,239" href="http://www.eastsussex.gov.uk/libraries/find/lewes/default.htm" alt="Lewes" title="Lewes" />
            <area shape="rect" coords="9,276,80,304" href="http://www.eastsussex.gov.uk/libraries/find/peacehaven/default.htm" alt="Peacehaven" title="Peacehaven" />
            <area shape="rect" coords="81,277,147,303" href="http://www.eastsussex.gov.uk/libraries/find/newhaven/default.htm" alt="Newhaven" title="Newhaven" />
            <area shape="rect" coords="117,302,164,325" href="http://www.eastsussex.gov.uk/libraries/find/seaford/default.htm" alt="Seaford" title="Seaford" />
            <area shape="poly" coords="206,327,207,344,140,344,143,327,168,326,160,270,177,270,175,324" href="http://www.eastsussex.gov.uk/libraries/find/willingdon/default.htm" alt="Willingdon" title="Willingdon" />
            <area shape="poly" coords="179,300,179,322,258,324,258,310" href="http://www.eastsussex.gov.uk/libraries/find/eastbourne/default.htm" alt="Eastbourne" title="Eastbourne" />
            <area shape="rect" coords="269,176,329,191" href="http://www.eastsussex.gov.uk/libraries/find/battle/default.htm" alt="Battle" title="Battle" />
            <area shape="rect" coords="315,190,399,206" href="http://www.eastsussex.gov.uk/libraries/find/hollington/default.htm" alt="Hollington" title="Hollington" />
            <area shape="rect" coords="337,206,396,220" href="http://www.eastsussex.gov.uk/libraries/find/ore/default.htm" alt="Ore" title="Ore" />
            <area shape="rect" coords="314,221,372,248" href="http://www.eastsussex.gov.uk/libraries/find/hastings/default.htm" alt="Hastings" title="Hastings" />
            <area shape="rect" coords="265,236,315,254" href="http://www.eastsussex.gov.uk/libraries/find/bexhill/default.htm" alt="Bexhill" title="Bexhill" />
            <area shape="rect" coords="186,218,251,242" href="http://www.eastsussex.gov.uk/libraries/find/hailsham/default.htm" alt="Hailsham" title="Hailsham" />
            <area shape="rect" coords="170,247,240,267" href="http://www.eastsussex.gov.uk/libraries/find/polegate/default.htm" alt="Polegate" title="Polegate" />
            <area shape="poly" coords="306,309,306,290,243,290,201,274,198,286,244,307" href="http://www.eastsussex.gov.uk/libraries/find/langney/default.htm" alt="Langney" title="Langney" />
            <area shape="rect" coords="317,137,388,152" href="http://www.eastsussex.gov.uk/libraries/find/northiam/default.htm" alt="Northiam" title="Northiam" />
            <area shape="poly" coords="322,267,259,263,242,257,241,245,262,255,319,253" href="http://www.eastsussex.gov.uk/libraries/find/pevenseybay/default.htm" alt="Pevensey Bay" title="Pevensey Bay" />
            <area shape="poly" coords="391,160,400,160,400,167,426,168,426,145,390,143,386,158" href="http://www.eastsussex.gov.uk/libraries/find/rye/default.htm" alt="Rye" title="Rye" />
            <area shape="poly" coords="191,266,321,267,320,288,241,289,200,273,187,277" href="http://www.eastsussex.gov.uk/libraries/find/hampdenpark/default.htm" alt="Hampden Park" title="Hampden Park" />
            <area shape="poly" coords="309,154,310,174,399,177,402,162,388,162,388,154" href="http://www.eastsussex.gov.uk/libraries/find/sedlescombe/default.htm" alt="Sedlescombe" title="Sedlescombe" />
        </map>

        <EastSussexGovUK:Related runat="server">
            <WebsitesTemplate>
                <ul>
                <li><a href="http://www.findalibrary.org.uk/">Find your library &#8211; national search</a> </li>
                </ul>
            </WebsitesTemplate>
        </EastSussexGovUK:Related>

        <EastSussexGovUK:Share runat="server" />
    </article>
    </div>
</asp:Content>