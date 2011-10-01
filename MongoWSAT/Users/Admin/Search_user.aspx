<%@ Page Language="C#" MasterPageFile="~/Users/Admin/MasterPage.master" AutoEventWireup="True" Inherits="Admin_Search_user" Title="Member Search" Codebehind="Search_user.aspx.cs" %>
<%@ Register src="~/Users/UserControls/adminUserNavLinks.ascx" tagname="adminUserNavLinks" tagprefix="uc1" %>

<%-- content placeholder for head section --%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<script language="javascript" type="text/javascript">

 //  toggle checkboxes in gridview javascript function 
 function SelectAllCheckboxes(spanChk){
 
   var oItem = spanChk.children;
   var theBox= (spanChk.type=="checkbox") ? 
        spanChk : spanChk.children.item[0];
   xState=theBox.checked;
   elm=theBox.form.elements;

   for(i=0;i<elm.length;i++)
     if(elm[i].type=="checkbox" && 
              elm[i].id!=theBox.id)
     {
       //elm[i].click();

       if(elm[i].checked!=xState)
         elm[i].click();
       //elm[i].checked=xState;

     }
 }
 
</script>

<%-- greybox javascript sources --%>
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
    Member Search
</asp:Content>

<%-- content placeholder for user navigation --%>
<asp:Content ID="Content6" runat="server" contentplaceholderid="cphUserNavigation">

    <%-- user navigation include --%>
    <uc1:adminUserNavLinks ID="adminUserNavLinks1" runat="server" />
    
</asp:Content>

<%-- content placeholder for content body --%>
<asp:Content ID="Content7" runat="server" contentplaceholderid="cphContentBody">

    <%-- gridview to display membership users // incompatible with modal popup
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
    --%>

        <%-- dropdown menu for search type --%>
        <asp:DropDownList ID="ddlUserSearchTypes" runat="server" ToolTip="Click to select which database column you want to search">
            <asp:ListItem Selected="true" Text="UserName" />
            <asp:ListItem Text="E-mail" />
        </asp:DropDownList>
        
        <%-- divider --%>
        &nbsp;contains&nbsp;
        
        <%-- search box --%>
        <asp:TextBox ID="txtSearchText" runat="server" MaxLength="100" ToolTip="Type your search term" />
        
        <%-- search button --%>
        <asp:Button ID="btnSearch" runat="server" OnClick="btnSearch_Click" Text="Search" ToolTip="Click to start search." />
        
        &nbsp;
        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtSearchText" EnableViewState="False" ErrorMessage="Type search term first..." SetFocusOnError="True"></asp:RequiredFieldValidator>
        
        <br />
        <br />
        
        <%-- gridview to display membership users --%>      
        <asp:GridView ID="UsersGridView" runat="server" AutoGenerateColumns="False" onrowcreated="UserAccounts_RowCreated" onrowdeleting="UserAccounts_RowDeleting" DataKeyNames="userName" EmptyDataText="No records found." >
          <Columns>
            <asp:TemplateField>
                <HeaderStyle CssClass="gridheaderBG" Width="1px" />
                <ItemStyle CssClass="gridheaderBG" Width="1px" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Del">
                <HeaderTemplate>
                    <input id="chkAll" onclick="javascript:SelectAllCheckboxes(this);" runat="server" type="checkbox" title="Check all checkboxes" />
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:CheckBox ID="chkRows" runat="server" ToolTip="Select for deletion" />
                </ItemTemplate>
                <ItemStyle Width="25px" HorizontalAlign="Center" />
            </asp:TemplateField>
            <asp:TemplateField>
                <HeaderTemplate>
                    User Name
                </HeaderTemplate>
                <ItemTemplate>
                    <a href='edit_user_modal.aspx?username=<%# Eval("UserName") %>' rel="gb_page_center[525, 600]" title="Edit User Details"><%# Eval("UserName") %></a>
                </ItemTemplate>
            </asp:TemplateField>          
            <asp:TemplateField HeaderText="Email">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Email") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <a href='Mailto:<%# Eval("Email") %>' title="click to email from your computer"><%#Eval("Email")%></a>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="creationdate" HeaderText="Creation Date" />
            <asp:BoundField DataField="lastlogindate" HeaderText="Last Login Date" />
            <asp:BoundField DataField="lastactivitydate" HeaderText="Last Activity Date" />
            <asp:CheckBoxField DataField="IsApproved" HeaderText="Approved?">
                <ItemStyle HorizontalAlign="Center" />
            </asp:CheckBoxField>
            <asp:CheckBoxField DataField="IsOnline" HeaderText="Online?">
                <ItemStyle HorizontalAlign="Center" />
            </asp:CheckBoxField>
            <asp:CheckBoxField DataField="IsLockedOut" HeaderText="Locked Out?">
                <ItemStyle HorizontalAlign="Center" />
            </asp:CheckBoxField>
            <asp:ButtonField CommandName="Delete" ButtonType="Image" ImageUrl="~/App_Themes/Default/images/delete.gif" >
                <ItemStyle HorizontalAlign="Center" />
            </asp:ButtonField>
        </Columns>
    </asp:GridView>

    <%-- delete checked users --%>
    <div class="membersGridViewPager">

    <asp:LinkButton ID="btnDeleteSelected" runat="server" ToolTip="Click to delete the selected users." OnClientClick="return confirm('Are you sure you want to delete the selected users?');" onclick="btnDeleteSelected_Click">Delete Selected</asp:LinkButton>

    </div>

    <br />
    <br />

    <%-- delete success label  --%>
    <asp:Label ID="lblDeleteSuccess" runat="server" Text="User(s) were sucessfully deleted! - and will be removed from grid on page refresh." Visible="false"></asp:Label>
        
    <%-- ajax update panel end
    </ContentTemplate>
    </asp:UpdatePanel>
    --%>

</asp:Content>