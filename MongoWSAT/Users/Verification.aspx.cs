using System;
using System.Web.Security;
using System.Security.Principal;

public partial class Verification : System.Web.UI.Page
{

#region verify user

    // this code verifies the submitted URL and unlocks the user's account

    protected void Page_Load(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(Request.QueryString["ID"]))
            StatusMessage.Text = "The UserId was not included in the querystring...";
        else
        {
            Guid userId;

            try
            {
                userId = new Guid(Request.QueryString["ID"]);
            }
            catch
            {
                StatusMessage.Text = "The UserId passed into the querystring is not in the proper format...";
                return;
            }

            MembershipUser usr = Membership.GetUser(userId);
            if (usr == null)
                StatusMessage.Text = "User account could not be found...";
            else
            {
                // Approve the user
                if (!usr.IsApproved)
                {
                    usr.IsApproved = true;
                    Membership.UpdateUser(usr);

                    // user is a temporary IPrincipal just used to Provision New User so give it 
                    // whatever roles are needed to set up the user's account properly.
                    // NOTE: These roles will _not_ be saved in the Membership datastore.
                    string[] roles = new string[] { /* PUT ROLES REQUIRED FOR USER ACCOUNT SETUP HERE */ };
                    IPrincipal user = new GenericPrincipal(new GenericIdentity(usr.UserName),roles);

                    ProvisionNewUser(user);
                }
                StatusMessage.Text = "Your account has been approved. Please <a href=\"Login.aspx\">login</a> to the site.";
            }
        }
    }

    protected void ProvisionNewUser(IPrincipal user)
    {
        // Perform any actions required to set up the User's account now that he/she has completed Verification
    }

#endregion

}
