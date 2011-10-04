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

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    protected void btn1_Click(object sender, EventArgs e)
    {
        err.Text = "";
        lbl.Text = "";
        MembershipCreateStatus status;

        // create Test user
        Membership.CreateUser("test","nimda123*","test@example.com","demo","demo",true, out status);
        if (MembershipCreateStatus.Success != status)
        {
            err.Text = "Could not create test or admin user. An error occurred while creating test user: " + ErrorCodeToString(status);
            return;
        }

        // create Admin user
        MembershipUser mu = Membership.CreateUser("admin","nimda123*","test@example.com","demo","demo",true, out status);
        if (MembershipCreateStatus.Success != status)
        {
            err.Text = "Created test user but could not create admin user. An error occurred while creating admin user: " + ErrorCodeToString(status);
            return;
        }
        if (!Roles.RoleExists("administrator"))
        {
            Roles.CreateRole("administrator");
        }
        Roles.AddUserToRole(mu.UserName, "administrator");
        lbl.Text = "Success";
    }

    private static string ErrorCodeToString(MembershipCreateStatus createStatus)
    {
        // See http://go.microsoft.com/fwlink/?LinkID=177550 for
        // a full list of status codes.
        switch (createStatus)
        {
            case MembershipCreateStatus.DuplicateUserName:
                return "User name already exists. Please enter a different user name.";

            case MembershipCreateStatus.DuplicateEmail:
                return "A user name for that e-mail address already exists. Please enter a different e-mail address.";

            case MembershipCreateStatus.InvalidPassword:
                return "The password provided is invalid. Please enter a valid password value.";

            case MembershipCreateStatus.InvalidEmail:
                return "The e-mail address provided is invalid. Please check the value and try again.";

            case MembershipCreateStatus.InvalidAnswer:
                return "The password retrieval answer provided is invalid. Please check the value and try again.";

            case MembershipCreateStatus.InvalidQuestion:
                return "The password retrieval question provided is invalid. Please check the value and try again.";

            case MembershipCreateStatus.InvalidUserName:
                return "The user name provided is invalid. Please check the value and try again.";

            case MembershipCreateStatus.ProviderError:
                return "The authentication provider returned an error. Please verify your entry and try again. If the problem persists, please contact your system administrator.";

            case MembershipCreateStatus.UserRejected:
                return "The user creation request has been canceled. Please verify your entry and try again. If the problem persists, please contact your system administrator.";

            default:
                return "An unknown error occurred. Please verify your entry and try again. If the problem persists, please contact your system administrator.";
        }
    }
}
