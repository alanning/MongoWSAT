<%@ Page Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" Inherits="_Default" Title="Untitled Page" Codebehind="Default.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>

<%-- content placeholder --%>
<asp:Content ID="Content2" ContentPlaceHolderID="content" Runat="Server">

    <%-- temporary content --%>
    <asp:Panel ID="Panel1" runat="server" HorizontalAlign="Center" Width="500px" GroupingText="Temporary Content">
        
        <div class="membersToggle" style="text-align: center; width: 500px; margin-left: auto; margin-right: auto;">
        <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Admin/Default.aspx" 
                Target="_blank">Login as Admin</asp:HyperLink>
        <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="~/Members/Default.aspx" 
                Target="_blank">Login as Member</asp:HyperLink>
        
        <br />
        <br />
        <br />
        
        <div style="text-align: left;"><b><span style="font-size: medium">Admin Login:</span></b><br />
            UserName: admin<br />
            Password: nimda123*<br />
            <br />
            <b><span style="font-size: medium">User Login:</span></b><br />
            UserName: test1<br />
            Password: nimda123*
        </div>

        </div>
    </asp:Panel>
    
    <asp:Button ID="btn1" runat="server" Text="Create Admin" onclick="btn1_Click" ></asp:Button>
    <asp:Button ID="btn2" runat="server" Text="Delete Admin" onclick="btn2_Click" ></asp:Button>
    <br />
    <asp:Label ID="lbl" runat="server"></asp:Label>
</asp:Content>

