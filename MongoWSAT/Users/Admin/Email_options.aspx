<%@ Page Language="C#" MasterPageFile="~/Users/Admin/MasterPage.master" AutoEventWireup="True" Inherits="Admin_Email_options" Title="Quick Email Options" Codebehind="Email_options.aspx.cs" %>
<%@ Register src="~/Users/UserControls/adminUserNavLinks.ascx" tagname="adminUserNavLinks" tagprefix="uc1" %>

<%-- content placeholder for head section --%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>

<%-- content placeholder for body title --%>
<asp:Content ID="Content5" runat="server" contentplaceholderid="cphBodyTitle">
    Quick Email Options
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
    
    <%-- section header --%>
    <div class="formSectionTitle">Current SMTP Address</div>
    
    <br />
    
    <%-- SMTP GridView --%>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="smtpID" DataSourceID="objSmtpDataSource">
        <Columns>
            <asp:TemplateField>
                <HeaderStyle CssClass="gridheaderBG" Width="1px" />
                <ItemStyle CssClass="gridheaderBG" Width="1px" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Details" ShowHeader="False">
                <EditItemTemplate>
                    <asp:Button ID="Button1" runat="server" CausesValidation="True" CommandName="Update" Text="Update" Width="45px" />
                    <asp:Button ID="Button2" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" Width="45px" />
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Button ID="Button1" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" Width="45px" />
                    <asp:Button ID="Button2" runat="server" CausesValidation="False" CommandName="Delete" Width="45px" OnClientClick="return confirm('Do you want to delete the selected item? This action connot be reversed.');" Text="Delete" />
                </ItemTemplate>
                <ControlStyle Font-Size="10px" />
                <HeaderStyle Width="100px" />
                <ItemStyle Width="100px" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="SMTP Address" SortExpression="smtpClient">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("smtpClient") %>' MaxLength="100"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="SMTP address cannot be empty!" ControlToValidate="TextBox1">*</asp:RequiredFieldValidator>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("smtpClient") %>'></asp:Label>
                </ItemTemplate>
                <HeaderStyle Width="200px" />
                <ItemStyle Width="200px" />
            </asp:TemplateField>
            <asp:TemplateField></asp:TemplateField>
        </Columns>
    </asp:GridView>
    
    <%-- SMTP GridView DataSource --%>
    <asp:ObjectDataSource ID="objSmtpDataSource" runat="server" DeleteMethod="SmtpDeleteQuery" OldValuesParameterFormatString="original_{0}" SelectMethod="GetBySMTP" TypeName="DataSet1TableAdapters.smtpClientTableAdapter" UpdateMethod="SmtpUpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="Original_smtpID" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="smtpClient" Type="String" />
            <asp:Parameter Name="Original_smtpID" Type="Int32" />
        </UpdateParameters>
    </asp:ObjectDataSource>
    
    <%-- help description --%>
    <div class="adminHelp2">
        The <span style="text-decoration: underline">current SMTP Address</span> is used 
        by the Quick Email application.
    </div>
    
    <%-- validation summary for objSmtpData GridView --%>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" />
        
    <%-- section header --%>
    <div class="formSectionTitle">FROM Email Addresses</div>
    
    <br /> 
    
    <%-- From Emails GridView --%>
    <asp:GridView ID="GridView2" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="EmailFromID" DataSourceID="objFromEmailDataSource">
        <Columns>
            <asp:TemplateField>
                <HeaderStyle CssClass="gridheaderBG" Width="1px" />
                <ItemStyle CssClass="gridheaderBG" Width="1px" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Details" ShowHeader="False">
                <EditItemTemplate>
                    <asp:Button ID="Button1" runat="server" CausesValidation="True" CommandName="Update" Text="Update" Width="45px" />
                    <asp:Button ID="Button2" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" Width="45px" />
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Button ID="Button1" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" Width="45px" />
                    <asp:Button ID="Button2" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" Width="45px" OnClientClick="return confirm('Do you want to delete the selected item? This action connot be reversed.');" />
                </ItemTemplate>
                <ControlStyle Font-Size="10px" />
                <HeaderStyle Width="100px" />
                <ItemStyle Width="100px" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Email &quot;From&quot; Address" SortExpression="EmailAddress">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("EmailAddress") %>'></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="FROM address cannot be empty!" ControlToValidate="TextBox1">*</asp:RequiredFieldValidator>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("EmailAddress") %>'></asp:Label>
                </ItemTemplate>
                <HeaderStyle Width="200px" />
                <ItemStyle Width="200px" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Description" SortExpression="Description">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Description") %>' MaxLength="100" Rows="3" TextMode="MultiLine" Width="98%"></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("Description") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    
    <%-- From Emails DataSource --%>         
    <asp:ObjectDataSource ID="objFromEmailDataSource" runat="server" DeleteMethod="EmailFomDeleteQuery" InsertMethod="EmailFromInsertQuery" OldValuesParameterFormatString="original_{0}" SelectMethod="GetByFromEmail" TypeName="DataSet1TableAdapters.EmailFromTableAdapter" UpdateMethod="EmailFromUpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="Original_EmailFromID" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="EmailAddress" Type="String" />
            <asp:Parameter Name="Description" Type="String" />
            <asp:Parameter Name="Original_EmailFromID" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="EmailAddress" Type="String" />
            <asp:Parameter Name="Description" Type="String" />
        </InsertParameters>
    </asp:ObjectDataSource>  
            
    <%-- help description --%>
    <div class="adminHelp2">
        The Email &quot;From&quot; Address provides easy selection option on the Quick Email 
        interface to select the appropriate from/return address when sending email from 
        the application.
    </div>
        
    <%-- section header --%>
    <div class="formSectionTitle">New FROM Email Address</div>

    <br /> 
    
    <%-- Create New FROM address form --%>
    <asp:DetailsView ID="DetailsView_EmailFrom" runat="server" DataKeyNames="EmailFromID" DataSourceID="objFromEmailDataSource" HeaderText="Create New &quot;From&quot; Address" DefaultMode="Insert">
        <EmptyDataTemplate>
            No return address found.
        </EmptyDataTemplate>
        <Fields>
            <asp:TemplateField HeaderText="&nbsp;From Address:" SortExpression="EmailAddress">
                <InsertItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("EmailAddress") %>'></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator_NewRole" runat="server" ControlToValidate="TextBox1" EnableViewState="False" ErrorMessage="Email From cannot be empty" ValidationGroup="NewAddress">*</asp:RequiredFieldValidator>
                </InsertItemTemplate>
                <HeaderStyle Width="100px" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="&nbsp;Description:" SortExpression="Description">
                <InsertItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Description") %>' MaxLength="200" Rows="3" TextMode="MultiLine" Width="98%"></asp:TextBox>
                </InsertItemTemplate>
            </asp:TemplateField>
            <asp:CommandField ButtonType="Button" ShowInsertButton="True" ValidationGroup="NewAddress">
                <ControlStyle Font-Size="10px" />
            </asp:CommandField>
        </Fields>
    </asp:DetailsView>    

    <%-- ajax update panel end --%>
    </ContentTemplate>
    </asp:UpdatePanel>

</asp:Content>


