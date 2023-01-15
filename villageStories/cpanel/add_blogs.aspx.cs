using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.IO;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace villageStories.cpanel
{
    public partial class add_blogs : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            txtPublishDate.Text = DateTime.Now.ToString("yyyy-MM-dd");

            if (Request.Cookies["userID"] == null)
            {
                Response.Redirect("Logout.aspx", false);
                return;
            }

            if (Session["caregory"] != null)
            {
                ddlCategory.Items.FindByText(Session["caregory"].ToString()).Selected = true;
                txtBlogTitle.Text = Session["blogTitle"].ToString();
                //txtSortPara.Text = Session["SortPara"].ToString();
            }

            if (!Page.IsPostBack)
            {
                if (Request.QueryString["ID"] != null)
                {
                    fetchBlog(Request.QueryString["ID"].ToString());
                    fillImagesRepeter();
                    btnBlogAdd.Visible = false;
                    btnBlogUpdate.Visible = true;
                }
                else
                {
                    lblBlogID.Text = "0";
                    fetchKeyValue();
                    fillImagesRepeter();
                    btnBlogAdd.Visible = true;
                    btnBlogUpdate.Visible = false;
                }
            }
        }
        
        private void fetchKeyValue()
        {
            MySqlConnection conn = new MySqlConnection(ConfigurationManager.ConnectionStrings["DBCONN_VS"].ConnectionString);
            MySqlCommand comm = new MySqlCommand();
            MySqlDataAdapter DA = new MySqlDataAdapter();
            DataTable DT = new DataTable();

            try
            {
                comm.CommandType = CommandType.StoredProcedure;
                comm.CommandText = "proc_Blog_getKyeValue";
                comm.Connection = conn;
                
                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                }

                DA = new MySqlDataAdapter(comm);
                DA.Fill(DT);

                if (DT.Rows.Count > 0)
                {
                    lblKeyVal.Text = DT.Rows[0]["kyeValue"].ToString();
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

        private void fetchBlog(string id)
        {
            MySqlConnection conn = new MySqlConnection(ConfigurationManager.ConnectionStrings["DBCONN_VS"].ConnectionString);
            MySqlCommand comm = new MySqlCommand();
            MySqlDataAdapter DA = new MySqlDataAdapter();
            DataTable DT = new DataTable();

            try
            {
                comm.CommandType = CommandType.StoredProcedure;
                comm.CommandText = "proc_Blog_fetchByID";
                comm.Connection = conn;

                comm.Parameters.AddWithValue("pId", id);

                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                }

                DA = new MySqlDataAdapter(comm);
                DA.Fill(DT);

                if (DT.Rows.Count > 0)
                {
                    lblBlogID.Text = DT.Rows[0]["postID"].ToString();
                    lblKeyVal.Text = DT.Rows[0]["keyValue"].ToString();
                    txtBlogTitle.Text = DT.Rows[0]["postTitle"].ToString();
                    txtAuthor.Text = DT.Rows[0]["author"].ToString();
                    txtSortPara.Text = DT.Rows[0]["shortDescription"].ToString();
                    txtPublishDate.Text = Convert.ToDateTime(DT.Rows[0]["date"]).ToString("yyyy-MM-dd") == "0001-01-01" ? "" : Convert.ToDateTime(DT.Rows[0]["date"]).ToString("yyyy-MM-dd");
                    ddlCategory.ClearSelection();
                    ddlCategory.Items.FindByText(DT.Rows[0]["category"].ToString()).Selected = true;
                    txtCKEditor1.Text = Server.HtmlDecode(DT.Rows[0]["detailPost"].ToString());

                    lblImg1.ForeColor = DT.Rows[0]["headingPhoto"].ToString() == "empty" ? System.Drawing.Color.White : System.Drawing.Color.Black;
                    lblImg1.Text = DT.Rows[0]["headingPhoto"].ToString();
                    lblOldName1.Text = DT.Rows[0]["headingPhoto"].ToString();
                    Image1.ImageUrl = DT.Rows[0]["headingPhoto"].ToString() == "empty" ? "" : "../cpanel/blogHeadingImg/" + DT.Rows[0]["headingPhoto"].ToString();
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
               
        protected void btnBlogAdd_Click(object sender, EventArgs e)
        {
            if (lblBlogID.Text == "0")
            {
                if (addValidation())
                {
                    addCategory();
                }

                else
                {
                    pnlAlert.Attributes.Add("class", "alert alert-warning");
                    pnlAlert.Visible = true;
                    lblAlert.Text = "Blog already exist";
                }
            }
        }

        protected void btnBlogUpdate_Click(object sender, EventArgs e)
        {
            if (lblBlogID.Text != "0")
            {
                if (updateVAlidation())
                {
                    updateCategory();
                }
                else
                {
                    pnlAlert.Attributes.Add("class", "alert alert-warning");
                    pnlAlert.Visible = true;
                    lblAlert.Text = "Blog already exist";
                }
            }
        }

        private void addCategory()
        {
            MySqlConnection conn = new MySqlConnection(ConfigurationManager.ConnectionStrings["DBCONN_VS"].ConnectionString);
            MySqlCommand comm = new MySqlCommand();

            string cTitle = txtBlogTitle.Text.ToLower();

            try
            {
                comm.CommandType = CommandType.StoredProcedure;
                comm.CommandText = "proc_Blog_add";
                comm.Connection = conn;

                comm.Parameters.AddWithValue("category", ddlCategory.SelectedItem.Text);
                comm.Parameters.AddWithValue("kyeVal", lblKeyVal.Text);
                comm.Parameters.AddWithValue("title", txtBlogTitle.Text);
                comm.Parameters.AddWithValue("sPara", txtSortPara.Text);
                comm.Parameters.AddWithValue("pDate", txtPublishDate.Text == "" ? "0000-00-00" : txtPublishDate.Text + " " + DateTime.Now.ToString("HH:mm:ss"));
                comm.Parameters.AddWithValue("author", txtAuthor.Text);
                comm.Parameters.AddWithValue("blogPost", Server.HtmlEncode(txtCKEditor1.Text));

                string imgfile1 = DateTime.Now.ToString("yyyy-MM-dd-hh.mm.ss.ff") + ".jpg";//Path.GetFileName(FileUpload2.PostedFile.FileName);

                comm.Parameters.AddWithValue("img", Path.GetFileName(FileUpload2.PostedFile.FileName) == "" ? "empty" : imgfile1);
                
                if (Path.GetFileName(FileUpload2.PostedFile.FileName) != "")
                {
                    //FileUpload2.SaveAs(Server.MapPath("../cpanel/blogHeadingImg/") + imgfile1);
                    string targetFile = Server.MapPath("../cpanel/blogHeadingImg/") + imgfile1;
                    Stream strm = FileUpload2.PostedFile.InputStream;
                    ReduceImageSize(strm, targetFile, 360, 780);
                }

                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                }

                if (comm.ExecuteNonQuery() > 0)
                {
                    clearForm();
                    Response.Redirect("manage_blogs.aspx?action=add");
                }
                else
                {
                    pnlAlert.Attributes.Add("class", "alert alert-danger");
                    pnlAlert.Visible = true;
                    lblAlert.Text = "Blog add ERROR !!! Please try after some time";
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

        private bool addValidation()
        {
            bool ret = false;
            MySqlConnection conn = new MySqlConnection(ConfigurationManager.ConnectionStrings["DBCONN_VS"].ConnectionString);
            MySqlCommand comm = new MySqlCommand();
            MySqlDataAdapter DA = new MySqlDataAdapter();
            DataTable DT = new DataTable();

            try
            {
                comm.CommandType = CommandType.StoredProcedure;
                comm.CommandText = "proc_Blog_addValidation";
                comm.Connection = conn;

                comm.Parameters.AddWithValue("pTitle", txtBlogTitle.Text);

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

        private void updateCategory()
        {
            MySqlConnection conn = new MySqlConnection(ConfigurationManager.ConnectionStrings["DBCONN_VS"].ConnectionString);
            MySqlCommand comm = new MySqlCommand();

            string cTitle = txtBlogTitle.Text.ToLower();

            try
            {
                comm.CommandType = CommandType.StoredProcedure;

                comm.CommandText = "proc_Blog_update";
                comm.Connection = conn;

                comm.Parameters.AddWithValue("pID", lblBlogID.Text);
                comm.Parameters.AddWithValue("category", ddlCategory.SelectedItem.Text);
                comm.Parameters.AddWithValue("kyeVal", lblKeyVal.Text);
                comm.Parameters.AddWithValue("title", txtBlogTitle.Text);
                comm.Parameters.AddWithValue("sPara", txtSortPara.Text);
                comm.Parameters.AddWithValue("pDate", txtPublishDate.Text == "" ? "0000-00-00" : txtPublishDate.Text + " " + DateTime.Now.ToString("HH:mm:ss"));
                comm.Parameters.AddWithValue("author", txtAuthor.Text);
                comm.Parameters.AddWithValue("blogPost", Server.HtmlEncode(txtCKEditor1.Text));
                
                string imgfile1 = DateTime.Now.ToString("yyyy-MM-dd-hh.mm.ss.ff") + ".jpg";//Path.GetFileName(FileUpload2.PostedFile.FileName);
                if (Path.GetFileName(FileUpload2.PostedFile.FileName) != "")
                {
                    //delete recent photo
                    string path = Server.MapPath("../cpanel/blogHeadingImg/" + lblOldName1.Text);
                    FileInfo file = new FileInfo(path);
                    if (file.Exists)
                    {
                        file.Delete();
                    }
                    //----------------

                    //FileUpload2.SaveAs(Server.MapPath("../cpanel/blogHeadingImg/") + imgfile1);
                    string targetFile = Server.MapPath("../cpanel/blogHeadingImg/") + imgfile1;
                    Stream strm = FileUpload2.PostedFile.InputStream;
                    ReduceImageSize(strm, targetFile,360,780);

                    comm.Parameters.AddWithValue("img", imgfile1);
                }
                else
                {
                    //remove photo
                    if (lblImg1.Text == "empty")
                    {
                        string path = Server.MapPath("../cpanel/blogHeadingImg/" + lblOldName1.Text);
                        FileInfo file = new FileInfo(path);
                        if (file.Exists)
                        {
                            file.Delete();
                        }
                    }
                    //----------------

                    comm.Parameters.AddWithValue("img", lblImg1.Text);
                }

                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                }
                

                if (comm.ExecuteNonQuery() > 0)
                {
                    clearForm();
                    Response.Redirect("manage_blogs.aspx?action=update", false);
                }
                else
                {
                    pnlAlert.Attributes.Add("class", "alert alert-danger");
                    pnlAlert.Visible = true;
                    lblAlert.Text = "Blog update ERROR !!! Please try after some time";
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
                comm.CommandText = "proc_Blog_updateValidation";
                comm.Connection = conn;

                comm.Parameters.AddWithValue("pID", lblBlogID.Text);
                comm.Parameters.AddWithValue("pTitle", txtBlogTitle.Text);

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
            txtBlogTitle.Text = "";
            //txtSortPara.Text = "";
            txtPublishDate.Text = "";
            ddlCategory.ClearSelection();
            txtAuthor.Text = "";
            Session.Abandon();
        }

        protected void btnBlogCancel_Click(object sender, EventArgs e)
        {
            clearForm();
            Response.Redirect("manage_blogs.aspx");
        }

        protected void Upload(object sender, EventArgs e)
        {
            Session["caregory"] = ddlCategory.SelectedItem.Text;
            Session["blogTitle"] = txtBlogTitle.Text;
            //Session["SortPara"] = txtSortPara.Text;

            string imageName = DateTime.Now.ToString("yyMMddHHmmssff");
            addImage(imageName + Path.GetExtension(FileUpload1.FileName));                        
        }


        private void fillImagesRepeter()
        {
            MySqlConnection conn = new MySqlConnection(ConfigurationManager.ConnectionStrings["DBCONN_VS"].ConnectionString);
            MySqlCommand comm = new MySqlCommand();
            MySqlDataAdapter DA = new MySqlDataAdapter();
            DataTable DT = new DataTable();

            try
            {
                comm.CommandType = CommandType.StoredProcedure;
                comm.CommandText = "proc_BlogImages_getList";
                comm.Connection = conn;

                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                }

                comm.Parameters.AddWithValue("keyVal", lblKeyVal.Text);

                DA = new MySqlDataAdapter(comm);
                DA.Fill(DT);

                if (DT.Rows.Count > 0)
                {
                    rptImages.DataSource = DT;
                    rptImages.DataBind();
                }
                else
                {
                    rptImages.DataSource = null;
                    rptImages.DataBind();
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

        private void addImage(string imgName)
        {
            MySqlConnection conn = new MySqlConnection(ConfigurationManager.ConnectionStrings["DBCONN_VS"].ConnectionString);
            MySqlCommand comm = new MySqlCommand();

            try
            {
                comm.CommandType = CommandType.StoredProcedure;
                comm.CommandText = "proc_BlogImages_Add";
                comm.Connection = conn;

                comm.Parameters.AddWithValue("title", txtImageTitle.Text);
                comm.Parameters.AddWithValue("url", imgName);
                comm.Parameters.AddWithValue("keyVal", lblKeyVal.Text);

                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                }

                if (comm.ExecuteNonQuery() > 0)
                {
                    FileUpload1.SaveAs(Server.MapPath("../cpanel/blogImg/") + imgName);

                    txtImageTitle.Text = string.Empty;
                    FileUpload1.PostedFile.InputStream.Dispose();
                    //fillImagesRepeter();
                    if (Request.QueryString["ID"] == null)
                    {
                        Response.Redirect("add_blogs.aspx");
                    }
                    else
                    {
                        Response.Redirect("add_blogs.aspx?ID=" + Request.QueryString["ID"].ToString());
                    }
                }
                else
                {
                    pnlAlert.Attributes.Add("class", "alert alert-danger");
                    pnlAlert.Visible = true;
                    lblAlert.Text = "Image add ERROR !!! Please try after some time";
                }

            }
            catch (Exception ex)
            {
                string x = ex.ToString();
                pnlAlert.Attributes.Add("class", "alert alert-danger");
                pnlAlert.Visible = true;
                lblAlert.Text = "ERROR !!! Please try after some time";
                //lblAlert.Text = x;
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

        protected void rptImages_RowCommand(object sender, System.Web.UI.WebControls.DataListCommandEventArgs e)
        {
            if (e.CommandName == "delete")
            {

                Session["serviceID"] = ddlCategory.SelectedItem.Value;
                Session["blogTitle"] = txtBlogTitle.Text;
                //Session["SortPara"] = txtSortPara.Text;

                string[] arrg = e.CommandArgument.ToString().Split(';');
                deleteImage(arrg[0], arrg[1]);
            }
        }

        private void deleteImage(string id, string imgName)
        {
            MySqlConnection conn = new MySqlConnection(ConfigurationManager.ConnectionStrings["DBCONN_VS"].ConnectionString);
            MySqlCommand comm = new MySqlCommand();

            try
            {
                comm.CommandType = CommandType.StoredProcedure;
                comm.CommandText = "proc_BlogImages_deleteImage";
                comm.Connection = conn;

                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                }

                comm.Parameters.AddWithValue("ID", id);

                if (comm.ExecuteNonQuery() > 0)
                {
                    //delete recent photo
                    string path = Server.MapPath("../cpanel/blogImg/" + imgName);
                    FileInfo file = new FileInfo(path);
                    if (file.Exists)
                    {
                        file.Delete();
                    }

                    if (Request.QueryString["ID"] == null)
                    {
                        Response.Redirect("add_blogs.aspx");
                    }
                    else
                    {
                        Response.Redirect("add_blogs.aspx?ID=" + Request.QueryString["ID"].ToString());
                    }
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
        
        protected void btnDelete1_Click(object sender, System.EventArgs e)
        {
            lblImg1.Text = "empty";
            lblImg1.ForeColor = System.Drawing.Color.White;
            Image1.ImageUrl = "";
        }

        private void ReduceImageSize(Stream sourcePath, string targetPath, int height, int width)
        {
            using (var image = System.Drawing.Image.FromStream(sourcePath))
            {
                var thumbnailImg = new Bitmap(width, height);
                var thumbGraph = Graphics.FromImage(thumbnailImg);
                thumbGraph.CompositingQuality = CompositingQuality.HighQuality;
                thumbGraph.SmoothingMode = SmoothingMode.HighQuality;
                thumbGraph.InterpolationMode = InterpolationMode.HighQualityBicubic;
                var imageRectangle = new Rectangle(0, 0, width, height);
                thumbGraph.DrawImage(image, imageRectangle);
                thumbnailImg.Save(targetPath, image.RawFormat);
            }
        }
    }
}