<%@ Control Language="C#" AutoEventWireup="True" Inherits="UserControls_adminUserStats" Codebehind="adminUserStats.ascx.cs" %>

<div class="whosOnlineWrap">

<a href="default.aspx" title="The total number of registered users">Registered Users: <asp:Literal runat="server" ID="lblTotalUsers" /></a>

&nbsp;

<a href="Online_users.aspx" title="The number of users currently visiting the site">Online: <asp:Literal runat="server" ID="lblOnlineUsers" /></a>

</div>