using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace villageStories
{
    public partial class blog_details : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (Request.QueryString["ID"] != null)
                {
                    blogDetails();
                }
                else
                {
                    UpdatePanel1.Visible = false;
                }

                if (Request.QueryString["action"] != null)
                {
                    if (Request.QueryString["action"].ToString() == "save")
                    {
                        pnlCommentAlert.Attributes.Add("class", "alert-message ot-shortcode-alert-message alert-green");
                        pnlCommentAlert.Visible = true;
                        lblCommentAlert.Text = "Comment posted successfully. Thank you !!!";
                        
                        ClientScript.RegisterStartupScript(this.GetType(), "Scroll", "scrollToComment();", true);
                    }
                }
            }
        }


        private void blogDetails()
        {
            MySqlConnection conn = new MySqlConnection(ConfigurationManager.ConnectionStrings["DBCONN_VS"].ConnectionString);
            MySqlCommand comm = new MySqlCommand();
            MySqlDataAdapter DA = new MySqlDataAdapter();
            DataSet DS = new DataSet();

            try
            {
                comm.CommandType = CommandType.StoredProcedure;
                comm.CommandText = "proc_BlogPost_getDetails_comments";
                comm.Connection = conn;

                comm.Parameters.AddWithValue("pID", Request.QueryString["ID"].ToString());
                comm.Parameters.AddWithValue("ipRepeat", Request.Cookies["ipRepeat"] == null ? "1" : Request.Cookies["ipRepeat"].Value.ToString());

                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                }

                DA = new MySqlDataAdapter(comm);
                DA.Fill(DS);

                if (DS.Tables[0].Rows.Count > 0)
                {
                    lblCategory.Text = DS.Tables[0].Rows[0]["category"].ToString();
                    lblCommentsCount.Text = DS.Tables[0].Rows[0]["comments"].ToString();
                    lblCommentCount.Text = DS.Tables[0].Rows[0]["comments"].ToString();
                    lblBlogDate.Text = Convert.ToDateTime(DS.Tables[0].Rows[0]["date"]).ToString("dd MMMM yyyy");
                    lblBlogTitle.Text = DS.Tables[0].Rows[0]["postTitle"].ToString();
                    this.Page.Title = DS.Tables[0].Rows[0]["postTitle"].ToString();
                    aCategory.HRef = "blogs.aspx?category=" + DS.Tables[0].Rows[0]["category"].ToString();
                    imgHeadingPhoto.Src = "cpanel/blogHeadingImg/" + DS.Tables[0].Rows[0]["headingPhoto"].ToString();
                    lblDescription.Text = Server.HtmlDecode(DS.Tables[0].Rows[0]["detailPost"].ToString());
                    lblAuthor.Text = DS.Tables[0].Rows[0]["author"].ToString();

                    ogTitle.Attributes.Add("content", DS.Tables[0].Rows[0]["postTitle"].ToString());
                    ogDesc.Attributes.Add("content", DS.Tables[0].Rows[0]["shortDescription"].ToString());
                    ogImg.Attributes.Add("content", "https://thevillagestories.com/cpanel/blogHeadingImg/" + DS.Tables[0].Rows[0]["headingPhoto"].ToString());
                    ogURL.Attributes.Add("content", "https://thevillagestories.com/blog_details.aspx?ID=" + Request.QueryString["ID"].ToString());

                    twtTitle.Attributes.Add("content", DS.Tables[0].Rows[0]["postTitle"].ToString());
                    twtDesc.Attributes.Add("content", DS.Tables[0].Rows[0]["shortDescription"].ToString());
                    twtImg.Attributes.Add("content", "https://thevillagestories.com/cpanel/blogHeadingImg/" + DS.Tables[0].Rows[0]["headingPhoto"].ToString());
                    twtURL.Attributes.Add("content", "https://thevillagestories.com/blog_details.aspx?ID=" + Request.QueryString["ID"].ToString());
                }

                if (DS.Tables[1].Rows.Count > 0)
                {
                    rptComments.DataSource = DS.Tables[1];
                    rptComments.DataBind();
                }
                else
                {
                    rptComments.DataSource = null;
                    rptComments.DataBind();
                }

                if (DS.Tables[2].Rows.Count > 0)
                {
                    rptRelatedPost.DataSource = DS.Tables[2];
                    rptRelatedPost.DataBind();
                }
                else
                {
                    rptRelatedPost.DataSource = null;
                    rptRelatedPost.DataBind();
                }

                if (DS.Tables[3].Rows.Count > 0)
                {
                    aVerticalAdv.HRef = DS.Tables[3].Rows[0]["webLink"].ToString();
                    aVerticalAdv.Title = DS.Tables[3].Rows[0]["companyName"].ToString();
                    imgVerticalAdv.Src = "cpanel/Advertise/" + DS.Tables[3].Rows[0]["verticalImg"].ToString();
                    imgVerticalAdv.Alt = DS.Tables[3].Rows[0]["companyName"].ToString();
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

        private void addComment()
        {
            MySqlConnection conn = new MySqlConnection(ConfigurationManager.ConnectionStrings["DBCONN_VS"].ConnectionString);
            MySqlCommand comm = new MySqlCommand();
            
            try
            {
                comm.CommandType = CommandType.StoredProcedure;
                comm.CommandText = "proc_BlogComment_add";
                comm.Connection = conn;

                comm.Parameters.AddWithValue("pID", Request.QueryString["ID"].ToString());
                comm.Parameters.AddWithValue("vName", txtName.Value);
                comm.Parameters.AddWithValue("mobile", txtMobile.Value);
                comm.Parameters.AddWithValue("comm", txtComment.Value);
                comm.Parameters.AddWithValue("commDate", DateTime.Now);

                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                }

                if (comm.ExecuteNonQuery() > 0)
                {
                    clearForm();
                    Response.Redirect("blog_details.aspx?ID=" + Request.QueryString["ID"].ToString() + "&action=save");
                }
                else
                {
                    pnlCommentAlert.Attributes.Add("class", "alert-message ot-shortcode-alert-message alert-red");
                    pnlCommentAlert.Visible = true;
                    lblCommentAlert.Text = "Comment post Error !!! Please try after some time";
                    lblCommentAlert.Focus();
                }

            }
            catch (Exception ex)
            {
                string x = ex.ToString();
                pnlCommentAlert.Attributes.Add("class", "alert-message ot-shortcode-alert-message alert-red");
                pnlCommentAlert.Visible = true;
                lblCommentAlert.Text = "ERROR !!! Please try after some time";
                lblCommentAlert.Focus();
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

        private void clearForm()
        {
            txtName.Value = "";
            txtMobile.Value = "";
            txtComment.Value = "";
        }

        protected void btnComment_Click(object sender, EventArgs e)
        {
            if (Request.QueryString["ID"] != null)
            {
                addComment();
            }
        }
    }
}