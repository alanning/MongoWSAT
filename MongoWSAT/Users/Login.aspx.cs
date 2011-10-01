using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;

public partial class Login : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        Login1.FindControl("UserName").Focus();
    }

#region login authentication with captcha

    protected void Login1_Authenticate(object sender, AuthenticateEventArgs e)
    {
        // We need to determine if the user is authenticated and set e.Authenticated accordingly
        // Get the values entered by the user
        string loginUsername = Login1.UserName;
        string loginPassword = Login1.Password;

        //WebControlCaptcha.CaptchaControl loginCAPTCHA = (WebControlCaptcha.CaptchaControl)Login1.FindControl("CAPTCHA");

        // First, check if CAPTCHA matches up
        //if (!loginCAPTCHA.UserValidated)
        if (false) {
            // CAPTCHA invalid
            //Login1.FailureText = "The code you entered did not match up with the image provided; please try again with this new image.";
            //e.Authenticated = false;
        }
        else
        {
            // Next, determine if the user's username/password are valid
            if (Membership.ValidateUser(loginUsername, loginPassword))
            {
                e.Authenticated = true;
            }
            else
            {
                e.Authenticated = false;
                Login1.FailureText = "Your username and/or password are invalid.";
            }
        }
    }

#endregion

#region display failure message in clientside alert box

    protected void Login1_LoginError(object sender, EventArgs e)
    {
        //Display the failure message in a client-side alert box
        //ClientScript.RegisterStartupScript(this.GetType(), "LoginError", string.Format("alert('{0}');", Login1.FailureText.Replace("'", "\\'")), true);
    }

#endregion

}
