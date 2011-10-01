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
        lbl.Text = "";

        MembershipCreateStatus status;
        MembershipUser mu = Membership.CreateUser("admin","nimda123*","test@test.com","demo","demo",true, out status);
        if (!Roles.RoleExists("Administrators"))
        {
            Roles.CreateRole("Administrators");
        }
        Roles.AddUserToRole(mu.UserName, "Administrators");

        string password = "<Hashed passwords can not be retrieved>";
        if (Membership.Provider.PasswordFormat != MembershipPasswordFormat.Hashed)
        {
            password = System.Web.Security.Membership.Providers["MembershipProviderAdmin"].GetPassword(mu.UserName, null);
        }
        lbl.Text = password;
    }

    protected void btn2_Click(object sender, EventArgs e)
    {
        
        bool mu = Membership.DeleteUser("admin", true);
        

    }
}
