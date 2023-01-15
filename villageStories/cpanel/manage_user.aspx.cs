using MySql.Data.MySqlClient;
using System;
using System.Configuration;
using System.Data;
using System.Globalization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace villageStories.cpanel
{
    public partial class manage_user : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.Cookies["userID"] == null)
            {
                Response.Redirect("Logout.aspx", false);
                return;
            }

            if (!Page.IsPostBack)
            {
                if (Request.QueryString["action"] != null)
                {
                    if (Request.QueryString["action"].ToString() == "change")
                    {
                        pnlAlert.Attributes.Add("class", "alert alert-success");
                        pnlAlert.Visible = true;
                        lblAlert.Text = "Status Changed successfully";
                    }
                    else if (Request.QueryString["action"].ToString() == "add")
                    {
                        pnlAlert.Attributes.Add("class", "alert alert-success");
                        pnlAlert.Visible = true;
                        lblAlert.Text = "User added successfully";
                    }
                    else if (Request.QueryString["action"].ToString() == "update")
                    {
                        pnlAlert.Attributes.Add("class", "alert alert-success");
                        pnlAlert.Visible = true;
                        lblAlert.Text = "User updated successfully";
                    }
                }

                fillRepeter();
            }
        }

        private void fillRepeter()
        {
            MySqlConnection conn = new MySqlConnection(ConfigurationManager.ConnectionStrings["DBCONN_VS"].ConnectionString);
            MySqlCommand comm = new MySqlCommand();
            MySqlDataAdapter DA = new MySqlDataAdapter();
            DataTable DT = new DataTable();

            try
            {
                comm.CommandType = CommandType.StoredProcedure;
                comm.CommandText = "proc_user_getList";
                comm.Connection = conn;

                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                }

                DA = new MySqlDataAdapter(comm);
                DA.Fill(DT);

                if (DT.Rows.Count > 0)
                {
                    rptrUser.DataSource = DT;
                    rptrUser.DataBind();
                }
                else
                {
                    rptrUser.DataSource = null;
                    rptrUser.DataBind();
                }
            }
            catch (Exception ex)
            {
                string x = ex.ToString();
                pnlAlert.Attributes.Add("class", "alert alert-danger");
                pnlAlert.Visible = true;
                lblAlert.Text = "ERROR !!! Please try after some time";
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

        protected void rptrUser_RowCommand(object sender, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "edit")
            {

                string[] arrg = e.CommandArgument.ToString().Split(';');
                string val = arrg[4].ToString() == "Admin" ? "1" : "2";
                lblUserID.Text = arrg[0];
                txtFullName.Text = arrg[1];
                txtUserName.Text = arrg[2];
                txtPassword.Text = arrg[3];
                ddlRole.ClearSelection();
                ddlRole.Items.FindByValue(val).Selected = true;

                btnUserSave.Text = "Update";
            }

            if (e.CommandName == "status")
            {
                changeStatus(Convert.ToInt32(e.CommandArgument));
                fillRepeter();
            }
        }
        
        private void changeStatus(int id)
        {
            MySqlConnection conn = new MySqlConnection(ConfigurationManager.ConnectionStrings["DBCONN_VS"].ConnectionString);
            MySqlCommand comm = new MySqlCommand();

            try
            {
                comm.CommandType = CommandType.StoredProcedure;
                comm.CommandText = "proc_user_changeStatus";
                comm.Connection = conn;

                comm.Parameters.AddWithValue("uId", id);

                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                }

                if (comm.ExecuteNonQuery() > 0)
                {
                    Response.Redirect("manage_user.aspx?action=change");
                }
                else
                {
                    pnlAlert.Attributes.Add("class", "alert alert-danger");
                    pnlAlert.Visible = true;
                    lblAlert.Text = "Status change ERROR !!! Please try after some time";
                }

            }
            catch (Exception ex)
            {
                string x = ex.ToString();
                pnlAlert.Attributes.Add("class", "alert alert-danger");
                pnlAlert.Visible = true;
                lblAlert.Text = "ERROR !!! Please try after some time";
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

        protected void btnUserSave_Click(object sender, EventArgs e)
        {
            if (lblUserID.Text == "0")
            {
                if (addVAlidation())
                {
                    addUser();
                }
                else
                {
                    pnlAlert.Attributes.Add("class", "alert alert-warning");
                    pnlAlert.Visible = true;
                    lblAlert.Text = "User Name already exist";
                }
            }
            else
            {
                if (updateVAlidation())
                {
                    updateUser();
                }
                else
                {
                    pnlAlert.Attributes.Add("class", "alert alert-warning");
                    pnlAlert.Visible = true;
                    lblAlert.Text = "User Name already exist";
                }
            }
        }

        private void addUser()
        {
            MySqlConnection conn = new MySqlConnection(ConfigurationManager.ConnectionStrings["DBCONN_VS"].ConnectionString);
            MySqlCommand comm = new MySqlCommand();

            try
            {
                comm.CommandType = CommandType.StoredProcedure;
                comm.CommandText = "proc_user_add";
                comm.Connection = conn;

                comm.Parameters.AddWithValue("uFullName", CultureInfo.CurrentCulture.TextInfo.ToTitleCase(txtFullName.Text.ToLower()).Trim());
                comm.Parameters.AddWithValue("uName", txtUserName.Text);
                comm.Parameters.AddWithValue("pswd", txtPassword.Text);
                comm.Parameters.AddWithValue("role", ddlRole.SelectedItem.Text);

                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                }

                if (comm.ExecuteNonQuery() > 0)
                {
                    clearForm();
                    Response.Redirect("manage_user.aspx?action=add");                    
                }
                else
                {
                    pnlAlert.Attributes.Add("class", "alert alert-danger");
                    pnlAlert.Visible = true;
                    lblAlert.Text = "User add ERROR !!! Please try after some time";
                }

            }
            catch (Exception ex)
            {
                string x = ex.ToString();
                pnlAlert.Attributes.Add("class", "alert alert-danger");
                pnlAlert.Visible = true;
                lblAlert.Text = "ERROR !!! Please try after some time";
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

        private bool addVAlidation()
        {
            bool ret = false;
            MySqlConnection conn = new MySqlConnection(ConfigurationManager.ConnectionStrings["DBCONN_VS"].ConnectionString);
            MySqlCommand comm = new MySqlCommand();
            MySqlDataAdapter DA = new MySqlDataAdapter();
            DataTable DT = new DataTable();

            try
            {
                comm.CommandType = CommandType.StoredProcedure;
                comm.CommandText = "proc_user_addValidation";
                comm.Connection = conn;

                comm.Parameters.AddWithValue("uName", txtUserName.Text);     

                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                }

                DA = new MySqlDataAdapter(comm);
                DA.Fill(DT);

                if (Convert.ToInt32(DT.Rows[0]["count"]) > 0)
                {
                    return false;
                }
                else
                {
                    return true;
                }

            }
            catch (Exception ex)
            {
                string x = ex.ToString();
                pnlAlert.Attributes.Add("class", "alert alert-danger");
                pnlAlert.Visible = true;
                lblAlert.Text = "ERROR !!! Please try after some time";
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
            return ret;
        }

        private void updateUser()
        {
            MySqlConnection conn = new MySqlConnection(ConfigurationManager.ConnectionStrings["DBCONN_VS"].ConnectionString);
            MySqlCommand comm = new MySqlCommand();

            try
            {
                comm.CommandType = CommandType.StoredProcedure;
                comm.CommandText = "proc_user_update";
                comm.Connection = conn;

                comm.Parameters.AddWithValue("uID", lblUserID.Text);
                comm.Parameters.AddWithValue("uFullName", CultureInfo.CurrentCulture.TextInfo.ToTitleCase(txtFullName.Text.ToLower()).Trim());
                comm.Parameters.AddWithValue("uName", txtUserName.Text);
                comm.Parameters.AddWithValue("pswd", txtPassword.Text);
                comm.Parameters.AddWithValue("role", ddlRole.SelectedItem.Text);

                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                }

                if (comm.ExecuteNonQuery() > 0)
                {
                    clearForm();
                    Response.Redirect("manage_user.aspx?action=update");
                }
                else
                {
                    pnlAlert.Attributes.Add("class", "alert alert-danger");
                    pnlAlert.Visible = true;
                    lblAlert.Text = "User update ERROR !!! Please try after some time";
                }

            }
            catch (Exception ex)
            {
                string x = ex.ToString();
                pnlAlert.Attributes.Add("class", "alert alert-danger");
                pnlAlert.Visible = true;
                lblAlert.Text = "ERROR !!! Please try after some time";
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

        private bool updateVAlidation()
        {
            bool ret = false;
            MySqlConnection conn = new MySqlConnection(ConfigurationManager.ConnectionStrings["DBCONN_VS"].ConnectionString);
            MySqlCommand comm = new MySqlCommand();
            MySqlDataAdapter DA = new MySqlDataAdapter();
            DataTable DT = new DataTable();

            try
            {
                comm.CommandType = CommandType.StoredProcedure;
                comm.CommandText = "proc_user_updateValidation";
                comm.Connection = conn;

                comm.Parameters.AddWithValue("uID", lblUserID.Text);
                comm.Parameters.AddWithValue("uName", txtUserName.Text);

                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                }

                DA = new MySqlDataAdapter(comm);
                DA.Fill(DT);

                if (Convert.ToInt32(DT.Rows[0]["count"]) > 0)
                {
                    return false;
                }
                else
                {
                    return true;
                }

            }
            catch (Exception ex)
            {
                string x = ex.ToString();
                pnlAlert.Attributes.Add("class", "alert alert-danger");
                pnlAlert.Visible = true;
                lblAlert.Text = "ERROR !!! Please try after some time";
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
            return ret;
        }

        private void clearForm()
        {
            txtFullName.Text = "";
            txtPassword.Text = "";
            txtUserName.Text = "";
            lblUserID.Text = "0";
            btnUserSave.Text = "Save";
            ddlRole.ClearSelection();
        }

        protected void btnUserCancel_Click(object sender, EventArgs e)
        {
            clearForm();
        }
    }
}