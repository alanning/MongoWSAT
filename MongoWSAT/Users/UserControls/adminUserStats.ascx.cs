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

public partial class UserControls_adminUserStats : System.Web.UI.UserControl
{

#region count total users and users online

    // get number of registred users and assign it to global variable
    private MembershipUserCollection allRegisteredUsers = Membership.GetAllUsers();

    protected void Page_Load(object sender, EventArgs e)
    {
        // get the number of registered and online users and bind them to the labels on the page
        // For counting users online, global.asax is used
        if (!Page.IsPostBack)
        {
            //lblOnlineUsers.Text = Membership.GetNumberOfUsersOnline().ToString();
            lblOnlineUsers.Text = Application["OnlineUsers"].ToString();
            lblTotalUsers.Text = allRegisteredUsers.Count.ToString();
        }
    }

#endregion

}
