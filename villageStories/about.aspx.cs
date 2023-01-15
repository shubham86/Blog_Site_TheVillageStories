using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace villageStories
{
    public partial class about : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                advertiseBanner();
            }

            if (Request.QueryString["action"] != null)
            {
                if (Request.QueryString["action"].ToString() == "send")
                {
                    pnlCommentAlert.Attributes.Add("class", "alert-message ot-shortcode-alert-message alert-green");
                    pnlCommentAlert.Visible = true;
                    lblCommentAlert.Text = "Thank you !!!";

                    ClientScript.RegisterStartupScript(this.GetType(), "Scroll", "scrollToComment();", true);
                }
            }
        }

        private void advertiseBanner()
        {
            MySqlConnection conn = new MySqlConnection(ConfigurationManager.ConnectionStrings["DBCONN_VS"].ConnectionString);
            MySqlCommand comm = new MySqlCommand();
            MySqlDataAdapter DA = new MySqlDataAdapter();
            DataTable DT = new DataTable();

            try
            {
                comm.CommandType = CommandType.StoredProcedure;
                comm.CommandText = "proc_Advertise_fetchRandomAdv";
                comm.Connection = conn;

                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                }

                DA = new MySqlDataAdapter(comm);
                DA.Fill(DT);

                if (DT.Rows.Count > 0)
                {
                    aVerticalAdv.HRef = DT.Rows[0]["webLink"].ToString();
                    aVerticalAdv.Title = DT.Rows[0]["companyName"].ToString();
                    imgVerticalAdv.Src = "cpanel/Advertise/" + DT.Rows[0]["verticalImg"].ToString();
                    imgVerticalAdv.Alt = DT.Rows[0]["companyName"].ToString();
                }
                else
                {
                    advContainer.Visible = false;
                }
            }
            catch (Exception ex)
            {
                string x = ex.ToString();
            }

            finally
            {
                if (conn.State == ConnectionState.Open)
                {
                    conn.Close();
                }

                comm.Dispose();
                conn.Dispose();
            }
        }


        protected void btnComment_Click(object sender, EventArgs e)
        {
            sendEnquiry(txtName.Value, txtEmail.Value, txtMobile.Value, txtComment.Value);
        }


        private void sendEnquiry(string name, string email, string mobile, string message)
        {
            string SMTPServerName = ConfigurationManager.AppSettings["SMTPServerName"].ToString();
            string SMTPUser = ConfigurationManager.AppSettings["SMTPUser"].ToString();
            string SMTPPassword = ConfigurationManager.AppSettings["SMTPPassword"].ToString();
            string strMessage = string.Empty;
            try
            {
                strMessage = strMessage + "<table width=\"95%\" border=\"0\" align=\"center\" cellpadding=\"2\" cellspacing=\"1\" style=\"FONT-SIZE: 9pt; COLOR: black; DIRECTION: ltr; LINE-HEIGHT: 12pt; FONT-FAMILY: Arial; LETTER-SPACING: normal; TEXT-ALIGN: justify\">";
                strMessage = strMessage + "<tr><td>Name - " + name + ",</td></tr>";
                strMessage = strMessage + "<tr><td height='20'></td></tr>";
                strMessage = strMessage + "<tr><td>Mobile Number - <a href='tel:" + mobile + "'>" + mobile + "</a>,</td></tr>";
                strMessage = strMessage + "<tr><td height='20'></td></tr>";
                strMessage = strMessage + "<tr><td>Email-ID - " + email + ",</td></tr>";
                strMessage = strMessage + "<tr><td height='20'></td></tr>";
                strMessage = strMessage + "<tr><td>" + message + "</td></tr>";
                strMessage = strMessage + "<tr><td height='20'></td></tr>";
                strMessage = strMessage + "</table>";

                MailMessage mm = new MailMessage();
                mm.IsBodyHtml = true;
                mm.From = new MailAddress(ConfigurationManager.AppSettings["CONST_MAIL_SIGNUP_FROM"].ToString());
                mm.To.Add(new MailAddress(ConfigurationManager.AppSettings["AdminEmail"].ToString()));
                mm.Subject = "The village stories - Visitor message";
                mm.Body = strMessage.ToString();

                SmtpClient mSmtpClient = new SmtpClient();
                mSmtpClient.EnableSsl = true;
                mSmtpClient.Host = SMTPServerName;
                mSmtpClient.Port = Convert.ToInt32(ConfigurationManager.AppSettings["SMTP_Port"]);
                mSmtpClient.UseDefaultCredentials = true;
                mSmtpClient.Credentials = new System.Net.NetworkCredential(SMTPUser, SMTPPassword);
                mSmtpClient.Send(mm);
            }
            catch (Exception ex)
            {
                string x = ex.ToString();
            }
            finally
            {
                txtName.Value = "";
                txtEmail.Value = "";
                txtMobile.Value = "";
                txtComment.Value = "";

                Response.Redirect("about.aspx?action=send");
            }
        }
    }
}