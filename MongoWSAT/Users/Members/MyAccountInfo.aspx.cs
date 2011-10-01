using System;
using System.Web.Profile;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Members_MyAccountInfo : System.Web.UI.Page
{

    private WebProfile Profile
    {
        get { return WebProfile.Get(Context.User.Identity.Name); }
    }

#region on page load get current profile

    protected void Page_Load(object sender, EventArgs e)
    {
        // Get Profile start....................................................
        if (!Page.IsPostBack)
        {
            if (Page.User.Identity.IsAuthenticated)
            {
                // get country names from app_code folder
                // bind country names to the dropdown list
                ddlCountries.DataSource = CountryNames.CountryNames.GetCountries();
                ddlCountries.DataBind();

                // get the selected user's profile based on query string
                WebProfile profile = Profile;

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
        }
        // Get Profile end.......................................................
    }

#endregion

#region Update current Profile Sub

    public void SaveProfile()
    {
        if (Page.User.Identity.IsAuthenticated)
        {
            // get the selected user's profile
            WebProfile profile = Profile;

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
    }

#endregion

#region update user info in detailsview

    protected void DetailsView1_ItemUpdating(object sender, DetailsViewUpdateEventArgs e)
    {
        //Need to handle the update manually because MembershipUser does not have a
        //parameterless constructor  
        MembershipUser memUser = Membership.GetUser();

        memUser.Email = (string)e.NewValues[0];
        //memUser.Comment = (string)e.NewValues[1];
        //memUserIsApproved = (bool)e.NewValues[2];
        try
        {
            Membership.UpdateUser(memUser);

            e.Cancel = true;
            DetailsView1.ChangeMode(DetailsViewMode.ReadOnly);
        }
        catch (Exception ex)
        {
            Response.Write("<div>The following error occurred:<font color='red'> " + ex.Message + "</font></div>");
            e.Cancel = true;
        }
    }

#endregion

#region delete user account

    protected void btnDeleteCurrentUser_Click(object sender, EventArgs e)
    {
        if (Membership.DeleteUser(User.Identity.Name))
        {
            FormsAuthentication.SignOut();
            Roles.DeleteCookie();
            Response.Redirect("~/AccountRemoved.aspx");
        }
        else
        {
            lblResult.Visible = true;
            lblResult.Text = "The Membership user was not deleted.";
        }

    }

#endregion

#region Update current Profile Button Click

    protected void btnUpdateProfile_Click(object sender, EventArgs e)
    {
        SaveProfile();
        lblProfileMessage.Text = "Profile saved successfully!";
    }

#endregion

#region Delete current profile button click

    protected void btnDeleteProfile_Click(object sender, EventArgs e)
    {
        ProfileManager.DeleteProfile(User.Identity.Name);
        lblProfileMessage.Text = "Profile deleted successfully!";

        // refresh the page to clear post back data from form fields
        Response.Redirect("MyAccountInfo.aspx");
    }

#endregion

}
