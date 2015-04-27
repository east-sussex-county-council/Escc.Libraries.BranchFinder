<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LibrarySearch.aspx.cs" Inherits="Escc.Libraries.BranchFinder.Website.LibrarySearch" %>

<asp:Content runat="server" ContentPlaceHolderID="metadata">
	<Metadata:MetadataControl id="headcontent" runat="server" 
		Title="Find your nearest library"
		Description="Type in your postcode to find libraries and mobile library stops close to you."
		Keywords="postcode; library; libraries; reference; mobile; search; nearest; closest; children's libraries; books; dvds; music; archives"
		DateCreated="2004-12-08"
		LgtlType="Search results"
		IpsvPreferredTerms="Public libraries;Mobile libraries;Children's libraries;Reference libraries"
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
    <div class="text">
        <h1>Find your nearest library</h1>
        <asp:Literal ID="litError" Runat="server"></asp:Literal>
    </div>
        <div class="form simple-form">
            <div class="fields-with-checkbox">
            <div class="fields">
					    <asp:label cssclass="formLabel" runat="server" associatedcontrolid="postCode">Postcode: </asp:label>
					    <asp:TextBox ID="postcode" Runat="server" CssClass="formControl postcode"></asp:TextBox>
					    <asp:CheckBox ID="mobiles" Runat="server" CssClass="formControl checkbox" Text="Show mobile library stops"></asp:CheckBox>
        </div>
	    <asp:Button ID="Go" Text="Find your nearest" CssClass="button" Runat="server" />
        </div>
    </div>
    <NavigationControls:PagingController ID="pagingController" runat="server" ResultsTextSingular="result" ResultsTextPlural="results" />
    <NavigationControls:PagingBarControl ID="pagingTop" runat="server" PagingControllerId="pagingController" />

    <asp:Repeater id="rptResults" runat="server">
	    <ItemTemplate>
		    <%# "<dl class=\"itemDetail\"><dt>Location: </dt><dd><a href=" + RenderLibraryUrl(DataBinder.Eval(Container.DataItem, "LocationType").ToString(), DataBinder.Eval(Container.DataItem, "URL").ToString()) + ">" +HttpUtility.HtmlEncode( DataBinder.Eval(Container.DataItem, "Name")) + "</a></dd>"%>
		    <%# RenderLibraryData(DataBinder.Eval(Container.DataItem, "Description").ToString(), DataBinder.Eval(Container.DataItem, "LocationType").ToString(), DataBinder.Eval(Container.DataItem, "Town").ToString())%>
		    <%# "<dt>Distance: </dt><dd>" + DataBinder.Eval(Container.DataItem, "Miles") + " miles</dd></dl>" %>
	    </ItemTemplate>
    </asp:Repeater>

    <NavigationControls:PagingBarControl ID="pagingBottom" runat="server" PagingControllerId="pagingController" />

    <EastSussexGovUK:Share runat="server" />
</article>
</div>
</asp:Content>