<%@ Page Language="C#" MasterPageFile="~/Users/Admin/MasterPage.master" Title="Site Access Rules" ValidateRequest="false" %>
<%@ Import Namespace="System.Web.Configuration" %>
<%@ Import Namespace="System.IO" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="cc1" %>
<%@ Register src="~/Users/UserControls/adminUserNavLinks.ascx" tagname="adminUserNavLinks" tagprefix="uc1" %>

<script runat="server">
    // .....................................................................................
    // Code from Dan Clam's tutorial http://aspnet.4guysfromrolla.com/articles/052307-1.aspx
    // replaced UserList dropdown with simple textbox for scalability. Admin can type in username
    // rather than select from dropdown of users.
    // .....................................................................................

    // the application path
    private const string VirtualImageRoot = "~/";
    string selectedFolderName;

    // on page init, get all roles, users and 
    // request the folder name only if it is a postback
    private void Page_Init()
    {
        UserRoles.DataSource = Roles.GetAllRoles();
        UserRoles.DataBind();

        if (IsPostBack)
        {
            selectedFolderName = "";
        }
        else
        {
            selectedFolderName = Request.QueryString["selectedFolderName"];
        }
    }

    // on page load, populate folder structure on first page load, 
    // not on postback
    private void Page_Load()
    {
        if (!IsPostBack)
        {
            PopulateTree();
        }
    }

    // on page prerender, call DisplayAccessRules
    private void Page_PreRender()
    {
        if (FolderTree.SelectedNode != null)
        {
            DisplayAccessRules(FolderTree.SelectedValue);
            SecurityInfoSection.Visible = true;
        }
    }

    // Populate the tree based on the subfolders of the specified VirtualImageRoot
    private void PopulateTree()
    {
        DirectoryInfo rootFolder = new DirectoryInfo(Server.MapPath(VirtualImageRoot));
        TreeNode root = AddNodeAndDescendents(rootFolder, null);
        FolderTree.Nodes.Add(root);
        try
        {
            FolderTree.SelectedNode.ImageUrl = "~/App_Themes/Default/Images/target.gif";
        }
        catch { }
    }

    private TreeNode AddNodeAndDescendents(DirectoryInfo folder, TreeNode parentNode)
    {
        // Add the TreeNode, displaying the folder's name and 
        // storing the full path to the folder as the value
        string virtualFolderPath;
        if (parentNode == null)
        {
            virtualFolderPath = VirtualImageRoot;
        }
        else
        {
            virtualFolderPath = parentNode.Value + folder.Name + "/";
        }

        TreeNode node = new TreeNode(folder.Name, virtualFolderPath);
        node.Selected = (folder.Name == selectedFolderName);

        // Recurse through this folder's subfolders
        DirectoryInfo[] subFolders = folder.GetDirectories();
        foreach (DirectoryInfo subFolder in subFolders)
        {
            if (subFolder.Name != "App_Data")
            {
                TreeNode child = AddNodeAndDescendents(subFolder, node);
                node.ChildNodes.Add(child);
            }
        }
        // Return the new TreeNode
        return node;
    }

    // reset the Add Rule form field values whenever the user moves folders
    protected void FolderTree_SelectedNodeChanged(object sender, EventArgs e)
    {
        ActionDeny.Checked = true;
        ActionAllow.Checked = false;
        ApplyRole.Checked = true;
        ApplyUser.Checked = false;
        ApplyAllUsers.Checked = false;
        ApplyAnonUser.Checked = false;
        UserRoles.SelectedIndex = 0;
        SpecifyUser.Text = "";

        RuleCreationError.Visible = false;

        // Restore previously selected folder's ImageUrl
        ResetFolderImageUrls(FolderTree.Nodes[0]);

        // Set the newly selected folder's ImageUrl
        FolderTree.SelectedNode.ImageUrl = "~/App_Themes/Default/Images/target.gif";
    }

    // Recurse through this node's child nodes
    private void ResetFolderImageUrls(TreeNode parentNode)
    {
        parentNode.ImageUrl = "~/App_Themes/Default/Images/folder.gif";

        TreeNodeCollection nodes = parentNode.ChildNodes;
        foreach (TreeNode childNode in nodes)
        {
            ResetFolderImageUrls(childNode);
        }
    }

    // throw exception if access outside the directory is detected
    // this isn't needed since IIS won't allow it anyway
    private void DisplayAccessRules(string virtualFolderPath)
    {
        if (!virtualFolderPath.StartsWith(VirtualImageRoot) || virtualFolderPath.IndexOf("..") >= 0)
        {
            throw new ApplicationException("An attempt to access a folder outside of the website directory has been detected and blocked.");
        }
        Configuration config = WebConfigurationManager.OpenWebConfiguration(virtualFolderPath);
        SystemWebSectionGroup systemWeb = (SystemWebSectionGroup)config.GetSectionGroup("system.web");
        AuthorizationRuleCollection authorizationRules = systemWeb.Authorization.Rules;
        RulesGrid.DataSource = authorizationRules;
        RulesGrid.DataBind();

        TitleOne.InnerText = "Rules applied to " + virtualFolderPath;
        TitleTwo.InnerText = "Create new rule for " + virtualFolderPath;
    }

    // if no authorization rule present, display message
    private void RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            AuthorizationRule rule = (AuthorizationRule)e.Row.DataItem;
            if (!rule.ElementInformation.IsPresent)
            {
                e.Row.Cells[3].Text = "Inherited from higher level";
                e.Row.Cells[4].Text = "Inherited from higher level";
            }
        }
    }

    // authorization rules
    private string GetAction(AuthorizationRule rule)
    {
        return rule.Action.ToString();
    }
    private string GetRole(AuthorizationRule rule)
    {
        return rule.Roles.ToString();
    }
    private string GetUser(AuthorizationRule rule)
    {
        return rule.Users.ToString();
    }
    private void DeleteRule(object sender, EventArgs e)
    {
        Button button = (Button)sender;
        GridViewRow item = (GridViewRow)button.Parent.Parent;
        string virtualFolderPath = FolderTree.SelectedValue;
        Configuration config = WebConfigurationManager.OpenWebConfiguration(virtualFolderPath);
        SystemWebSectionGroup systemWeb = (SystemWebSectionGroup)config.GetSectionGroup("system.web");
        AuthorizationSection section = (AuthorizationSection)systemWeb.Sections["authorization"];
        section.Rules.RemoveAt(item.RowIndex);
        config.Save();
    }
    private void MoveUp(object sender, EventArgs e)
    {
        MoveRule(sender, e, "up");
    }
    private void MoveDown(object sender, EventArgs e)
    {
        MoveRule(sender, e, "down");
    }

    private void MoveRule(object sender, EventArgs e, string upOrDown)
    {
        upOrDown = upOrDown.ToLower();

        if (upOrDown == "up" || upOrDown == "down")
        {
            Button button = (Button)sender;
            GridViewRow item = (GridViewRow)button.Parent.Parent;
            int selectedIndex = item.RowIndex;
            if ((selectedIndex > 0 && upOrDown == "up") || (upOrDown == "down"))
            {
                string virtualFolderPath = FolderTree.SelectedValue;
                Configuration config = WebConfigurationManager.OpenWebConfiguration(virtualFolderPath);
                SystemWebSectionGroup systemWeb = (SystemWebSectionGroup)config.GetSectionGroup("system.web");
                AuthorizationSection section = (AuthorizationSection)systemWeb.Sections["authorization"];

                // Pull the local rules out of the authorization section, deleting them from same:
                ArrayList rulesArray = PullLocalRulesOutOfAuthorizationSection(section);
                if (upOrDown == "up")
                {
                    LoadRulesInNewOrder(section, rulesArray, selectedIndex, upOrDown);
                }
                else if (upOrDown == "down")
                {
                    if (selectedIndex < rulesArray.Count - 1)
                    {
                        LoadRulesInNewOrder(section, rulesArray, selectedIndex, upOrDown);
                    }
                    else
                    {
                        // DOWN button in last row was pressed. Load the rules array back in without resorting.
                        for (int x = 0; x < rulesArray.Count; x++)
                        {
                            section.Rules.Add((AuthorizationRule)rulesArray[x]);
                        }
                    }
                }
                config.Save();
            }
        }
    }

    // load rules in new order
    private void LoadRulesInNewOrder(AuthorizationSection section,
        ArrayList rulesArray, int selectedIndex, string upOrDown)
    {
        AddFirstGroupOfRules(section, rulesArray, selectedIndex, upOrDown);
        AddTheTwoSwappedRules(section, rulesArray, selectedIndex, upOrDown);
        AddFinalGroupOfRules(section, rulesArray, selectedIndex, upOrDown);
    }

    // add first group of rules
    private void AddFirstGroupOfRules(AuthorizationSection section,
        ArrayList rulesArray, int selectedIndex, string upOrDown)
    {
        int adj;
        if (upOrDown == "up") adj = 1;
        else adj = 0;
        for (int x = 0; x < selectedIndex - adj; x++)
        {
            section.Rules.Add((AuthorizationRule)rulesArray[x]);
        }
    }

    // add two swapped rules
    private void AddTheTwoSwappedRules(AuthorizationSection section,
        ArrayList rulesArray, int selectedIndex, string upOrDown)
    {
        if (upOrDown == "up")
        {
            section.Rules.Add((AuthorizationRule)rulesArray[selectedIndex]);
            section.Rules.Add((AuthorizationRule)rulesArray[selectedIndex - 1]);
        }
        else if (upOrDown == "down")
        {
            section.Rules.Add((AuthorizationRule)rulesArray[selectedIndex + 1]);
            section.Rules.Add((AuthorizationRule)rulesArray[selectedIndex]);
        }
    }

    // add final group of rules
    private void AddFinalGroupOfRules(AuthorizationSection section,
        ArrayList rulesArray, int selectedIndex, string upOrDown)
    {
        int adj;
        if (upOrDown == "up") adj = 1;
        else adj = 2;
        for (int x = selectedIndex + adj; x < rulesArray.Count; x++)
        {
            section.Rules.Add((AuthorizationRule)rulesArray[x]);
        }
    }

    // use local rules out of authorization section
    private ArrayList PullLocalRulesOutOfAuthorizationSection(AuthorizationSection section)
    {
        // First load the local rules into an ArrayList.
        ArrayList rulesArray = new ArrayList();
        foreach (AuthorizationRule rule in section.Rules)
        {
            if (rule.ElementInformation.IsPresent)
            {
                rulesArray.Add(rule);
            }
        }

        // Next delete the rules from the section.
        foreach (AuthorizationRule rule in rulesArray)
        {
            section.Rules.Remove(rule);
        }
        return rulesArray;
    }

    // create rule
    private void CreateRule(object sender, EventArgs e)
    {
        AuthorizationRule newRule;
        if (ActionAllow.Checked) newRule = new AuthorizationRule(AuthorizationRuleAction.Allow);
        else newRule = new AuthorizationRule(AuthorizationRuleAction.Deny);

        if (ApplyRole.Checked && UserRoles.SelectedIndex > 0)
        {
            newRule.Roles.Add(UserRoles.Text);
            AddRule(newRule);
        }
        else if (ApplyUser.Checked && SpecifyUser.Text != String.Empty)
        {
            newRule.Users.Add(SpecifyUser.Text);
            AddRule(newRule);
        }
        else if (ApplyAllUsers.Checked)
        {
            newRule.Users.Add("*");
            AddRule(newRule);
        }
        else if (ApplyAnonUser.Checked)
        {
            newRule.Users.Add("?");
            AddRule(newRule);
        }
    }

    // add rule
    private void AddRule(AuthorizationRule newRule)
    {
        string virtualFolderPath = FolderTree.SelectedValue;
        Configuration config = WebConfigurationManager.OpenWebConfiguration(virtualFolderPath);
        SystemWebSectionGroup systemWeb = (SystemWebSectionGroup)config.GetSectionGroup("system.web");
        AuthorizationSection section = (AuthorizationSection)systemWeb.Sections["authorization"];
        section.Rules.Add(newRule);
        try
        {
            config.Save();
            RuleCreationError.Visible = false;
        }
        catch (Exception ex)
        {
            RuleCreationError.Visible = true;
            RuleCreationError.Text = "<div class=\"alert\"><br />An error occurred and the rule was not added.<br /><br />Error message:<br /><br /><i>" + ex.Message + "</i></div>";
        }
    }
</script>

<%-- content place holder for head section --%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

</asp:Content>

<%-- content placeholder for body title --%>
<asp:Content ID="Content5" runat="server" contentplaceholderid="cphBodyTitle">
    Web Site Access Rules
</asp:Content>

<%-- content placeholder for user navigation --%>
<asp:Content ID="Content6" runat="server" contentplaceholderid="cphUserNavigation">
    <uc1:adminUserNavLinks ID="adminUserNavLinks1" runat="server" />
</asp:Content>

<%-- content place holder for body content --%>
<asp:Content ID="Content7" runat="server" contentplaceholderid="cphContentBody">

    <%-- ajax update panel start --%>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
        
            <table>
                <tr>
                    <td valign="top">
                        <div class="adminHelp">
                            Use this page to manage access rules for your Web site. Rules are applied to folders,
                            thus providing robust folder-level security enforced by the ASP.NET infrastructure.
                            Rules are persisted as XML in each folder's Web.config file.
                        </div>
                        <table>
                            <tr>
                                <td valign="top" style="padding-right: 30px;">
                                    <div>
                                        <asp:TreeView runat="server" ID="FolderTree" OnSelectedNodeChanged="FolderTree_SelectedNodeChanged" ImageSet="Arrows" ShowLines="True" ExpandDepth="1">
                                            <HoverNodeStyle Font-Underline="True" ForeColor="#5555DD" />
                                            <SelectedNodeStyle Font-Underline="True" ForeColor="#5555DD" HorizontalPadding="0px" VerticalPadding="0px" />
                                            <RootNodeStyle ImageUrl="~/App_Themes/Default/Images/folder-open.gif" />
                                            <ParentNodeStyle ImageUrl="~/App_Themes/Default/Images/folder-open.gif" Font-Bold="False" />
                                            <NodeStyle Font-Names="Tahoma" Font-Size="10pt" ForeColor="Black" HorizontalPadding="5px" NodeSpacing="0px" VerticalPadding="0px" />
                                            <LeafNodeStyle ImageUrl="~/App_Themes/Default/Images/folder.gif" />
                                        </asp:TreeView>
                                    </div>
                                </td>
                                <td valign="top" style="padding-left: 30px; border-left: 1px solid #F0F0F0;">
                                    <asp:Panel runat="server" ID="SecurityInfoSection" Visible="false">
                                        <div runat="server" id="TitleOne" class="formSectionTitle">
                                        </div>
                                        <br />
                                        <div class="adminHelp">
                                            Rules are applied in order. The first rule that matches applies, and the permission
                                            in each rule overrides the permissions in all following rules. Use the Move Up and
                                            Move Down buttons to change the order of the selected rule. Rules that appear dimmed
                                            are inherited from the parent and cannot be changed at this level.
                                        </div>
                                        <asp:GridView runat="server" ID="RulesGrid" AutoGenerateColumns="False" OnRowDataBound="RowDataBound">
                                            <Columns>
                                                <asp:TemplateField>
                                                    <HeaderStyle CssClass="gridheaderBG" Width="1px" />
                                                    <ItemStyle CssClass="gridheaderBG" Width="1px" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Action">
                                                    <ItemTemplate>
                                                        <%# GetAction((AuthorizationRule)Container.DataItem) %>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Roles">
                                                    <ItemTemplate>
                                                        <%# GetRole((AuthorizationRule)Container.DataItem) %>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="User">
                                                    <ItemTemplate>
                                                        <%# GetUser((AuthorizationRule)Container.DataItem) %>
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Center" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Delete Rule">
                                                    <ItemTemplate>
                                                        <asp:Button ID="Button1" runat="server" Text="Delete Rule" CommandArgument="<%# (AuthorizationRule)Container.DataItem %>" OnClick="DeleteRule" OnClientClick="return confirm('Click OK to delete this rule.')" />
                                                    </ItemTemplate>
                                                    <ControlStyle Font-Size="10px" />
                                                    <ItemStyle HorizontalAlign="Center" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Move Rule">
                                                    <ItemTemplate>
                                                        <asp:Button ID="Button2" runat="server" Text="  Up  " CommandArgument="<%# (AuthorizationRule)Container.DataItem %>" OnClick="MoveUp" />
                                                        <asp:Button ID="Button3" runat="server" Text="Down" CommandArgument="<%# (AuthorizationRule)Container.DataItem %>" OnClick="MoveDown" />
                                                    </ItemTemplate>
                                                    <ControlStyle Font-Size="10px" />
                                                    <ItemStyle HorizontalAlign="Center" />
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                        <br />
                                        <br />
                                        <div runat="server" id="TitleTwo" class="formSectionTitle">
                                        </div>
                                        <br />
                                        <table cellpadding="3" cellspacing="0" style="width: 100%">
                                            <tr>
                                                <td style="width: 153px">
                                                    <b>Action:</b>&nbsp;<asp:RadioButton ID="ActionDeny" runat="server" Checked="true" GroupName="action" Text="Deny" />
                                                    <asp:RadioButton ID="ActionAllow" runat="server" GroupName="action" Text="Allow" />
                                                </td>
                                                <td>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 153px">
                                                    <b>Rule applies to:</b>&nbsp;
                                                </td>
                                                <td>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 153px">
                                                    <asp:RadioButton ID="ApplyRole" runat="server" Checked="true" GroupName="applyto" Text="This Role:" />
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="UserRoles" runat="server" AppendDataBoundItems="true" Width="204px">
                                                        <asp:ListItem>Select Role</asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 153px">
                                                    <asp:RadioButton ID="ApplyUser" runat="server" GroupName="applyto" Text="This User:" />
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="SpecifyUser" runat="server" Width="204px" ToolTip="Enter a UserName.."></asp:TextBox>
                                                    <cc1:TextBoxWatermarkExtender ID="SpecifyUser_TextBoxWatermarkExtender" runat="server" TargetControlID="SpecifyUser" WatermarkText="type user name here...">
                                                    </cc1:TextBoxWatermarkExtender>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 153px">
                                                    <asp:RadioButton ID="ApplyAllUsers" runat="server" GroupName="applyto" Text="All Users (*)" />
                                                </td>
                                                <td>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 153px">
                                                    <asp:RadioButton ID="ApplyAnonUser" runat="server" GroupName="applyto" Text="Anonymous Users (?)" />
                                                </td>
                                                <td>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 153px">
                                                    <asp:Button ID="Button4" runat="server" OnClick="CreateRule" OnClientClick="return confirm('Click OK to create this rule.');" Text="Create Rule" />
                                                </td>
                                                <td>
                                                    <asp:Literal ID="RuleCreationError" runat="server"></asp:Literal>
                                                </td>
                                            </tr>
                                        </table>
                                        <br />
                                        <br />
                                    </asp:Panel>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            
        <%-- ajax update panel end --%>
        </ContentTemplate>
    </asp:UpdatePanel>

</asp:Content>


