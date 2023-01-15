using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace villageStories.cpanel
{
    public partial class add_advertise : System.Web.UI.Page
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
                if (Request.QueryString["ID"] != null)
                {
                    fetchBlog(Request.QueryString["ID"].ToString());
                    btnBlogAdd.Visible = false;
                    btnBlogUpdate.Visible = true;
                }
                else
                {
                    lblAdvID.Text = "0";
                    btnBlogAdd.Visible = true;
                    btnBlogUpdate.Visible = false;
                }
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
                comm.CommandText = "proc_Advertise_fetchByID";
                comm.Connection = conn;

                comm.Parameters.AddWithValue("aId", id);

                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                }

                DA = new MySqlDataAdapter(comm);
                DA.Fill(DT);

                if (DT.Rows.Count > 0)
                {
                    lblAdvID.Text = DT.Rows[0]["advID"].ToString();
                    txtCompanyName.Text = DT.Rows[0]["companyName"].ToString();
                    txtWebURL.Text = DT.Rows[0]["webLink"].ToString();

                    lblImg1.ForeColor = DT.Rows[0]["horizontalImg"].ToString() == "empty" ? System.Drawing.Color.White : System.Drawing.Color.Black;
                    lblImg1.Text = DT.Rows[0]["horizontalImg"].ToString();
                    lblOldName1.Text = DT.Rows[0]["horizontalImg"].ToString();
                    Image1.ImageUrl = DT.Rows[0]["horizontalImg"].ToString() == "empty" ? "" : "../cpanel/Advertise/" + DT.Rows[0]["horizontalImg"].ToString();
                    
                    lblImg2.ForeColor = DT.Rows[0]["verticalImg"].ToString() == "empty" ? System.Drawing.Color.White : System.Drawing.Color.Black;
                    lblImg2.Text = DT.Rows[0]["verticalImg"].ToString();
                    lblOldName2.Text = DT.Rows[0]["verticalImg"].ToString();
                    Image2.ImageUrl = DT.Rows[0]["verticalImg"].ToString() == "empty" ? "" : "../cpanel/Advertise/" + DT.Rows[0]["verticalImg"].ToString();
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
            if (lblAdvID.Text == "0")
            {
                    addAdv();
            }
        }

        protected void btnBlogUpdate_Click(object sender, EventArgs e)
        {
            if (lblAdvID.Text != "0")
            {
                    updateCategory();
            }
        }

        private void addAdv()
        {
            MySqlConnection conn = new MySqlConnection(ConfigurationManager.ConnectionStrings["DBCONN_VS"].ConnectionString);
            MySqlCommand comm = new MySqlCommand();
            
            try
            {
                comm.CommandType = CommandType.StoredProcedure;
                comm.CommandText = "proc_Advertise_add";
                comm.Connection = conn;

                comm.Parameters.AddWithValue("cName", txtCompanyName.Text);
                comm.Parameters.AddWithValue("url", txtWebURL.Text);
                comm.Parameters.AddWithValue("date", DateTime.Now);

                string imgfile1 = txtCompanyName.Text + "_" + DateTime.Now.ToString("ssff") + "_H.jpg";//Path.GetFileName(FileUpload2.PostedFile.FileName);
                string imgfile2 = txtCompanyName.Text + "_" + DateTime.Now.ToString("ssff") + "_V.jpg";//Path.GetFileName(FileUpload2.PostedFile.FileName);

                comm.Parameters.AddWithValue("imgH", Path.GetFileName(FileUpload1.PostedFile.FileName) == "" ? "empty" : imgfile1);
                comm.Parameters.AddWithValue("imgV", Path.GetFileName(FileUpload2.PostedFile.FileName) == "" ? "empty" : imgfile2);

                if (Path.GetFileName(FileUpload1.PostedFile.FileName) != "")
                {
                    //FileUpload1.SaveAs(Server.MapPath("../cpanel/Advertise/") + imgfile1);
                    string targetFile = Server.MapPath("../cpanel/Advertise/") + imgfile1;
                    Stream strm = FileUpload1.PostedFile.InputStream;
                    ReduceImageSize(strm, targetFile, 90, 728);
                }
                if (Path.GetFileName(FileUpload2.PostedFile.FileName) != "")
                {
                    //FileUpload2.SaveAs(Server.MapPath("../cpanel/Advertise/") + imgfile2);
                    string targetFile = Server.MapPath("../cpanel/Advertise/") + imgfile1;
                    Stream strm = FileUpload2.PostedFile.InputStream;
                    ReduceImageSize(strm, targetFile, 400, 300);
                }

                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                }

                if (comm.ExecuteNonQuery() > 0)
                {
                    clearForm();
                    Response.Redirect("manage_advertise.aspx?action=add");
                }
                else
                {
                    pnlAlert.Attributes.Add("class", "alert alert-danger");
                    pnlAlert.Visible = true;
                    lblAlert.Text = "Advertise add ERROR !!! Please try after some time";
                }

            }
            catch (Exception ex)
            {
                string x = ex.ToString();
                pnlAlert.Attributes.Add("class", "alert alert-danger");
                pnlAlert.Visible = true;
                lblAlert.Text = ex.ToString();//"ERROR !!! Please try after some time";
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


        private void updateCategory()
        {
            MySqlConnection conn = new MySqlConnection(ConfigurationManager.ConnectionStrings["DBCONN_VS"].ConnectionString);
            MySqlCommand comm = new MySqlCommand();
            
            try
            {
                comm.CommandType = CommandType.StoredProcedure;

                comm.CommandText = "proc_Advertise_update";
                comm.Connection = conn;

                comm.Parameters.AddWithValue("aID", lblAdvID.Text);
                comm.Parameters.AddWithValue("cName", txtCompanyName.Text);
                comm.Parameters.AddWithValue("url", txtWebURL.Text);
                comm.Parameters.AddWithValue("date", DateTime.Now);

                string imgfile1 = txtCompanyName.Text + "_" + DateTime.Now.ToString("ssff") + "_H.jpg"; ;
                string imgfile2 = txtCompanyName.Text + "_" + DateTime.Now.ToString("ssff") + "_V.jpg"; ;

                if (Path.GetFileName(FileUpload1.PostedFile.FileName) != "")
                {
                    //delete recent photo
                    string path = Server.MapPath("../cpanel/Advertise/" + lblOldName1.Text);
                    FileInfo file = new FileInfo(path);
                    if (file.Exists)
                    {
                        file.Delete();
                    }
                    //----------------

                    //FileUpload1.SaveAs(Server.MapPath("../cpanel/Advertise/") + imgfile1);
                    string targetFile = Server.MapPath("../cpanel/Advertise/") + imgfile1;
                    Stream strm = FileUpload1.PostedFile.InputStream;
                    ReduceImageSize(strm, targetFile, 90, 728);

                    comm.Parameters.AddWithValue("imgH", imgfile1);
                }
                else
                {
                    //remove photo
                    if (lblImg1.Text == "empty")
                    {
                        string path = Server.MapPath("../cpanel/Advertise/" + lblOldName1.Text);
                        FileInfo file = new FileInfo(path);
                        if (file.Exists)
                        {
                            file.Delete();
                        }
                    }
                    //----------------

                    comm.Parameters.AddWithValue("imgH", lblImg1.Text);
                }

                if (Path.GetFileName(FileUpload2.PostedFile.FileName) != "")
                {
                    //delete recent photo
                    string path = Server.MapPath("../cpanel/Advertise/" + lblOldName2.Text);
                    FileInfo file = new FileInfo(path);
                    if (file.Exists)
                    {
                        file.Delete();
                    }
                    //----------------

                    //FileUpload2.SaveAs(Server.MapPath("../cpanel/Advertise/") + imgfile2);
                    string targetFile = Server.MapPath("../cpanel/Advertise/") + imgfile1;
                    Stream strm = FileUpload2.PostedFile.InputStream;
                    ReduceImageSize(strm, targetFile, 400, 300);

                    comm.Parameters.AddWithValue("imgV", imgfile2);
                }
                else
                {
                    //remove photo
                    if (lblImg2.Text == "empty")
                    {
                        string path = Server.MapPath("../cpanel/Advertise/" + lblOldName2.Text);
                        FileInfo file = new FileInfo(path);
                        if (file.Exists)
                        {
                            file.Delete();
                        }
                    }
                    //----------------

                    comm.Parameters.AddWithValue("imgV", lblImg2.Text);
                }

                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                }


                if (comm.ExecuteNonQuery() > 0)
                {
                    clearForm();
                    Response.Redirect("manage_advertise.aspx?action=update", false);
                }
                else
                {
                    pnlAlert.Attributes.Add("class", "alert alert-danger");
                    pnlAlert.Visible = true;
                    lblAlert.Text = "Advertise update ERROR !!! Please try after some time";
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

        private void clearForm()
        {
            txtCompanyName.Text = "";
            txtWebURL.Text = "";
        }

        protected void btnBlogCancel_Click(object sender, EventArgs e)
        {
            clearForm();
            Response.Redirect("manage_advertise.aspx");
        }
        
        protected void btnDelete1_Click(object sender, System.EventArgs e)
        {
            lblImg1.Text = "empty";
            lblImg1.ForeColor = System.Drawing.Color.White;
            Image1.ImageUrl = "";
        }

        protected void btnDelete2_Click(object sender, System.EventArgs e)
        {
            lblImg2.Text = "empty";
            lblImg2.ForeColor = System.Drawing.Color.White;
            Image2.ImageUrl = "";
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