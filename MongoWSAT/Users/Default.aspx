<%@ Page Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" Inherits="_Default" Title="Untitled Page" Codebehind="Default.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>

<%-- content placeholder --%>
<asp:Content ID="Content2" ContentPlaceHolderID="content" Runat="Server">

    <%-- temporary content --%>
    <asp:Panel ID="Panel1" runat="server" Width="500px" GroupingText="Temporary Content">
        

        <h1>Step 1:</h1>
        <div style="padding-left:1em;">
            <div style="text-align: left;"><b><span style="font-size: medium">Admin Login:</span></b><br />
                UserName: admin<br />
                Password: nimda123*<br />
                <br />
                <b><span style="font-size: medium">User Login:</span></b><br />
                UserName: test<br />
                Password: nimda123*
            </div>
            <br />
            <asp:Button ID="btn1" runat="server" Text="Create Admin & Test User" onclick="btn1_Click" ></asp:Button>
            <br />
            <asp:Label ID="err" ForeColor="Red" runat="server"></asp:Label>
            <asp:Label ID="lbl" ForeColor="Green" runat="server"></asp:Label>
        </div>

        <h1>Step 2:</h1>
        <div style="padding-left:1em;">
            <div>Check out the default Admin and User areas</div>
            <br />
            <div class="membersToggle" style="width: 500px; margin-left: auto; margin-right: auto;">
                <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Users/Admin/Default.aspx" 
                        Target="_blank">Login as Admin</asp:HyperLink> | 
                <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="~/Users/Members/Default.aspx" 
                        Target="_blank">Login as Test</asp:HyperLink>
            </div>
        </div>

        <h1>Step 3:</h1>
        <div style="padding-left:1em;">
            <h2>Delete this page!</h2>
        </div>
    </asp:Panel>
    
    <br />
</asp:Content>

