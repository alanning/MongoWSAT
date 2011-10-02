using System;
using System.Data;
using System.Data.SqlClient;
using System.Net.Mail;
using System.Web.Configuration;
using System.Web.UI.WebControls;

public partial class Admin_Quick_contact : System.Web.UI.Page
{

#region Page Load Events

    // enable disable buttons
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["letter"] == "" || GridView1.Rows.Count == 0)
        {
            btnSendEmail.Enabled = false;
            btnSelectAll.Enabled = false;
            btnUnselectAll.Enabled = false;
            WYSIWYGEditor_EmailBody.Visible = false;
        }
    }

#endregion

#region Send Email Button Click Event

    //create subprocedure for send email button click
    protected void btnSendEmail_Click(object sender, System.EventArgs e)
    {
        foreach (GridViewRow row in GridView1.Rows)
        {
            CheckBox cb = (CheckBox)row.FindControl("chkRows");
            if (cb != null && cb.Checked)
            {
                try
                {
                    System.Net.Mail.MailMessage MyMailer = new System.Net.Mail.MailMessage();

                    string Email = GridView1.DataKeys[row.RowIndex].Value.ToString();

                    MyMailer.To.Add(Email);
                    MyMailer.From = new MailAddress(txtMailFrom.Text);
                    MyMailer.Subject = txb_Subject.Text;
                    MyMailer.Body = WYSIWYGEditor_EmailBody.Text;
                    MyMailer.IsBodyHtml = Convert.ToBoolean(rbt_BodyTextType.SelectedValue);

                    switch (rbt_Importance.SelectedValue)
                    {
                        case "Low":
                            MyMailer.Priority = MailPriority.Low;
                            break;
                        case "Normal":
                            MyMailer.Priority = MailPriority.Normal;
                            break;
                        case "High":
                            MyMailer.Priority = MailPriority.High;
                            break;
                    }

                    System.Net.Mail.SmtpClient smtp = new System.Net.Mail.SmtpClient();
                    smtp.Send(MyMailer);

                    lbl_SendResults.Text = ":  Message sent successfully...";
                }
                catch (Exception ex)
                {
                    lbl_SendResults.Text += ": ERROR: Problem sending email!" + ex.Message;
                }
            }
        }
    }

#endregion

#region Toggle Checkboxes - select all - unselect all

    //create private subprocedure for button toggle as a boolean (on/off)
    private void ToggleCheckState(bool checkState)
    {
        foreach (GridViewRow row in GridView1.Rows)
        {
            CheckBox cb = (CheckBox)row.FindControl("chkRows");
            if (cb != null)
            {
                cb.Checked = checkState;
            }
        }
    }

    //create subprocedure click event for select all button
    protected void btnSelectAll_Click(object sender, EventArgs e)
    {
        ToggleCheckState(true);

    }

    protected void btnUnselectAll_Click(object sender, EventArgs e)
    {
        ToggleCheckState(false);
    }

#endregion

}
