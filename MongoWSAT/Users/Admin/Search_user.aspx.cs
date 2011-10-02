using System;
using System.Web.Profile;
using System.Web.Security;
using System.Web.UI.WebControls;

public partial class Admin_Search_user : System.Web.UI.Page
{

#region Hide delete button if no gridview results

    protected void Page_PreRenderComplete(object sender, EventArgs e)
    {
        // hide delete button if gridview returns nothing
        if (UsersGridView.Rows.Count == 0)
        {
            btnDeleteSelected.Visible = false;
        }

    }

    protected void Page_Load(object sender, EventArgs e)
    {
        // show delete button if gridview has rows
        if (UsersGridView.Rows.Count > 0)
        {
            btnDeleteSelected.Visible = true;
        }
    }

#endregion

#region Search and GridView display

    // declare global variable for getallusers that will be used later
    private MembershipUserCollection allRegisteredUsers = Membership.GetAllUsers();

    // bind all registered users to gridview
    private void BindAllUsers(bool reloadAllUsers)
    {
        MembershipUserCollection allUsers = null;
        if (reloadAllUsers) allUsers = Membership.GetAllUsers();

        string searchText = "";
        if (!string.IsNullOrEmpty(UsersGridView.Attributes["SearchText"]))
            searchText = UsersGridView.Attributes["SearchText"];
        bool searchByEmail = false;
        if (!string.IsNullOrEmpty(UsersGridView.Attributes["SearchByEmail"]))
            searchByEmail = bool.Parse(UsersGridView.Attributes["SearchByEmail"]);
        if (searchText.Length > 0)
        {
            if (searchByEmail)
                allUsers = Membership.FindUsersByEmail(searchText);
            else
                allUsers = Membership.FindUsersByName(searchText);
        }
        else
        {
            allUsers = allRegisteredUsers;
        }
        UsersGridView.DataSource = allUsers;
        UsersGridView.DataBind();
    }

    // on search button click
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        bool searchByEmail = (ddlUserSearchTypes.SelectedValue == "E-mail");
        UsersGridView.Attributes.Add("SearchText", "%" + txtSearchText.Text + "%");
        UsersGridView.Attributes.Add("SearchByEmail", searchByEmail.ToString());
        BindAllUsers(false);
    }

#endregion

#region Delete one user with trashbin image

    // before the row is deleted
    protected void UserAccounts_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        string UserName = UsersGridView.DataKeys[e.RowIndex].Value.ToString();
        ProfileManager.DeleteProfile(UserName);
        Membership.DeleteUser(UserName);

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

#region Delete users selected by checkboxes

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