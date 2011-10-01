<%@ Page Language="C#" MasterPageFile="~/Users/Users.master" AutoEventWireup="True" Inherits="Members_MyAccountInfo" Title="Untitled Page" Codebehind="MyAccountInfo.aspx.cs" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <%-- ajax script manager --%>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    
    <%-- ajax update panel start --%>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>

            <%-- ajax tab container start --%>
            <cc1:TabContainer ID="tcntUserInfo" runat="server" ActiveTabIndex="1" 
                Width="100%" Font-Size="10px">
               
                <cc1:TabPanel ID="TabPanel1" runat="server" HeaderText="Change Password">
                    <ContentTemplate>
                    <div style="font-size: 11px;">
                    
                    <p></p>
                    
                    <asp:ChangePassword ID="ChangePassword1" runat="server" EnableViewState="False" ContinueDestinationPageUrl="~/Users/Members/Default.aspx" Width="425px">
                        <MailDefinition BodyFileName="~/Users/EmailTemplates/ChangePassword.htm" IsBodyHtml="True" Subject="Your password has been changed!">
                        </MailDefinition>
                    </asp:ChangePassword>
                    
                    </div>    
                    </ContentTemplate>
                </cc1:TabPanel>
                
                <cc1:TabPanel ID="TabPanel2" runat="server" HeaderText="Change Email">
                    <ContentTemplate>
                    <div style="font-size: 11px;">
                        
                        <p></p>
                        
                        <asp:DetailsView AutoGenerateRows="False" DataSourceID="ObjectDataSource1" ID="DetailsView1" runat="server" OnItemUpdating="DetailsView1_ItemUpdating" Width="445px">
                          <Fields>
                              <asp:BoundField DataField="UserName" HeaderText="UserName" ReadOnly="True" SortExpression="UserName">
                                  <HeaderStyle Font-Bold="True" />
                                  <ItemStyle Font-Bold="True" />
                              </asp:BoundField>
                              <asp:TemplateField HeaderText="Email" SortExpression="Email">
                                  <EditItemTemplate>
                                      <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Email") %>'></asp:TextBox>
                                      <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="TextBox1" Display="Dynamic" ErrorMessage="Email only!" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                      <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBox1" Display="Dynamic" ErrorMessage="Email is required!" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                  </EditItemTemplate>
                                  <InsertItemTemplate>
                                      <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Email") %>'></asp:TextBox>
                                  </InsertItemTemplate>
                                  <ItemTemplate>
                                      <asp:Label ID="Label1" runat="server" Text='<%# Bind("Email") %>'></asp:Label>
                                  </ItemTemplate>
                              </asp:TemplateField>
                              <asp:BoundField DataField="CreationDate" HeaderText="Creation Date" SortExpression="CreationDate" ReadOnly="True">
                              </asp:BoundField>
                              <asp:BoundField DataField="LastActivityDate" HeaderText="Last Activity Date" SortExpression="LastActivityDate" ReadOnly="True"></asp:BoundField>
                              <asp:CheckBoxField DataField="IsOnline" HeaderText="Online?" SortExpression="IsOnline" ReadOnly="True"></asp:CheckBoxField>
                              <asp:CheckBoxField DataField="IsApproved" HeaderText="Approved?" SortExpression="IsApproved" ReadOnly="True"></asp:CheckBoxField>
                              <asp:CheckBoxField DataField="IsLockedOut" HeaderText="Locked Out?" SortExpression="IsLockedOut" ReadOnly="True"></asp:CheckBoxField>
                              <asp:BoundField DataField="PasswordQuestion" HeaderText="Password Question" ReadOnly="True" SortExpression="PasswordQuestion"></asp:BoundField>
                              <asp:BoundField DataField="LastLoginDate" HeaderText="Last Login Date" SortExpression="LastLoginDate" ReadOnly="True">
                              </asp:BoundField>
                              <asp:BoundField DataField="LastLockoutDate" HeaderText="Last Lockout Date" ReadOnly="True" SortExpression="LastLockoutDate"></asp:BoundField>
                              <asp:BoundField DataField="LastPasswordChangedDate" HeaderText="Last Password Changed Date" ReadOnly="True" SortExpression="LastPasswordChangedDate"></asp:BoundField>
                              <asp:CommandField ButtonType="Button" ShowEditButton="True">
                                  <ControlStyle Font-Size="11px" />
                              </asp:CommandField>
                          </Fields>
                      </asp:DetailsView>
                      
                      <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" DataObjectTypeName="System.Web.Security.MembershipUser" SelectMethod="GetUser" TypeName="System.Web.Security.Membership"></asp:ObjectDataSource> 
                      <br />
                      <br />
                      <asp:Button ID="btnDeleteCurrentUser" Runat="server" Text="Close and delete my account" OnClick="btnDeleteCurrentUser_Click" OnClientClick="return confirm('Are you sure? This action will delete all your information and is unrecoverable.');" />
                      <br />
                      <asp:Label id="lblResult" Runat="server" Visible="False" BackColor="Red" />
 
                    </div>    
                    </ContentTemplate>
                </cc1:TabPanel>
                
                <cc1:TabPanel ID="TabPanel3" runat="server" HeaderText="Edit My Profile">
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
            
            </cc1:TabContainer>
            
            <p></p>
            <asp:LoginStatus ID="LoginStatus1" runat="server" LogoutText="Logout (temporary for testing)" />
            
            <%-- ajax update panel end --%>
        </ContentTemplate>
    </asp:UpdatePanel>
            
</asp:Content>

