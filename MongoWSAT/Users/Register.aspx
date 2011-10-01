<%@ Page Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" Inherits="Register" Title="Register For New Account" Codebehind="Register.aspx.cs" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="Server">

<h2 style="font-size:larger;font-weight:bold;">Account Registration</h2>

<br />


    <asp:CreateUserWizard ID="CreateUserWizard1" runat="server" 

        ContinueDestinationPageUrl="~/Users/Login.aspx" 
        OnCreatingUser="CreateUserWizard1_CreatingUser" 
        onsendingmail="CreateUserWizard1_SendingMail" 
        DisableCreatedUser="True" 
        LoginCreatedUser="False" 
        CssSelectorClass="PrettyCreateUserWizard"
        HeaderText="New User Account" 
        CompleteSuccessText="Your account has been successfully created and a confirmation email has been sent to you. Please click on the link in this email to activate your account.">
        <MailDefinition BodyFileName="~/Users/EmailTemplates/CreateUserWizard.txt" Subject="Your new membership is almost complete! ">
        </MailDefinition>
        <WizardSteps>
            <asp:CreateUserWizardStep runat="server" >
                <ContentTemplate>
                    <table style="width: 100%">
                        <tr>
                            <td align="left" colspan="2" style="font-size: 12px">
                            Sign Up for Your New Account
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName">
                                User Name:*
                                </asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="UserName" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" 
                                    ControlToValidate="UserName" 
                                    ErrorMessage="User Name is required." 
                                    ToolTip="User Name is required." 
                                    ValidationGroup="CreateUserWizard1">
                                    *
                                 </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password">
                                    Password:*
                                </asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="Password" runat="server" TextMode="Password"></asp:TextBox>
                                <cc1:PasswordStrength ID="Password_PasswordStrength" runat="server" 
                                    TargetControlID="Password" MinimumNumericCharacters="1" 
                                    PreferredPasswordLength="7" TextCssClass="passwordStrengthIndicator" 
                                    TextStrengthDescriptions="Very Poor;Weak;Average;Strong;Excellent" 
                                    MinimumSymbolCharacters="1">
                                </cc1:PasswordStrength>
                                <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" 
                                    ControlToValidate="Password" ErrorMessage="Password is required." 
                                    ToolTip="Password is required." ValidationGroup="CreateUserWizard1">
                                    *
                                </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                <asp:Label ID="ConfirmPasswordLabel" runat="server" 
                                    AssociatedControlID="ConfirmPassword">
                                    Confirm Password:*
                                 </asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="ConfirmPassword" runat="server" TextMode="Password"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="ConfirmPasswordRequired" runat="server" 
                                    ControlToValidate="ConfirmPassword" 
                                    ErrorMessage="Confirm Password is required." 
                                    ToolTip="Confirm Password is required." 
                                    ValidationGroup="CreateUserWizard1">
                                    *
                                </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                <asp:Label ID="EmailLabel" runat="server" AssociatedControlID="Email">
                                    E-mail:*
                                </asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="Email" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="EmailRequired" runat="server" 
                                    ControlToValidate="Email" ErrorMessage="E-mail is required." 
                                    ToolTip="E-mail is required." ValidationGroup="CreateUserWizard1">
                                    *
                                </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                <asp:Label ID="QuestionLabel" runat="server" AssociatedControlID="Question">
                                    Security Question:*
                                </asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="Question" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="QuestionRequired" runat="server" 
                                    ControlToValidate="Question" ErrorMessage="Security question is required." 
                                    ToolTip="Security question is required." ValidationGroup="CreateUserWizard1">
                                    *
                                 </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                <asp:Label ID="AnswerLabel" runat="server" AssociatedControlID="Answer">
                                    Security Answer:*
                                </asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="Answer" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="AnswerRequired" runat="server" 
                                    ControlToValidate="Answer" ErrorMessage="Security answer is required." 
                                    ToolTip="Security answer is required." ValidationGroup="CreateUserWizard1">
                                    *
                                </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td align="center" colspan="2">
                                <asp:CompareValidator ID="PasswordCompare" runat="server" 
                                    ControlToCompare="Password" ControlToValidate="ConfirmPassword" 
                                    Display="Dynamic" 
                                    ErrorMessage="The Password and Confirmation Password must match." 
                                    ValidationGroup="CreateUserWizard1">
                                </asp:CompareValidator>
                            </td>
                        </tr>
                        <tr>
                            <td align="center" colspan="2" style="color:Red;">
                                <asp:Literal ID="ErrorMessage" runat="server" EnableViewState="False">
                                </asp:Literal>
                            </td>
                        </tr>
                    </table>
                </ContentTemplate>
            </asp:CreateUserWizardStep>
            <asp:CompleteWizardStep runat="server" />
        </WizardSteps>
    </asp:CreateUserWizard>
    <br />
    <asp:Label ID="InvalidUserNameOrPasswordMessage" runat="server"  
        Visible="false" 
        ForeColor="Red"
        EnableViewState="false">
    </asp:Label>

    
</asp:Content>
