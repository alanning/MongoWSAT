<%@ Page Language="C#" MasterPageFile="~/Users/Users.master" AutoEventWireup="True" Inherits="LightBox_Default" Title="Untitled Page" Codebehind="Default.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
    <%-- temporary content --%>
    <asp:Panel ID="Panel1" runat="server" HorizontalAlign="Center" Width="500px" GroupingText="Temporary Content">
    <p><a href="MyAccountInfo.aspx">Update Account info</a></p>
    </asp:Panel>
    
</asp:Content>

