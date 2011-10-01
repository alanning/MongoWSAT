using System;
using System.Data;
using System.Web.Security;
using System.Web.UI.WebControls;

public partial class Admin_Roles : System.Web.UI.Page
{

#region globals

    private bool createRoleSuccess = true;

#endregion

#region get roles and bind to gridview

    private void Page_PreRender()
    {
        // Create a DataTable and define its columns
        DataTable RoleList = new DataTable();
        RoleList.Columns.Add("Role Name");
        RoleList.Columns.Add("User Count");

        string[] allRoles = Roles.GetAllRoles();

        // Get the list of roles in the system and how many users belong to each role
        foreach (string roleName in allRoles)
        {
            int numberOfUsersInRole = Roles.GetUsersInRole(roleName).Length;
            string[] roleRow = { roleName, numberOfUsersInRole.ToString() };
            RoleList.Rows.Add(roleRow);
        }

        // Bind the DataTable to the GridView
        UserRoles.DataSource = RoleList;
        UserRoles.DataBind();

        if (createRoleSuccess)
        {
            // Clears form field after a role was successfully added.
            NewRole.Text = "";
        }
    }

#endregion

#region create new role

    // create new role
    public void AddRole(object sender, EventArgs e)
    {
        try
        {
            Roles.CreateRole(NewRole.Text);
            ConfirmationMessage.InnerText = "The new role was added.";
            createRoleSuccess = true;
        }
        catch (Exception ex)
        {
            ConfirmationMessage.InnerText = ex.Message;
            createRoleSuccess = false;
        }
    }

#endregion

#region delete role

    // delete selected role
    public void DeleteRole(object sender, CommandEventArgs e)
    {
        try
        {
            Roles.DeleteRole(e.CommandArgument.ToString());
            ConfirmationMessage.InnerText = "Role '" + e.CommandArgument.ToString() + "' was deleted.";
        }
        catch (Exception ex)
        {
            ConfirmationMessage.InnerText = ex.Message;
        }
    }

#endregion

}
