using System;
using System.Web.Profile;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Users : System.Web.UI.Page
{

#region Gridview and a-z navigation

    // hide delete button if gridview returns nothing
    protected void Page_PreRenderComplete(object sender, EventArgs e)
    {
        btnDeleteSelected.Visible = UsersGridView.Rows.Count > 0;
    }

    // only bind data on page load not on postback
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            BindUserAccounts();
            BindAtoZNavigation();
        }
    }

    // create a-z navigation links
    private void BindAtoZNavigation()
    {
        string[] AtoZfilterOptions = { "All", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z" };
        AtoZRepeater.DataSource = AtoZfilterOptions;
        AtoZRepeater.DataBind();
    }

    // create datasource for user gridview
    private void BindUserAccounts()
    {
        int totalRecords;
        UsersGridView.DataSource = Membership.FindUsersByName(this.UsernameToMatch + "%", this.PageIndex, this.PageSize, out totalRecords);
        UsersGridView.DataBind();

        // Enable/disable the pager buttons based on which page we're on
        bool visitingFirstPage = (this.PageIndex == 0);
        lnkFirst.Enabled = !visitingFirstPage;
        lnkPrev.Enabled = !visitingFirstPage;

        int lastPageIndex = (totalRecords - 1) / this.PageSize;
        bool visitingLastPage = (this.PageIndex >= lastPageIndex);
        lnkNext.Enabled = !visitingLastPage;
        lnkLast.Enabled = !visitingLastPage;
    }

    // when the "all" button is clicked within the repeater
    protected void AtoZRepeater_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        if (e.CommandName == "All")
            this.UsernameToMatch = string.Empty;
        else
            this.UsernameToMatch = e.CommandName;

        BindUserAccounts();
    }

#endregion

#region Paging Interface Click Event Handlers

    // first pager link
    protected void lnkFirst_Click(object sender, EventArgs e)
    {
        this.PageIndex = 0;
        BindUserAccounts();
    }

    // previous pager link
    protected void lnkPrev_Click(object sender, EventArgs e)
    {
        this.PageIndex -= 1;
        BindUserAccounts();
    }

    // next pager link
    protected void lnkNext_Click(object sender, EventArgs e)
    {
        this.PageIndex += 1;
        BindUserAccounts();
    }

    // last pager link
    protected void lnkLast_Click(object sender, EventArgs e)
    {
        // Determine the total number of records
        int totalRecords;
        Membership.FindUsersByName(this.UsernameToMatch + "%", this.PageIndex, this.PageSize, out totalRecords);

        // Navigate to the last page index
        this.PageIndex = (totalRecords - 1) / this.PageSize;
        BindUserAccounts();
    }

#endregion

#region Properties

    // put the clicked letter into viewstate
    private string UsernameToMatch
    {
        get
        {
            object o = ViewState["UsernameToMatch"];
            if (o == null)
                return string.Empty;
            else
                return (string)o;
        }
        set
        {
            ViewState["UsernameToMatch"] = value;
        }
    }

    // put the page index into viewstate
    private int PageIndex
    {
        get
        {
            object o = ViewState["PageIndex"];
            if (o == null)
                return 0;
            else
                return (int)o;
        }
        set
        {
            ViewState["PageIndex"] = value;
        }
    }

    // set the page size for the gridview
    private int PageSize
    {
        get
        {
            return 10;
        }
    }

#endregion

#region Member delete one user click event handlers

    // before the row is deleted
    protected void UserAccounts_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        string userName = UsersGridView.DataKeys[e.RowIndex].Value.ToString();
        ProfileManager.DeleteProfile(userName);
        Membership.DeleteUser(userName);

        //Response.Redirect("default.aspx");
        lblDeleteSuccess.Visible = true;
    }

    // when the rows are being rendered alert user with delete confirmation
    protected void UserAccounts_RowCreated(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            ImageButton btn = e.Row.Cells[10].Controls[0] as ImageButton;
            btn.OnClientClick = "if (confirm('Are you sure you want to delete this user?') == false) return false;";
        }
    }

#endregion

#region Delete all users and related data click even handler

    protected void deleteAllUsers_Click(object sender, EventArgs e)
    {
        foreach (MembershipUser usr in Membership.GetAllUsers())
            Membership.DeleteUser(usr.UserName);

        deleteAllUsers.Enabled = false;
        deleteAllUsers.Text = "Delete complete..";
    }

#endregion

#region Delete users selected by checkbox

    protected void btnDeleteSelected_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in UsersGridView.Rows)
        {
            CheckBox cb = (CheckBox)row.FindControl("chkRows");
            if (cb != null && cb.Checked)
            {
                string userName = UsersGridView.DataKeys[row.RowIndex].Value.ToString();
                ProfileManager.DeleteProfile(userName);
                Membership.DeleteUser(userName);

                //Response.Redirect("default.aspx");
                lblDeleteSuccess.Visible = true;
            }
        }
    }

#endregion

}