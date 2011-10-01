<%@ Page Language="C#" MasterPageFile="~/Users/Admin/MasterPage.master" AutoEventWireup="True" Inherits="Admin_Edit_user" Title="Edit User Info" Codebehind="Edit_user.aspx.cs" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="~/Users/UserControls/adminUserNavLinks.ascx" TagName="adminUserNavLinks" TagPrefix="uc1" %>

<%-- content placeholder for header section --%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>

<%-- content placeholder body title --%>
<asp:Content ID="Content5" runat="server" contentplaceholderid="cphBodyTitle">
    Edit User Details
</asp:Content>

<%-- content placeholder user navigation --%>
<asp:Content ID="Content6" runat="server" contentplaceholderid="cphUserNavigation">
    
    <%-- user navigation include --%>
    <uc1:adminUserNavLinks ID="adminUserNavLinks1" runat="server" />
    
</asp:Content>

<%-- content placeholder for content body --%>
<asp:Content ID="Content7" runat="server" contentplaceholderid="cphContentBody">

    <%-- ajax update panel start --%>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>

            <%-- ajax tab container start --%>
            <cc1:TabContainer ID="tcntUserInfo" runat="server" ActiveTabIndex="1" 
                Width="100%" Font-Size="10px">
               
                <%-- first (1) tab................................................................. --%>
                <cc1:TabPanel ID="TabPanel1" runat="server" HeaderText="Create New Role">
                    <ContentTemplate>
                    <div style="font-size: 11px;">
                    
                        <%-- create new role --%>
                        <p></p>
                        <asp:TextBox runat="server" ID="NewRole" MaxLength="50" ToolTip="Type the name of a new role you want to create."></asp:TextBox>
                        <asp:Button ID="Button3" runat="server" OnClick="AddRole" Text="Add Role" ToolTip="Click to create new role." />
                        <p></p>
                        <%-- confirmation message --%>
                        <div runat="server" id="ConfirmationMessage"></div>
                    
                    </div>    
                    </ContentTemplate>
                </cc1:TabPanel>
                
                <%-- second (2) tab................................................................ --%>
                <cc1:TabPanel ID="TabPanel2" runat="server" HeaderText="General User Info">
                    <HeaderTemplate>
                        General User Info
                    </HeaderTemplate>
                    <ContentTemplate>
                    <div style="font-size: 11px;">
                    
                        <div class="checkboxList">
                            <asp:CheckBoxList ID="UserRoles" runat="server" RepeatDirection="Horizontal" />
                        </div>
                        
                        <br />
                        
                        <table>
                            <tr>
                                <td valign="top" style="width: 445px">
                                    <asp:DetailsView AutoGenerateRows="False" DataSourceID="MemberData" ID="UserInfo"
                                        runat="server" OnItemUpdating="UserInfo_ItemUpdating" DefaultMode="Edit" HeaderText="General User Info">
                                        <Fields>
                                            <asp:BoundField DataField="UserName" HeaderText="User Name" ReadOnly="True"></asp:BoundField>
                                            <asp:BoundField DataField="Email" HeaderText="Email"></asp:BoundField>
                                            <asp:BoundField DataField="Comment" HeaderText="Comment"></asp:BoundField>
                                            <asp:CheckBoxField DataField="IsApproved" HeaderText="Active User"></asp:CheckBoxField>
                                            <asp:CheckBoxField DataField="IsLockedOut" HeaderText="Is Locked Out" 
                                                ReadOnly="True">
                                            </asp:CheckBoxField>
                                            <asp:CheckBoxField DataField="IsOnline" HeaderText="Is Online" ReadOnly="True"></asp:CheckBoxField>
                                            <asp:BoundField DataField="CreationDate" HeaderText="CreationDate" ReadOnly="True">
                                            </asp:BoundField>
                                            <asp:BoundField DataField="LastActivityDate" HeaderText="LastActivityDate" ReadOnly="True">
                                            </asp:BoundField>
                                            <asp:BoundField DataField="LastLoginDate" HeaderText="LastLoginDate" ReadOnly="True">
                                            </asp:BoundField>
                                            <asp:BoundField DataField="LastLockoutDate" HeaderText="LastLockoutDate" ReadOnly="True">
                                            </asp:BoundField>
                                            <asp:BoundField DataField="LastPasswordChangedDate" HeaderText="LastPasswordChangedDate" ReadOnly="True"></asp:BoundField>
                                            <asp:TemplateField ShowHeader="False">
                                                <EditItemTemplate>
                                                    <asp:Button ID="Button1" runat="server" CausesValidation="True" CommandName="Update" Text="Update User" />
                                                    <asp:Button ID="Button2" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                                                    <asp:Button ID="Button4" runat="server" Text="Unlock User" OnClick="UnlockUser" OnClientClick="return confirm('Click OK to unlock this user.')" />
                                                    <asp:Button ID="Button5" runat="server" Text="Delete User" OnClick="DeleteUser" OnClientClick="return confirm('Are you sure? This will delete all information related to this user including the user profile.')" />
                                                </EditItemTemplate>
                                                <ItemTemplate>
                                                    <asp:Button ID="Button1" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit User Info" />
                                                </ItemTemplate>
                                                <ControlStyle Font-Size="11px" />
                                            </asp:TemplateField>
                                        </Fields>
                                    </asp:DetailsView>
                                    
                                    <div>
                                        <asp:Literal ID="UserUpdateMessage" runat="server"></asp:Literal>
                                    </div>
                                    
                                    <br />
                                    
                                    <asp:ObjectDataSource ID="MemberData" runat="server" DataObjectTypeName="System.Web.Security.MembershipUser"
                                        SelectMethod="GetUser" UpdateMethod="UpdateUser" TypeName="System.Web.Security.Membership">
                                        <SelectParameters>
                                            <asp:QueryStringParameter Name="username" QueryStringField="username" />
                                        </SelectParameters>
                                    </asp:ObjectDataSource>
                                    
                                </td>
                            </tr>
                        </table>
                    
                    </div>    
                    </ContentTemplate>
                </cc1:TabPanel>
                
                <%-- third (3) tab................................................................. --%>
                <cc1:TabPanel ID="TabPanel3" runat="server" HeaderText="User Profile">
                    <ContentTemplate>
                    <div style="font-size: 11px;">
                       
                        <p></p>
                        
                        <div class="formSectionTitle">Subscriptions</div>
                        
                        <p></p>
                        
                        <table cellpadding="2" style="width: 445px">
                            <tr>
                                <td width="130" class="formLabelsText">
                                    Newsletter:
                                </td>
                                <td width="300">
                                    <asp:DropDownList runat="server" ID="ddlNewsletter">
                                        <asp:ListItem Text="No subscription" Value="None" Selected="true" />
                                        <asp:ListItem Text="Subscribe to newsletter" Value="Html" />
                                    </asp:DropDownList>
                                </td>
                            </tr>
                        </table>
                        
                        <p></p>
                        
                        <div class="formSectionTitle">Personal</div>
                        
                        <p></p>
                        
                        <table cellpadding="2" style="width: 445px">
                            <tr>
                                <td width="130" class="formLabelsText">
                                    First name:
                                </td>
                                <td width="300">
                                    <asp:TextBox ID="txtFirstName" runat="server" Width="99%" MaxLength="50"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="formLabelsText">
                                    Last name:
                                </td>
                                <td>
                                    <asp:TextBox ID="txtLastName" runat="server" Width="99%" MaxLength="50" />
                                </td>
                            </tr>
                            <tr>
                                <td class="formLabelsText">
                                    Gender:
                                </td>
                                <td>
                                    <asp:DropDownList runat="server" ID="ddlGenders">
                                        <asp:ListItem Text="Please select one..." Selected="True" />
                                        <asp:ListItem Text="Male" Value="M" />
                                        <asp:ListItem Text="Female" Value="F" />
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td class="formLabelsText">
                                    Birth date:
                                </td>
                                <td>
                                    <asp:TextBox ID="txtBirthDate" runat="server" Width="99%"></asp:TextBox>
                                    
                                    <cc1:CalendarExtender ID="txtBirthDate_CalendarExtender" runat="server" TargetControlID="txtBirthDate" Enabled="True">
                                    </cc1:CalendarExtender>
                                    
                                    <asp:CompareValidator runat="server" ID="valBirthDateFormat" ControlToValidate="txtBirthDate" SetFocusOnError="True" Display="Dynamic" Operator="DataTypeCheck" Type="Date" ErrorMessage="The format of the birth date is not valid." ValidationGroup="EditProfile">
                                    <br />
                                    The format of the birth date is not valid.
                                    </asp:CompareValidator>
                                    
                                    <cc1:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtBirthDate"
                                        Mask="99/99/9999" MaskType="Date" CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder=""
                                        CultureDateFormat="" CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                        CultureTimePlaceholder="" Enabled="True" />
                                    <cc1:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlToValidate="txtBirthDate"
                                        ControlExtender="MaskedEditExtender1" Display="Dynamic" TooltipMessage="Please enter a date"
                                        EmptyValueMessage="Date must be in correct format" InvalidValueMessage="This date is invalid"
                                        ErrorMessage="MaskedEditValidator1" />
                                </td>
                            </tr>
                            <tr>
                                <td class="formLabelsText">
                                    Occupation:
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlOccupations" runat="server" Width="99%">
                                        <asp:ListItem Text="Please select one..." Selected="True" />
                                        <asp:ListItem Text="Academic" />
                                        <asp:ListItem Text="Accountant" />
                                        <asp:ListItem Text="Actor" />
                                        <asp:ListItem Text="Architect" />
                                        <asp:ListItem Text="Artist" />
                                        <asp:ListItem Text="Business Manager" />
                                        <asp:ListItem Text="Carpenter" />
                                        <asp:ListItem Text="Chief Executive" />
                                        <asp:ListItem Text="Cinematographer" />
                                        <asp:ListItem Text="Civil Servant" />
                                        <asp:ListItem Text="Coach" />
                                        <asp:ListItem Text="Composer" />
                                        <asp:ListItem Text="Computer programmer" />
                                        <asp:ListItem Text="Cook" />
                                        <asp:ListItem Text="Counsellor" />
                                        <asp:ListItem Text="Doctor" />
                                        <asp:ListItem Text="Driver" />
                                        <asp:ListItem Text="Economist" />
                                        <asp:ListItem Text="Editor" />
                                        <asp:ListItem Text="Electrician" />
                                        <asp:ListItem Text="Engineer" />
                                        <asp:ListItem Text="Executive Producer" />
                                        <asp:ListItem Text="Fixer" />
                                        <asp:ListItem Text="Graphic Designer" />
                                        <asp:ListItem Text="Hairdresser" />
                                        <asp:ListItem Text="Headhunter" />
                                        <asp:ListItem Text="HR - Recruitment" />
                                        <asp:ListItem Text="Information Officer" />
                                        <asp:ListItem Text="IT Consultant" />
                                        <asp:ListItem Text="Journalist" />
                                        <asp:ListItem Text="Lawyer / Solicitor" />
                                        <asp:ListItem Text="Lecturer" />
                                        <asp:ListItem Text="Librarian" />
                                        <asp:ListItem Text="Mechanic" />
                                        <asp:ListItem Text="Model" />
                                        <asp:ListItem Text="Musician" />
                                        <asp:ListItem Text="Office Worker" />
                                        <asp:ListItem Text="Performer" />
                                        <asp:ListItem Text="Photographer" />
                                        <asp:ListItem Text="Presenter" />
                                        <asp:ListItem Text="Producer / Director" />
                                        <asp:ListItem Text="Project Manager" />
                                        <asp:ListItem Text="Researcher" />
                                        <asp:ListItem Text="Salesman" />
                                        <asp:ListItem Text="Social Worker" />
                                        <asp:ListItem Text="Soldier" />
                                        <asp:ListItem Text="Sportsperson" />
                                        <asp:ListItem Text="Student" />
                                        <asp:ListItem Text="Teacher" />
                                        <asp:ListItem Text="Technical Crew" />
                                        <asp:ListItem Text="Technical Writer" />
                                        <asp:ListItem Text="Therapist" />
                                        <asp:ListItem Text="Translator" />
                                        <asp:ListItem Text="Waitress / Waiter" />
                                        <asp:ListItem Text="Web designer / author" />
                                        <asp:ListItem Text="Writer" />
                                        <asp:ListItem Text="Other" />
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td class="formLabelsText">
                                    Website:
                                </td>
                                <td>
                                    <asp:TextBox ID="txtWebsite" runat="server" Width="99%" MaxLength="200" />
                                </td>
                            </tr>
                        </table>
                        
                        <p></p>
                        
                        <div class="formSectionTitle">Address</div>
                        
                        <p></p>
                        
                        <table cellpadding="2" style="width: 445px">
                            <tr>
                                <td width="130" class="formLabelsText">
                                    Country:
                                </td>
                                <td width="300">
                                    <asp:DropDownList ID="ddlCountries" runat="server" AppendDataBoundItems="True" Width="99%">
                                        <asp:ListItem Selected="True" Text="Please select one..." />
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td width="130" class="formLabelsText">
                                    Address:
                                </td>
                                <td width="300">
                                    <asp:TextBox runat="server" ID="txtAddress" Width="99%" MaxLength="100" />
                                </td>
                            </tr>
                            <tr>
                                <td class="formLabelsText">
                                    Apartment Number:
                                </td>
                                <td>
                                    <asp:TextBox runat="server" ID="txtAptNumber" Width="99%" MaxLength="50" />
                                </td>
                            </tr>
                            <tr>
                                <td class="formLabelsText">
                                    City:
                                </td>
                                <td>
                                    <asp:TextBox runat="server" ID="txtCity" Width="99%" MaxLength="100" />
                                </td>
                            </tr>
                            <tr>
                                <td class="formLabelsText">
                                    State / Region:
                                </td>
                                <td>
                                    <asp:TextBox runat="server" ID="txtState" Width="99%" MaxLength="100" />
                                </td>
                            </tr>
                            <tr>
                                <td class="formLabelsText">
                                    Zip / Postal code:
                                </td>
                                <td>
                                    <asp:TextBox runat="server" ID="txtPostalCode" Width="99%" MaxLength="20" />
                                </td>
                            </tr>
                        </table>
                        
                        <p></p>
                        
                        <div class="formSectionTitle">Contact Info</div>
                            
                        <p></p>
                        
                        <table cellpadding="2">
                            <tr>
                                <td width="130" class="formLabelsText">
                                    Day Time Phone:
                                </td>
                                <td width="300">
                                    <asp:TextBox runat="server" ID="txtDayTimePhone" Width="99%" MaxLength="20" />
                                </td>
                            </tr>
                            <tr>
                                <td width="130" class="formLabelsText">
                                    Day Time Phone Ext.:
                                </td>
                                <td width="300">
                                    <asp:TextBox runat="server" ID="txtDayTimePhoneExt" Width="99%" MaxLength="10" />
                                </td>
                            </tr>
                            <tr>
                                <td width="130" class="formLabelsText">
                                    Evening Phone:
                                </td>
                                <td width="300">
                                    <asp:TextBox runat="server" ID="txtEveningPhone" Width="99%" MaxLength="20" />
                                </td>
                            </tr>
                            <tr>
                                <td width="130" class="formLabelsText">
                                    Evening Phone Ext.:
                                </td>
                                <td width="300">
                                    <asp:TextBox runat="server" ID="txtEveningPhoneExt" Width="99%" MaxLength="10" />
                                </td>
                            </tr>
                            <tr>
                                <td width="130" class="formLabelsText">
                                    Cell Phone:
                                </td>
                                <td width="300">
                                    <asp:TextBox runat="server" ID="txtCellPhone" Width="99%" MaxLength="20" />
                                </td>
                            </tr>
                            <tr>
                                <td width="130" class="formLabelsText">
                                    Business Fax:
                                </td>
                                <td width="300">
                                    <asp:TextBox runat="server" ID="txtBusinessFax" Width="99%" MaxLength="20" />
                                </td>
                            </tr>
                            <tr>
                                <td width="130" class="formLabelsText">
                                    Home Fax:
                                </td>
                                <td width="300">
                                    <asp:TextBox runat="server" ID="txtHomeFax" Width="99%" MaxLength="20" />
                                </td>
                            </tr>
                            <tr>
                                <td width="130">
                                    &nbsp;
                                </td>
                                <td width="300">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td width="130" colspan="2" style="width: 430px">
                                    <asp:Button ID="btnUpdateProfile" runat="server" Text="Update Profile" ValidationGroup="EditProfile" OnClick="btnUpdateProfile_Click" />
                                    <asp:Button ID="btnDeleteProfile" runat="server" OnClick="btnDeleteProfile_Click" OnClientClick="return confirm('Are Your Sure?')" Text="Delete Profile" />
                                    &nbsp;
                                    <asp:Label ID="lblProfileMessage" runat="server" />
                                </td>
                            </tr>
                        </table>
                    
                    </div>     
                    </ContentTemplate>
                </cc1:TabPanel>
                
                <%-- fourth (4) tab................................................................. --%>
                <cc1:TabPanel ID="TabPanel4" runat="server" HeaderText="Change Password">
                <ContentTemplate>
                    <div style="font-size: 11px;">
                    
                        <p></p>
                        
                          <table cellpadding="3" border="0">
                            <tr>
                              <td>Current Password:</td>
                              <td><asp:Textbox id="OldPasswordTextbox" runat="server" TextMode="Password" /></td>
                              <td><asp:RequiredFieldValidator id="OldPasswordRequiredValidator" runat="server" 
                                      ControlToValidate="OldPasswordTextbox" ErrorMessage="Required" 
                                      ValidationGroup="changepassword" /></td>
                            </tr>
                            <tr>
                              <td>New Password:</td>
                              <td><asp:Textbox id="PasswordTextbox" runat="server" TextMode="Password" /></td>
                              <td><asp:RequiredFieldValidator id="PasswordRequiredValidator" runat="server" 
                                      ControlToValidate="PasswordTextbox" ErrorMessage="Required" 
                                      ValidationGroup="changepassword" /></td>
                            </tr>
                            <tr>
                              <td>Confirm Password:</td>
                              <td><asp:Textbox id="PasswordConfirmTextbox" runat="server" TextMode="Password" /></td>
                              <td><asp:RequiredFieldValidator id="PasswordConfirmRequiredValidator" 
                                      runat="server" ControlToValidate="PasswordConfirmTextbox" 
                                      ErrorMessage="Required" ValidationGroup="changepassword" />
                                  <asp:CompareValidator id="PasswordConfirmCompareValidator" runat="server" 
                                      ControlToValidate="PasswordConfirmTextbox" ControlToCompare="PasswordTextBox" 
                                      ErrorMessage="Confirm password must match password." 
                                      ValidationGroup="changepassword" />
                              </td>
                            </tr>
                            <tr>
                              <td></td>
                              <td><asp:Button id="ChangePasswordButton" Text="Change Password" 
                                      OnClick="ChangePassword_OnClick" runat="server" 
                                      ValidationGroup="changepassword" /></td>
                            </tr>
                              <tr>
                                  <td>Current Password:</td>
                                  <td><asp:Label ID="lblCurrentPassword" runat="server" EnableViewState="False"></asp:Label></td>
                              </tr>
                          </table>
                          
                          <p></p>
                          
                          <asp:Label id="Msg" ForeColor="Maroon" runat="server" />
                                                   
                    </div>    
                    </ContentTemplate>
                </cc1:TabPanel>
            
            </cc1:TabContainer>
            
            <br />
            
            <%-- ajax update panel end --%>
        </ContentTemplate>
    </asp:UpdatePanel>
    
</asp:Content>