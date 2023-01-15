using MySql.Data.MySqlClient;
using System;
using System.Configuration;
using System.Data;
using System.Net;
using System.Net.Mail;
using System.Net.Sockets;
using System.Web;
using System.Web.UI;

namespace villageStories
{
    public partial class LoginPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            VerifyLoginUser();
        }

        private void VerifyLoginUser()
        {
            MySqlConnection conn = new MySqlConnection(ConfigurationManager.ConnectionStrings["DBCONN_VS"].ConnectionString);
            MySqlCommand comm = new MySqlCommand();
            MySqlDataAdapter DA = new MySqlDataAdapter();
            DataTable DT = new DataTable();

            try
            {
                comm.CommandType = CommandType.StoredProcedure;
                comm.CommandText = "proc_user_verifiyLogin";
                comm.Connection = conn;

                comm.Parameters.AddWithValue("uName", txtUserName.Text);
                comm.Parameters.AddWithValue("pswd", txtPassword.Text);

                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                }

                DA = new MySqlDataAdapter(comm);
                DA.Fill(DT);

                if (DT.Rows.Count > 0)
                {
                    HttpCookie Cookie = new HttpCookie("userID");
                    Cookie.Value = DT.Rows[0]["userID"].ToString();
                    Cookie.Expires = DateTime.Now.AddMinutes(360);
                    Response.Cookies.Add(Cookie);

                    HttpCookie Cookie1 = new HttpCookie("userName");
                    Cookie1.Value = DT.Rows[0]["fullName"].ToString();
                    Cookie1.Expires = DateTime.Now.AddMinutes(360);
                    Response.Cookies.Add(Cookie1);
                    
                    HttpCookie Cookie2 = new HttpCookie("role");
                    Cookie2.Value = DT.Rows[0]["userRole"].ToString();
                    Cookie2.Expires = DateTime.Now.AddMinutes(360);
                    Response.Cookies.Add(Cookie2);

                    Response.Redirect("Dashboard.aspx", false);
                }
                else
                {
                    pnlAlert.Attributes.Add("class", "alert alert-danger");
                    pnlAlert.Visible = true;
                    lblalert.Text = "User Name or Password is Incorrect, Please try again !!!";
                }
            }
            catch (Exception ex)
            {
                string x = ex.ToString();
                pnlAlert.Attributes.Add("class", "alert alert-danger");
                pnlAlert.Visible = true;
                lblalert.Text = "ERROR !!! Please try after some time";
                //throw ex;
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

        protected void btnForgetPswd_Click(object sender, EventArgs e)
        {
            MySqlConnection conn = new MySqlConnection(ConfigurationManager.ConnectionStrings["DBCONN_VS"].ConnectionString);
            MySqlCommand comm = new MySqlCommand();
            MySqlDataAdapter DA = new MySqlDataAdapter();
            DataTable DT = new DataTable();

            try
            {
                comm.CommandType = CommandType.StoredProcedure;
                comm.CommandText = "proc_user_forgetPswd";
                comm.Connection = conn;

                comm.Parameters.AddWithValue("uName", txtUserName.Text);

                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                }

                DA = new MySqlDataAdapter(comm);
                DA.Fill(DT);

                if (DT.Rows.Count > 0)
                {
                    SendPasswordMail(txtUserName.Text,DT.Rows[0]["password"].ToString());
                }
                else
                {
                    pnlAlert.Attributes.Add("class", "alert alert-danger");
                    pnlAlert.Visible = true;
                    lblalert.Text = "User name is not exist !!!";
                }
            }
            catch (Exception ex)
            {
                string x = ex.ToString();
                pnlAlert.Attributes.Add("class", "alert alert-danger");
                pnlAlert.Visible = true;
                lblalert.Text = "ERROR !!! Please try after some time";
                //throw ex;
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

        private void SendPasswordMail(string uName, string pswd)
        {
            string SMTPServerName = ConfigurationManager.AppSettings["SMTPServerName"].ToString();
            string SMTPUser = ConfigurationManager.AppSettings["SMTPUser"].ToString();
            string SMTPPassword = ConfigurationManager.AppSettings["SMTPPassword"].ToString();
            string strMessage = string.Empty;
            try
            {
                strMessage = strMessage + "<table width=\"95%\" border=\"0\" align=\"center\" cellpadding=\"2\" cellspacing=\"1\" style=\"FONT-SIZE: 9pt; COLOR: black; DIRECTION: ltr; LINE-HEIGHT: 12pt; FONT-FAMILY: Arial; LETTER-SPACING: normal; TEXT-ALIGN: justify\">";
                strMessage = strMessage + "<tr><td>Your username and password of admin panel of clover website is mention below:</td></tr>";
                strMessage = strMessage + "<tr><td height='7'></td></tr>";
                strMessage = strMessage + "<tr><td>User Name - " + uName + "</td></tr>";
                strMessage = strMessage + "<tr><td height='10'></td></tr>";
                strMessage = strMessage + "<tr><td>Password - " + pswd + "</td></tr>";
                strMessage = strMessage + "<tr><td height='20'></td></tr>";
                strMessage = strMessage + "</table>";

                MailMessage mm = new MailMessage();
                mm.IsBodyHtml = true;
                mm.From = new MailAddress(ConfigurationManager.AppSettings["CONST_MAIL_SIGNUP_FROM"].ToString());
                mm.To.Add(new MailAddress(ConfigurationManager.AppSettings["AdminEmail"].ToString()));
                mm.Subject = ConfigurationManager.AppSettings["forgetPassSub"].ToString();
                mm.Body = strMessage.ToString();

                SmtpClient mSmtpClient = new SmtpClient();
                mSmtpClient.EnableSsl = true;
                mSmtpClient.Host = SMTPServerName;
                mSmtpClient.Port = Convert.ToInt32(ConfigurationManager.AppSettings["SMTP_Port"]);
                mSmtpClient.Credentials = new System.Net.NetworkCredential(SMTPUser, SMTPPassword);
                mSmtpClient.Send(mm);

                pnlAlert.Attributes.Add("class", "alert alert-success");
                pnlAlert.Visible = true;
                lblalert.Text = "Please check your email inbox.";
            }
            catch (Exception ex)
            {

                pnlAlert.Attributes.Add("class", "alert alert-danger");
                pnlAlert.Visible = true;
                lblalert.Text = "Send password mail error - Please try again";
                //lblalert.Text = "Forget password - " + ex.Message;

            }
        }
    }
}