using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace villageStories.cpanel
{
    public partial class manage_blogs : System.Web.UI.Page
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
                        lblAlert.Text = "Blog added successfully";
                    }
                    else if(Request.QueryString["action"].ToString() == "update")
                    {
                        pnlAlert.Attributes.Add("class", "alert alert-success");
                        pnlAlert.Visible = true;
                        lblAlert.Text = "Blog updated successfully";
                    }
                    else if(Request.QueryString["action"].ToString() == "delete")
                    {
                        pnlAlert.Attributes.Add("class", "alert alert-success");
                        pnlAlert.Visible = true;
                        lblAlert.Text = "Blog deleted successfully";
                    }
                }
                
                fillRepeter(ddlCategory.SelectedItem.Text);
            }
        }


        private void fillRepeter(string category)
        {
            MySqlConnection conn = new MySqlConnection(ConfigurationManager.ConnectionStrings["DBCONN_VS"].ConnectionString);
            MySqlCommand comm = new MySqlCommand();
            MySqlDataAdapter DA = new MySqlDataAdapter();
            DataTable DT = new DataTable();

            try
            {
                comm.CommandType = CommandType.StoredProcedure;
                comm.CommandText = "proc_bologpost_fetchInRepeater";
                comm.Connection = conn;

                comm.Parameters.AddWithValue("cat", category);

                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                }

                DA = new MySqlDataAdapter(comm);
                DA.Fill(DT);

                if (DT.Rows.Count > 0)
                {
                    rptrBlog.DataSource = DT;
                    rptrBlog.DataBind();
                }
                else
                {
                    rptrBlog.DataSource = null;
                    rptrBlog.DataBind();
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

        protected void rptrBlog_RowCommand(object sender, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "edit")
            {
                Response.Redirect("add_blogs.aspx?ID=" + e.CommandArgument);
            }
            else if (e.CommandName == "status")
            {
                changeStatus(Convert.ToInt32(e.CommandArgument));
                fillRepeter(ddlCategory.SelectedItem.Text);
            }
            else if (e.CommandName == "delete")
            {
                deleteBlog(Convert.ToInt32(e.CommandArgument));
                fillRepeter(ddlCategory.SelectedItem.Text);
            }
        }
        
        private void changeStatus(int id)
        {
            MySqlConnection conn = new MySqlConnection(ConfigurationManager.ConnectionStrings["DBCONN_VS"].ConnectionString);
            MySqlCommand comm = new MySqlCommand();

            try
            {
                comm.CommandType = CommandType.StoredProcedure;
                comm.CommandText = "proc_blogpost_changeStatus";
                comm.Connection = conn;

                comm.Parameters.AddWithValue("pId", id);

                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                }

                if (comm.ExecuteNonQuery() > 0)
                {
                    Response.Redirect("manage_blogs.aspx?action=change");
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

        private void deleteBlog(int id)
        {
            MySqlConnection conn = new MySqlConnection(ConfigurationManager.ConnectionStrings["DBCONN_VS"].ConnectionString);
            MySqlCommand comm = new MySqlCommand();

            try
            {
                comm.CommandType = CommandType.StoredProcedure;
                comm.CommandText = "proc_Blog_delete";
                comm.Connection = conn;

                comm.Parameters.AddWithValue("pId", id);

                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                }

                if (comm.ExecuteNonQuery() > 0)
                {
                    Response.Redirect("manage_blogs.aspx?action=delete");
                }
                else
                {
                    pnlAlert.Attributes.Add("class", "alert alert-danger");
                    pnlAlert.Visible = true;
                    lblAlert.Text = "Blog delete ERROR !!! Please try after some time";
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

        protected void imgbtnadd_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("add_blogs.aspx");
        }

        protected void ddlCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            fillRepeter(ddlCategory.SelectedItem.Text);
        }
    }
}