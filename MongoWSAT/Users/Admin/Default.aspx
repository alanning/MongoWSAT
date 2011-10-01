<%@ Page Language="C#" MasterPageFile="~/Users/Admin/MasterPage.master" AutoEventWireup="True" Inherits="Admin_Default" Title="Admin Dashboard" Codebehind="Default.aspx.cs" %>
<%@ Register src="~/Users/UserControls/adminUserNavLinks.ascx" tagname="adminUserNavLinks" tagprefix="uc1" %>

<%-- content placeholder for head section --%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>

<%-- content placeholder for body title --%>
<asp:Content ID="Content5" runat="server" contentplaceholderid="cphBodyTitle">
    Admin Dashboard
</asp:Content>

<%-- content placeholder for user navigation --%>
<asp:Content ID="Content6" runat="server" contentplaceholderid="cphUserNavigation">

    <%-- user navigation links include --%>
    <uc1:adminUserNavLinks ID="adminUserNavLinks1" runat="server" />
    
</asp:Content>

<%-- content placeholder for body content --%>
<asp:Content ID="Content7" runat="server" contentplaceholderid="cphContentBody">

    You can put your dashboard content here or you can delete this page.

</asp:Content>


