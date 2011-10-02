<%@ Page Language="C#" MasterPageFile="~/Users/Admin/MasterPage.master" AutoEventWireup="True" Inherits="Admin_Quick_contact" Title="Quick Email" Codebehind="Quick_contact.aspx.cs" %>
<%@ Register src="~/Users/UserControls/adminUserNavLinks.ascx" tagname="adminUserNavLinks" tagprefix="uc1" %>
<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit" %>

<%-- content placeholder for head section --%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

<%-- greybox modal popup javascript sources --%>
<script language="javascript" type="text/javascript">
    var GB_ROOT_DIR = "../greybox/";
</script>
<script type="text/javascript" src="../greybox/AJS.js"></script>
<script type="text/javascript" src="../greybox/AJS_fx.js"></script>
<script type="text/javascript" src="../greybox/gb_scripts.js"></script>
<link href="../greybox/gb_styles.css" rel="stylesheet" type="text/css" />

</asp:Content>

<%-- content placeholder for body title --%>
<asp:Content ID="Content5" runat="server" contentplaceholderid="cphBodyTitle">
    Quick Email
</asp:Content>

<%-- content placeholder for user navigation --%>
<asp:Content ID="Content6" runat="server" contentplaceholderid="cphUserNavigation">
    <%-- user navigation include --%>
    <uc1:adminUserNavLinks ID="adminUserNavLinks1" runat="server" />
</asp:Content>

<%-- content placeholder for content body --%>
<asp:Content ID="Content7" runat="server" contentplaceholderid="cphContentBody">


<%-- a-z email recipients --%>
    <div align="center" class="aTozNavigaion"><a href="quick_contact.aspx?letter=%" title="Show all users">All</a></div>
    <div align="center" class="aTozNavigaion"><a href="quick_contact.aspx?letter=A" title="Email starts with A">A</a></div>
    <div align="center" class="aTozNavigaion"><a href="quick_contact.aspx?letter=B" title="Email starts with B">B</a></div>
    <div align="center" class="aTozNavigaion"><a href="quick_contact.aspx?letter=C" title="Email starts with C">C</a></div>
    <div align="center" class="aTozNavigaion"><a href="quick_contact.aspx?letter=D" title="Email starts with D">D</a></div>
    <div align="center" class="aTozNavigaion"><a href="quick_contact.aspx?letter=E" title="Email starts with E">E</a></div>
    <div align="center" class="aTozNavigaion"><a href="quick_contact.aspx?letter=F" title="Email starts with F">F</a></div>
    <div align="center" class="aTozNavigaion"><a href="quick_contact.aspx?letter=G" title="Email starts with G">G</a></div>
    <div align="center" class="aTozNavigaion"><a href="quick_contact.aspx?letter=H" title="Email starts with H">H</a></div>
    <div align="center" class="aTozNavigaion"><a href="quick_contact.aspx?letter=I" title="Email starts with I">I</a></div>
    <div align="center" class="aTozNavigaion"><a href="quick_contact.aspx?letter=J" title="Email starts with J">J</a></div>
    <div align="center" class="aTozNavigaion"><a href="quick_contact.aspx?letter=K" title="Email starts with K">K</a></div>
    <div align="center" class="aTozNavigaion"><a href="quick_contact.aspx?letter=L" title="Email starts with L">L</a></div>
    <div align="center" class="aTozNavigaion"><a href="quick_contact.aspx?letter=M" title="Email starts with M">M</a></div>
    <div align="center" class="aTozNavigaion"><a href="quick_contact.aspx?letter=N" title="Email starts with N">N</a></div>
    <div align="center" class="aTozNavigaion"><a href="quick_contact.aspx?letter=O" title="Email starts with O">O</a></div>
    <div align="center" class="aTozNavigaion"><a href="quick_contact.aspx?letter=P" title="Email starts with P">P</a></div>
    <div align="center" class="aTozNavigaion"><a href="quick_contact.aspx?letter=Q" title="Email starts with Q">Q</a></div>
    <div align="center" class="aTozNavigaion"><a href="quick_contact.aspx?letter=R" title="Email starts with R">R</a></div>
    <div align="center" class="aTozNavigaion"><a href="quick_contact.aspx?letter=S" title="Email starts with S">S</a></div>
    <div align="center" class="aTozNavigaion"><a href="quick_contact.aspx?letter=T" title="Email starts with T">T</a></div>
    <div align="center" class="aTozNavigaion"><a href="quick_contact.aspx?letter=U" title="Email starts with U">U</a></div>
    <div align="center" class="aTozNavigaion"><a href="quick_contact.aspx?letter=V" title="Email starts with V">V</a></div>
    <div align="center" class="aTozNavigaion"><a href="quick_contact.aspx?letter=W" title="Email starts with W">W</a></div>
    <div align="center" class="aTozNavigaion"><a href="quick_contact.aspx?letter=X" title="Email starts with X">X</a></div>
    <div align="center" class="aTozNavigaion"><a href="quick_contact.aspx?letter=Y" title="Email starts with Y">Y</a></div>
    <div align="center" class="aTozNavigaion"><a href="quick_contact.aspx?letter=Z" title="Email starts with Z">Z</a></div>
    <asp:Label ID="lbl_SendResults" runat="server" EnableViewState="False" Style="color: #FF0000"></asp:Label>
    <br />
    <br />
    
    <%-- email header  --%>
    <div class="EmailHeader">
        <asp:Button ID="btnSendEmail" runat="server" Font-Size="10px" Text="Send Email" OnClick="btnSendEmail_Click" ToolTip="Click to send email. Remember to select at least one recipient checkbox!" />
        <asp:Button ID="btnSelectAll" runat="server" Font-Size="10px" Text="Check All" CausesValidation="False" onclick="btnSelectAll_Click" ToolTip="Click to select all checkboxes visible on page." />
        <asp:Button ID="btnUnselectAll" runat="server" Font-Size="10px" Text="Uncheck All" CausesValidation="False" onclick="btnUnselectAll_Click" ToolTip="Click to uncheck all checkboxes." />
        <%-- <asp:Button ID="btn_EmailOptions" runat="server" CausesValidation="False" Font-Size="10px" PostBackUrl="~/Users/Admin/email_options.aspx" Text="Options" ToolTip="Click to configure SMTP and FROM email addresses." />--%>
        <asp:RadioButtonList ID="rbt_BodyTextType" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow" Style="font-size: xx-small; color: #000000;" ToolTip="HTML or Palin Text Email?">
            <asp:ListItem Selected="True" Value="True">html</asp:ListItem>
            <asp:ListItem Value="False">plain text</asp:ListItem>
        </asp:RadioButtonList>
        &nbsp;|
        <asp:RadioButtonList ID="rbt_Importance" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow" Style="font-size: xx-small; color: #000000;" ToolTip="Select Email Priority">
            <asp:ListItem Value="High">high</asp:ListItem>
            <asp:ListItem Selected="True" Value="Normal">default</asp:ListItem>
            <asp:ListItem Value="Low">low</asp:ListItem>
        </asp:RadioButtonList>
    </div>
    
    <%-- gridview to display users by email  --%>
    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataSourceID="UsersList" DataKeyNames="Email" PageSize="8" EmptyDataText="No records found for the indicated search. Try another letter or create users first.">
        <PagerSettings Mode="NumericFirstLast" FirstPageText="&amp;lt;&amp;lt; First" 
            LastPageText="&amp;gt;&amp;gt; Last" NextPageText="&amp;gt; Next" 
            PreviousPageText="&amp;lt; Previous" />
        <Columns>
            <asp:TemplateField>
                <HeaderStyle CssClass="gridheaderBG" Width="1px" />
                <ItemStyle CssClass="gridheaderBG" Width="1px" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="@">
                <ItemTemplate>
                    <asp:CheckBox ID="chkRows" runat="server" ToolTip="Select as recipient" />
                </ItemTemplate>
                <ItemStyle Width="25px" HorizontalAlign="Center" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="User Name" SortExpression="UserName">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("UserName") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <a href='edit_user_modal.aspx?username=<%# Eval("UserName") %>' rel="gb_page_center[525, 600]" title="Edit User Details"><%# Eval("UserName")%></a>
                </ItemTemplate>
                <HeaderStyle CssClass="gridColumnHeaderBG" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="User Email" SortExpression="Email">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Email") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <a href='Mailto:<%# Eval("Email") %>' title="click to email from your computer"><%#Eval("Email")%></a>
                </ItemTemplate>
                <HeaderStyle CssClass="gridColumnHeaderBG" />
            </asp:TemplateField>
            <asp:CheckBoxField DataField="IsApproved" HeaderText="Approved?" SortExpression="IsApproved">
                <HeaderStyle CssClass="gridColumnHeaderBG" />
                <ItemStyle HorizontalAlign="Center" />
            </asp:CheckBoxField>
            <asp:CheckBoxField DataField="IsLockedOut" HeaderText="Locked Out?" SortExpression="IsLockedOut">
                <HeaderStyle CssClass="gridColumnHeaderBG" />
                <ItemStyle HorizontalAlign="Center" />
            </asp:CheckBoxField>
            <asp:BoundField DataField="CreationDate" HeaderText="Creation Date" SortExpression="CreationDate" >
                <HeaderStyle CssClass="gridColumnHeaderBG" />
            </asp:BoundField>
        </Columns>
    </asp:GridView> 
    
    <%-- object datasource  --%>
    <asp:ObjectDataSource ID="UsersList" runat="server" DataObjectTypeName="System.Web.Security.MembershipUser"
        SelectMethod="FindUsersByEmail" TypeName="System.Web.Security.Membership">
        <SelectParameters>
            <asp:QueryStringParameter Name="emailToMatch" QueryStringField="letter" Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>

    <%-- email header 2  --%> 
    <div class="EmailHeader2">
    <table cellpadding="3" cellspacing="0" style="width: 100%;">
        <tr>
            <td style="font-size: xx-small; color: #000000; width: 35px;">
                From:
            </td>
            <td>
                <asp:TextBox ID="txtMailFrom" runat="server" Width="50%" MaxLength="100"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvReturnAddress" runat="server" ErrorMessage="From address is required!" ControlToValidate="txtMailFrom" Display="Dynamic" EnableViewState="False" >*</asp:RequiredFieldValidator>
                <%-- <asp:Button ID="Button1" runat="server" CausesValidation="False" Font-Size="10px" PostBackUrl="~/Users/Admin/email_options.aspx" Text="edit" Width="30px" ToolTip="Click to configure SMTP and FROM email addresses." />--%>
            </td>
        </tr>
        <tr>
            <td style="font-size: xx-small; color: #000000; width: 35px;">
                Subject:
            </td>
            <td>
                <asp:TextBox ID="txb_Subject" runat="Server" Width="50%" ToolTip="Type a subject for this email. Subject cannot be left empty.">hello world</asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txb_Subject" ErrorMessage="Subject: cannot be empty.">*</asp:RequiredFieldValidator>
            </td>
        </tr>
    </table>
    </div>
    
    <%-- Rich Text Editor embeded in FormView --%>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" />
     

    <asp:TextBox
        ID="WYSIWYGEditor_EmailBody"
        TextMode="MultiLine"
        Columns="80"
        Rows="10"
        runat="server" 
        Text="Start typing your email here..."
        />

    <asp:HtmlEditorExtender
        TargetControlID="WYSIWYGEditor_EmailBody"
        runat="server" />
</asp:Content>


