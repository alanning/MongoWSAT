<%@ Page Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" Inherits="RecoverPassword" Title="Password Reset" Codebehind="RecoverPassword.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>

<%-- content placeholder --%>
<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="Server">
    <%-- password recovery control --%>
    <asp:PasswordRecovery ID="PasswordRecovery1" runat="server" OnSendingMail="PasswordRecovery1_SendingMail">
        <MailDefinition BodyFileName="~/Users/EmailTemplates/PasswordRecovery.txt" Subject="Password recovery">
        </MailDefinition>
        <UserNameTemplate>
            <table border="0" cellpadding="10" cellspacing="0" 
                style="border-collapse: collapse;" width="100%">
                <tr>
                    <td>
                        <table border="0" cellpadding="0" style="width: 100%;">
                            <tr>
                                <td align="center" colspan="2">
                                    Forgot Your Password?
                                </td>
                            </tr>
                            <tr>
                                <td align="center" colspan="2">
                                    Enter your User Name to receive your password.
                                </td>
                            </tr>
                            <tr>
                                <td align="right" style="width: 81px">
                                    <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName">User 
                                    Name:</asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="UserName" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName" ErrorMessage="User Name is required." ToolTip="User Name is required." ValidationGroup="PasswordRecovery1">*</asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="center" colspan="2" style="color: Red;">
                                    <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" colspan="2">
                                    <asp:Button ID="SubmitButton" runat="server" CommandName="Submit" Font-Size="10px" Text="Submit" ValidationGroup="PasswordRecovery1" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </UserNameTemplate>
    </asp:PasswordRecovery>
</asp:Content>
