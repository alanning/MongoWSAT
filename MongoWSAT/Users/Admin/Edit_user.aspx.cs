using System;
using System.Web.Profile;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Edit_user : System.Web.UI.Page
{

#region Global Variables

    // declare global variables
    string username;
    MembershipUser user;
    private bool createRoleSuccess = true;

    private WebProfile Profile
    {
        get { return WebProfile.Get(Context.User.Identity.Name); }
    }

#endregion

#region On Page Prerender

    private void Page_PreRender()
    {
        // Load the User Roles into checkboxes.
        UserRoles.DataSource = Roles.GetAllRoles();
        UserRoles.DataBind();

        // Disable checkboxes if appropriate:
        if (UserInfo.CurrentMode != DetailsViewMode.Edit)
        {
            foreach (ListItem checkbox in UserRoles.Items)
            {
                checkbox.Enabled = false;
            }
        }

        // Bind these checkboxes to the User's own set of roles.
        string[] userRoles = Roles.GetRolesForUser(username);
        foreach (string role in userRoles)
        {
            ListItem checkbox = UserRoles.Items.FindByValue(role);
            checkbox.Selected = true;
        }
    }

#endregion

#region On Page Load

    private void Page_Load()
    {
        // check if username exists in the query string
        username = Request.QueryString["username"];
        if (username == null || username == "")
        {
            Response.Redirect("default.aspx");
        }

        // get membership user account based on username sent in query string
        user = System.Web.Security.Membership.GetUser(username);
        UserUpdateMessage.Text = "";

        // get selected user's password start.................................................................
        string password = "<Hashed passwords can not be retrieved>";
        if (Membership.Provider.PasswordFormat != MembershipPasswordFormat.Hashed)
        {
            password = System.Web.Security.Membership.Providers["MembershipProviderAdmin"].GetPassword(username, null);
        }
        lblCurrentPassword.Text = password;
        // get selected user's password end...................................................................

        // Get Profile start....................................................
        if (!Page.IsPostBack)
        {
            // get country names from app_code folder
            // bind country names to the dropdown list
            ddlCountries.DataSource = CountryNames.CountryNames.GetCountries();
            ddlCountries.DataBind();

            // get the selected user's profile based on query string
            WebProfile profile = Profile;
            if (username.Length > 0)
                profile = WebProfile.Get(username);

            // Subscriptions
            ddlNewsletter.SelectedValue = profile.Preferences.Newsletter;

            // Personal Info
            txtFirstName.Text = profile.Personal.FirstName;
            txtLastName.Text = profile.Personal.LastName;
            ddlGenders.SelectedValue = profile.Personal.Gender;
            if (profile.Personal.BirthDate != DateTime.MinValue)
                txtBirthDate.Text = profile.Personal.BirthDate.ToShortDateString();
            ddlOccupations.SelectedValue = profile.Personal.Occupation;
            txtWebsite.Text = profile.Personal.Website;

            // Address Info
            ddlCountries.SelectedValue = profile.Address.Country;
            txtAddress.Text = profile.Address.Address;
            txtAptNumber.Text = profile.Address.AptNumber;
            txtCity.Text = profile.Address.City;
            txtState.Text = profile.Address.State;
            txtPostalCode.Text = profile.Address.PostalCode;

            // Contact Info
            txtDayTimePhone.Text = profile.Contacts.DayTimePhone;
            txtDayTimePhoneExt.Text = profile.Contacts.DayTimePhoneExt;
            txtEveningPhone.Text = profile.Contacts.EveningPhone;
            txtEveningPhoneExt.Text = profile.Contacts.EveningPhoneExt;
            txtCellPhone.Text = profile.Contacts.CellPhone;
            txtBusinessFax.Text = profile.Contacts.FaxBusiness;
            txtHomeFax.Text = profile.Contacts.FaxHome;
        }
        // Get Profile end.......................................................
    }

#endregion

#region Update Profile Sub

    public void SaveProfile()
    {
        // get the selected user's profile
        WebProfile profile = Profile;
        if (username.Length > 0)
            profile = WebProfile.Get(username);

        // Subscriptions
        profile.Preferences.Newsletter = ddlNewsletter.SelectedValue;

        // Personal Info
        profile.Personal.FirstName = txtFirstName.Text;
        profile.Personal.LastName = txtLastName.Text;
        profile.Personal.Gender = ddlGenders.SelectedValue;
        if (txtBirthDate.Text.Trim().Length > 0)
            profile.Personal.BirthDate = DateTime.Parse(txtBirthDate.Text);
        profile.Personal.Occupation = ddlOccupations.SelectedValue;
        profile.Personal.Website = txtWebsite.Text;

        // Address Info
        profile.Address.Country = ddlCountries.SelectedValue;
        profile.Address.Address = txtAddress.Text;
        profile.Address.AptNumber = txtAptNumber.Text;
        profile.Address.City = txtCity.Text;
        profile.Address.State = txtState.Text;
        profile.Address.PostalCode = txtPostalCode.Text;

        // Contact Info
        profile.Contacts.DayTimePhone = txtDayTimePhone.Text;
        profile.Contacts.DayTimePhoneExt = txtDayTimePhoneExt.Text;
        profile.Contacts.EveningPhone = txtEveningPhone.Text;
        profile.Contacts.EveningPhoneExt = txtEveningPhoneExt.Text;
        profile.Contacts.CellPhone = txtCellPhone.Text;
        profile.Contacts.FaxBusiness = txtBusinessFax.Text;
        profile.Contacts.FaxHome = txtHomeFax.Text;

        // this is what we will call from the button click
        // to save the user's profile
        profile.Save();
    }

#endregion

#region Update Profile Button Click

    protected void btnUpdateProfile_Click(object sender, EventArgs e)
    {
        SaveProfile();
        lblProfileMessage.Text = "Profile saved successfully!";
    }

#endregion

#region Delete Profile Button Click

    protected void btnDeleteProfile_Click(object sender, EventArgs e)
    {
        ProfileManager.DeleteProfile(username);
        lblProfileMessage.Text = "Profile deleted successfully!";

        // refresh the page to clear post back data from form fields
        Response.Redirect("edit_user.aspx?username=" + username);
    }

#endregion

#region Update Membership User Info

    protected void UserInfo_ItemUpdating(object sender, DetailsViewUpdateEventArgs e)
    {
        // Need to handle the update manually because MembershipUser does not have a
        // parameterless constructor  

        user.Email = (string)e.NewValues[0];
        user.Comment = (string)e.NewValues[1];
        user.IsApproved = (bool)e.NewValues[2];

        try
        {
            // Update user info:
            System.Web.Security.Membership.UpdateUser(user);

            // Update user roles:
            UpdateUserRoles();

            UserUpdateMessage.Text = "Update Successful.";

            // make cancel button available
            e.Cancel = true;

            // make detailsview read only
            UserInfo.ChangeMode(DetailsViewMode.ReadOnly);
        }
        catch (Exception ex)
        {
            // if there is a problem
            UserUpdateMessage.Text = "Update Failed: " + ex.Message;

            e.Cancel = true;
            UserInfo.ChangeMode(DetailsViewMode.ReadOnly);
        }
    }

#endregion

#region Update User Roles

    private void UpdateUserRoles()
    {
        // add or remove user from role based on selection
        foreach (ListItem rolebox in UserRoles.Items)
        {
            if (rolebox.Selected)
            {
                if (!Roles.IsUserInRole(username, rolebox.Text))
                {
                    Roles.AddUserToRole(username, rolebox.Text);
                }
            }
            else
            {
                if (Roles.IsUserInRole(username, rolebox.Text))
                {
                    Roles.RemoveUserFromRole(username, rolebox.Text);
                }
            }
        }
    }

#endregion

#region Delete User

    public void DeleteUser(object sender, EventArgs e)
    {
        // Membership.DeleteUser(username, false);
        ProfileManager.DeleteProfile(username);
        System.Web.Security.Membership.DeleteUser(username, true);
        Response.Redirect("default.aspx");
    }

#endregion

#region Unlock User

    public void UnlockUser(object sender, EventArgs e)
    {

        // Unlock the user.
        user.UnlockUser();

        // DataBind the DetailsView to reflect same.
        UserInfo.DataBind();
    }

#endregion

#region Add Role

    public void AddRole(object sender, EventArgs e)
    {
        // create new roles
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

#region Change Password Button Click

    public void ChangePassword_OnClick(object sender, EventArgs args)
    {
        // Update the password.
        // check if username exists in the query string
        username = Request.QueryString["username"];
        if (username == null || username == "")
        {
            Response.Redirect("default.aspx");
        }

        MembershipUser u = System.Web.Security.Membership.GetUser(username);

        try
        {
            if (u.ChangePassword(OldPasswordTextbox.Text, PasswordTextbox.Text))
            {
                Msg.Text = "Password changed successfully and will show upon refresh.";
            }
            else
            {
                Msg.Text = "Password change failed. Please re-enter your values and try again.";
            }
        }
        catch (Exception e)
        {
            Msg.Text = "An exception occurred: " + Server.HtmlEncode(e.Message) + ". Please re-enter your values and try again.";
        }
    }

#endregion

}
