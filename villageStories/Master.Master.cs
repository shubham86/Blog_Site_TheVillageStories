using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace villageStories
{
    public partial class Master : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack) {
                //advertiseBanner();
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
                comm.CommandText = "proc_Advertise_fetchRandom_HorizontalAdv";
                comm.Connection = conn;

                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                }

                DA = new MySqlDataAdapter(comm);
                DA.Fill(DT);

                if (DT.Rows.Count > 0)
                {
                    aHorizontalAdv.HRef = DT.Rows[0]["webLink"].ToString();
                    aHorizontalAdv.Title = DT.Rows[0]["companyName"].ToString();
                    imgHorizontalAdv.Src = "cpanel/Advertise/" + DT.Rows[0]["horizontalImg"].ToString();
                    imgHorizontalAdv.Alt = DT.Rows[0]["companyName"].ToString();
                }
                else
                {
                    advHcontainer.Visible = false;
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

        private Boolean validateSubscriber()
        {
            MySqlConnection conn = new MySqlConnection(ConfigurationManager.ConnectionStrings["DBCONN_VS"].ConnectionString);
            MySqlCommand comm = new MySqlCommand();
            MySqlDataAdapter DA = new MySqlDataAdapter();
            DataTable DT = new DataTable();
            Boolean retval = false;

            try
            {
                comm.CommandType = CommandType.StoredProcedure;
                comm.CommandText = "proc_newsletter_validation";
                comm.Connection = conn;

                comm.Parameters.AddWithValue("email", txtEmail.Value);

                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                }

                DA = new MySqlDataAdapter(comm);
                DA.Fill(DT);

                if (DT.Rows.Count > 0)
                {
                    retval = false;
                }
                else
                {
                    retval = true;
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

            return retval;
        }

        private void addNewsletter()
        {
            MySqlConnection conn = new MySqlConnection(ConfigurationManager.ConnectionStrings["DBCONN_VS"].ConnectionString);
            MySqlCommand comm = new MySqlCommand();

            try
            {
                comm.CommandType = CommandType.StoredProcedure;
                comm.CommandText = "proc_newsletter_addEmail";
                comm.Connection = conn;

                comm.Parameters.AddWithValue("email", txtEmail.Value);

                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                }
                
                if (comm.ExecuteNonQuery() > 0)
                {
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "Scroll", "scrollToComment();", true);
                }
                else
                {
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "Scroll", "scrollToComment1();", true);
                }
            }
            catch (Exception ex)
            {
                string x = ex.ToString();
                Page.ClientScript.RegisterStartupScript(this.GetType(), "Scroll", "scrollToComment1();", true);
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

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (validateSubscriber())
            {
                addNewsletter();
            }
            else {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "Scroll", "scrollToComment2();", true);
            }
            
        }
    }
}