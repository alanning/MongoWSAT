<%@ Page Language="C#" MasterPageFile="~/Users/Admin/MasterPage.master" AutoEventWireup="True" Inherits="Admin_Roles" Title="Role Management" Codebehind="Roles.aspx.cs" %>
<%@ Register src="~/Users/UserControls/adminUserNavLinks.ascx" tagname="adminUserNavLinks" tagprefix="uc1" %>

<%-- content placeholder for head section --%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>

<%-- content placeholder for body title --%>
<asp:Content ID="Content5" runat="server" contentplaceholderid="cphBodyTitle">
    Membership Roles
</asp:Content>

<%-- content placeholder for user navigation --%>
<asp:Content ID="Content6" runat="server" contentplaceholderid="cphUserNavigation">

    <%-- user navigation include --%>
    <uc1:adminUserNavLinks ID="adminUserNavLinks1" runat="server" />
    
</asp:Content>

<%-- content placeholder for content body --%>
<asp:Content ID="Content7" runat="server" contentplaceholderid="cphContentBody">

    <%-- ajax update panel start --%>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
    
    <%-- create new Role form elements --%> 
    <div>
    <asp:TextBox runat="server" ID="NewRole" MaxLength="50" ToolTip="Type the name of a new role you want to create."></asp:TextBox>
    <asp:Button ID="Button2" runat="server" OnClick="AddRole" Text="Add Role" ToolTip="Click to create new role." />
    </div>
    
    <br />
    
    <%-- gridview to display membership users --%>
    <asp:GridView ID="UserRoles" runat="server" AutoGenerateColumns="False" 
        SkinID="GridWithFooter">
        <Columns>
            <asp:TemplateField>
                <HeaderStyle CssClass="gridheaderBG" Width="1px" />
                <ItemStyle CssClass="gridheaderBG" Width="1px" />
            </asp:TemplateField>
            <asp:TemplateField>
                <HeaderTemplate>
                    Role Name
                </HeaderTemplate>
                <ItemTemplate>
                    <%# Eval("Role Name") %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <HeaderTemplate>
                    User Count
                </HeaderTemplate>
                <ItemTemplate>
                    <%# Eval("User Count") %>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" />
            </asp:TemplateField>
            <asp:TemplateField>
                <HeaderTemplate>
                    Delete Role
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Button ID="Button1" runat="server" CommandArgument='<%# Eval("Role Name") %>' CommandName="DeleteRole" OnClientClick="return confirm('Are you sure?')" OnCommand="DeleteRole" Text="Delete" ToolTip="Click to delete this role." />
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" />
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    
    <br />
    <br />

    <div runat="server" id="ConfirmationMessage"></div>
    
    <%-- ajax update panel end --%>
    </ContentTemplate>
    </asp:UpdatePanel>

</asp:Content>


