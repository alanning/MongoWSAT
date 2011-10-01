<%@ Page Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" Inherits="Login" Title="Registered Users Login" Codebehind="Login.aspx.cs" %>
<%--@ Register TagPrefix="cc1" Namespace="WebControlCaptcha" Assembly="WebControlCaptcha" --%>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>

<%-- content placeholder --%>
<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="Server">

    <div>
        <asp:HyperLink ID="lnkRegister" runat="server" NavigateUrl="~/Users/Register.aspx">Not registered yet? Go!</asp:HyperLink>
        <br />

        <asp:Login ID="Login1" DestinationPageUrl="/AfterLogin" runat="server" CssSelectorClass="PrettyLogin" RememberMeSet="True" OnAuthenticate="Login1_Authenticate" OnLoginError="Login1_LoginError">
        </asp:Login>

        <div>
            <br />
            <asp:HyperLink ID="lnkLostPassword" runat="server" NavigateUrl="~/Users/RecoverPassword.aspx">Lost password? Click Here to Recover.</asp:HyperLink>
        </div>
    </div>
<%--

            <LayoutTemplate>
                <table border="0" cellpadding="1" cellspacing="0" 
                    style="border-collapse: collapse" align="center">
                    <tr>
                        <td align="right">
                            &nbsp;
                        </td>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName" Font-Bold="True">User Name:</asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="UserName" runat="server" TabIndex="1"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName" ErrorMessage="User Name is required." ToolTip="User Name is required." ValidationGroup="Login1">*</asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password" Font-Bold="True">Password:</asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="Password" runat="server" TabIndex="2" TextMode="Password"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password" ErrorMessage="Password is required." ToolTip="Password is required." ValidationGroup="Login1">*</asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <asp:CheckBox ID="RememberMe" runat="server" TabIndex="4" Text="Remember me next time." />
                        </td>
                    </tr>
                    <tr>
                        <td align="center" colspan="2">
                            <asp:Button ID="LoginButton" runat="server" CommandName="Login" TabIndex="5" Text="Log In" ValidationGroup="Login1" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            &nbsp;
                            <asp:HyperLink ID="lnkRegister" runat="server" NavigateUrl="~/Users/Register.aspx">Not registered yet? Go!</asp:HyperLink>
                            <br />
                            &nbsp;
                            <asp:HyperLink ID="lnkLostPassword" runat="server" NavigateUrl="~/Users/RecoverPassword.aspx">Lost password?</asp:HyperLink>
                            <br />
                            <br />
                        </td>
                    </tr>
                </table>
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True" ShowSummary="False" ValidationGroup="Login1" />
            </LayoutTemplate>

 --%>
</asp:Content>
