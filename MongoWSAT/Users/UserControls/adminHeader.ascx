<%@ Control Language="C#" AutoEventWireup="True" Inherits="UserControls_adminHeader" Codebehind="adminHeader.ascx.cs" %>
<%@ Register src="adminUserStats.ascx" tagname="adminUserStats" tagprefix="uc1" %>

<%-- div wrapper for header control --%>
<div class="headerControl">

<%-- header bg image --%>
<div class="headerTitleImage"></div>

<%-- header title text --%>
<div class="headerTitleText">Web Site Administration Tool</div>

<div class="loginNameAndStatus">

    Welcome!
    <asp:LoginName ID="LoginName1" runat="server" />
    &nbsp;
    <asp:LoginStatus ID="LoginStatus1" runat="server" LogoutAction="Redirect" LogoutPageUrl="~/Home" />
    
    <%-- number of registered and online users --%>
    <uc1:adminUserStats ID="adminUserStats1" runat="server" />

</div> 

</div>