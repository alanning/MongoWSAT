using System;
using System.Web.Security;
using System.Web.UI.WebControls;

public partial class Register : System.Web.UI.Page
{

#region check for leading and trailing spaces in user name 

    // this code checks for leading and trailing spaces in username
    // and makes sure the username does not appear in the password
    protected void CreateUserWizard1_CreatingUser(object sender, LoginCancelEventArgs e)
    {
        // declare variable and assign it to the user name textbox
        string trimmedUserName = CreateUserWizard1.UserName.Trim();

        // Check for empty spaces infront and behind the string
        if (CreateUserWizard1.UserName.Length != trimmedUserName.Length)      
        {           
            // Show the error message           
            InvalidUserNameOrPasswordMessage.Text = "The username cannot contain leading or trailing spaces.";           
            InvalidUserNameOrPasswordMessage.Visible = true;           
            // Cancel the create user workflow           
            e.Cancel = true;      
        }      
        else      
        {           
            /*
            // Username is valid, make sure that the password does not contain the username           
            if (CreateUserWizard1.Password.IndexOf(CreateUserWizard1.UserName, StringComparison.OrdinalIgnoreCase) >= 0)           
            {                
                // Show the error message                
                InvalidUserNameOrPasswordMessage.Text = "The username may not appear anywhere in the password.";                
                InvalidUserNameOrPasswordMessage.Visible = true;
                
                // Cancel the create user workflow                
                e.Cancel = true;           
            }      
            */
        }
    }

#endregion

#region send verification email 

    // this code uses the CreateUserWizard.txt file in the EmailTemplates folder
    // it creates and sends a verification URL to the user before allowing login
    // user must click on link in email to verify email address
    // the verification takes place in Verification.aspx file
    protected void CreateUserWizard1_SendingMail(object sender, MailMessageEventArgs e)
    {
        // Get the UserId of the just-added user
        MembershipUser newUser = Membership.GetUser(CreateUserWizard1.UserName);
        Guid newUserId = (Guid)newUser.ProviderUserKey;

        // Determine the full verification URL (i.e., http://yoursite.com/Verification.aspx?ID=...)
        string urlBase = Request.Url.GetLeftPart(UriPartial.Authority) + Request.ApplicationPath;
        string verifyUrl = "/Users/Verification.aspx?ID=" + newUserId.ToString();
        string fullUrl = urlBase + verifyUrl;

        // Replace <%VerificationUrl%> with the appropriate URL and querystring
        e.Message.Body = e.Message.Body.Replace("<%VerificationUrl%>", fullUrl);
    }

#endregion

}
