using System;
using System.Web.Profile;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Active_users : System.Web.UI.Page
{

#region Gridview and Paging partial

    // on page prerender
    private void Page_PreRender()
    {
        BindUserAccounts();
    }

    // hide delete button if gridview returns nothing
    protected void Page_PreRenderComplete(object sender, EventArgs e)
    {
        btnDeleteSelected.Visible = UsersGridView.Rows.Count > 0;
    }

    // create datasource for user gridview
    private void BindUserAccounts()
    {
        int totalRecords;
        MembershipUserCollection allUsers = Membership.GetAllUsers(this.PageIndex, this.PageSize, out totalRecords);
        MembershipUserCollection filteredUsers = new MembershipUserCollection();

        // create boolean for dropdown control list
        bool isActive;
        if (active.SelectedValue == "Active Accounts")
        {
            isActive = true;
        }
        else
        {
            isActive = false;
        }

        // create boolean Values for dropdown list
        foreach (MembershipUser user in allUsers)
        {
            if (user.IsApproved == isActive)
            {
                filteredUsers.Add(user);
            }
        }

        // Enable/disable the pager buttons based on which page we're on
        bool visitingFirstPage = (this.PageIndex == 0);
        lnkFirst.Enabled = !visitingFirstPage;
        lnkPrev.Enabled = !visitingFirstPage;

        int lastPageIndex = (totalRecords - 1) / this.PageSize;
        bool visitingLastPage = (this.PageIndex >= lastPageIndex);
        lnkNext.Enabled = !visitingLastPage;
        lnkLast.Enabled = !visitingLastPage;

        UsersGridView.DataSource = filteredUsers;
        UsersGridView.DataBind();
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
        Membership.GetAllUsers(this.PageIndex, this.PageSize, out totalRecords);

        // Navigate to the last page index
        this.PageIndex = (totalRecords - 1) / this.PageSize;
        BindUserAccounts();
    }

#endregion

#region Properties

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
