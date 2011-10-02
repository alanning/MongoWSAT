using System.Web.UI.WebControls;

public partial class RecoverPassword : System.Web.UI.Page
{

#region send carbon copy to webmaster

    // this code sends a duplicate email to the webmaster (address below must be corrected)
    // we could have done this from the MailDefinitions property window but it was more fun this way
    protected void PasswordRecovery1_SendingMail(object sender, MailMessageEventArgs e)
    {
        // e.Message.CC.Add("postmaster@mycompany.com");
    }

#endregion

}
