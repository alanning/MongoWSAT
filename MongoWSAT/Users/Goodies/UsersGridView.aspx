<%@ Page Language="C#" AutoEventWireup="True" Inherits="Goodies_UsersGridView" Codebehind="UsersGridView.aspx.cs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Untitled Page</title>
    
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

</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    
    <%-- gridview to display membership users --%>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
    
        <%-- gridview to display membership users --%>      
        <asp:GridView ID="UsersGridView" runat="server" AutoGenerateColumns="False" 
            onrowcreated="UserAccounts_RowCreated" onrowdeleting="UserAccounts_RowDeleting" 
            DataKeyNames="userName" EmptyDataText="No records found.">
            <Columns>
                <asp:TemplateField>
                    <HeaderStyle Width="10px" />
                    <ItemStyle CssClass="gridheaderBG" Width="10px" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Del">
                    <HeaderTemplate>
                        <input id="chkAll" onclick="javascript:SelectAllCheckboxes(this);" runat="server" type="checkbox" title="Check all checkboxes" />
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:CheckBox ID="chkRows" runat="server" ToolTip="Select for deletion" />
                    </ItemTemplate>
                    <HeaderStyle Font-Italic="True" />
                    <ItemStyle Width="25px" HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField>
                    <HeaderTemplate>
                        User Name
                    </HeaderTemplate>
                    <ItemTemplate>
                        <div class="usernameGridRoll">
                        <a href='../Admin/edit_user.aspx?username=<%# Eval("UserName") %>' title="click for details"><%# Eval("UserName") %></a>
                        </div>
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
        
        <%-- gridview navigation links --%>
        <div class="membersGridViewPager">
        
        <asp:LinkButton ID="lnkFirst" runat="server" onclick="lnkFirst_Click">&lt;&lt; First</asp:LinkButton>
        <asp:LinkButton ID="lnkPrev" runat="server" onclick="lnkPrev_Click">&lt; Prev</asp:LinkButton>
        <asp:LinkButton ID="lnkNext" runat="server" onclick="lnkNext_Click">Next &gt;</asp:LinkButton>
        <asp:LinkButton ID="lnkLast" runat="server" onclick="lnkLast_Click">Last &gt;&gt;</asp:LinkButton>
        
        </div>
        
        <%-- toggle checkboxes --%>
        <div class="membersToggle">

        <asp:LinkButton ID="btnDeleteSelected" runat="server" ToolTip="Click to delete the selected users." OnClientClick="return confirm('Are you sure you want to delete the selected users?');" onclick="btnDeleteSelected_Click">Delete Selected</asp:LinkButton>
        
        </div>
        
        <%-- delete all membership user acounts and all related data --%>
        <div class="membersDeleteAll">
        
        <asp:LinkButton ID="deleteAllUsers" runat="server" onclick="deleteAllUsers_Click" ToolTip="Delete all membership users and all related information." OnClientClick="return confirm('Do you want to delete All Users and Related data? Warning! This action connot be reversed. If in doubt, backup your database first.');" >Delete All Users</asp:LinkButton>
        
        </div>
        
        <br />
        <br />
        
        <%-- delete success label  --%>
        <asp:Label ID="lblDeleteSuccess" runat="server" Text="User(s) were sucessfully deleted! - and will be removed from grid on page refresh." Visible="false"></asp:Label>
        
        <%-- ajax update panel end  --%>
        </ContentTemplate>
        </asp:UpdatePanel>
        
        <p></p>
        
        <%-- a-z email recipients --%>
        <div align="center" class="aTozNavigaion"><a href="?letter=%" title="Show all users">All</a></div>
        <div align="center" class="aTozNavigaion"><a href="?letter=A" title="Email starts with A">A</a></div>
        <div align="center" class="aTozNavigaion"><a href="?letter=B" title="Email starts with B">B</a></div>
        <div align="center" class="aTozNavigaion"><a href="?letter=C" title="Email starts with C">C</a></div>
        <div align="center" class="aTozNavigaion"><a href="?letter=D" title="Email starts with D">D</a></div>
        <div align="center" class="aTozNavigaion"><a href="?letter=E" title="Email starts with E">E</a></div>
        <div align="center" class="aTozNavigaion"><a href="?letter=F" title="Email starts with F">F</a></div>
        <div align="center" class="aTozNavigaion"><a href="?letter=G" title="Email starts with G">G</a></div>
        <div align="center" class="aTozNavigaion"><a href="?letter=H" title="Email starts with H">H</a></div>
        <div align="center" class="aTozNavigaion"><a href="?letter=I" title="Email starts with I">I</a></div>
        <div align="center" class="aTozNavigaion"><a href="?letter=J" title="Email starts with J">J</a></div>
        <div align="center" class="aTozNavigaion"><a href="?letter=K" title="Email starts with K">K</a></div>
        <div align="center" class="aTozNavigaion"><a href="?letter=L" title="Email starts with L">L</a></div>
        <div align="center" class="aTozNavigaion"><a href="?letter=M" title="Email starts with M">M</a></div>
        <div align="center" class="aTozNavigaion"><a href="?letter=N" title="Email starts with N">N</a></div>
        <div align="center" class="aTozNavigaion"><a href="?letter=O" title="Email starts with O">O</a></div>
        <div align="center" class="aTozNavigaion"><a href="?letter=P" title="Email starts with P">P</a></div>
        <div align="center" class="aTozNavigaion"><a href="?letter=Q" title="Email starts with Q">Q</a></div>
        <div align="center" class="aTozNavigaion"><a href="?letter=R" title="Email starts with R">R</a></div>
        <div align="center" class="aTozNavigaion"><a href="?letter=S" title="Email starts with S">S</a></div>
        <div align="center" class="aTozNavigaion"><a href="?letter=T" title="Email starts with T">T</a></div>
        <div align="center" class="aTozNavigaion"><a href="?letter=U" title="Email starts with U">U</a></div>
        <div align="center" class="aTozNavigaion"><a href="?letter=V" title="Email starts with V">V</a></div>
        <div align="center" class="aTozNavigaion"><a href="?letter=W" title="Email starts with W">W</a></div>
        <div align="center" class="aTozNavigaion"><a href="?letter=X" title="Email starts with X">X</a></div>
        <div align="center" class="aTozNavigaion"><a href="?letter=Y" title="Email starts with Y">Y</a></div>
        <div align="center" class="aTozNavigaion"><a href="?letter=Z" title="Email starts with Z">Z</a></div>

        <br />
        <br />
        
        <asp:GridView ID="GridView1" runat="server" AllowPaging="True" 
            AutoGenerateColumns="False" DataKeyNames="UserName" 
            DataSourceID="ObjectDataSource1">
            <Columns>
                <asp:TemplateField>
                    <HeaderStyle Width="10px" />
                    <ItemStyle CssClass="gridheaderBG" Width="10px" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Del">
                    <HeaderTemplate>
                        <input id="chkAll" onclick="javascript:SelectAllCheckboxes(this);" runat="server" type="checkbox" title="Check all checkboxes" />
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:CheckBox ID="chkRows" runat="server" ToolTip="Select for deletion"/>
                    </ItemTemplate>
                    <HeaderStyle Font-Italic="True" />
                    <ItemStyle Width="25px" HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="User Name">
                    <EditItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("UserName") %>'></asp:Label>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <a href='../admin/edit_user_modal.aspx?username=<%# Eval("UserName") %>' rel="gb_page_center[525, 600]" title="click for details"><%# Eval("UserName") %></a>
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
                <asp:BoundField DataField="UserName" HeaderText="UserName" ReadOnly="True" />
                <asp:BoundField DataField="LastLoginDate" HeaderText="Last Login Date" />
                <asp:BoundField DataField="LastActivityDate" HeaderText="Last Activity Date" />
                <asp:CheckBoxField DataField="IsApproved" HeaderText="Approved?" >
                    <ItemStyle HorizontalAlign="Center" />
                </asp:CheckBoxField>
                <asp:CheckBoxField DataField="IsOnline" HeaderText="Online?" ReadOnly="True" >
                    <ItemStyle HorizontalAlign="Center" />
                </asp:CheckBoxField>
                <asp:CheckBoxField DataField="IsLockedOut" HeaderText="Locked Out?" 
                    ReadOnly="True" >
                    <ItemStyle HorizontalAlign="Center" />
                </asp:CheckBoxField>
            </Columns>
        </asp:GridView>

        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" 
            SelectMethod="GetAllUsers" TypeName="System.Web.Security.Membership" 
            OldValuesParameterFormatString="original_{0}">
        </asp:ObjectDataSource>
    
    </div>
    </form>
</body>
</html>
