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
    public partial class story_blogs : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                getBlogs(1);
            }
        }

        private int pageSize = 10;
        private void getBlogs(int PageIndex)
        {
            MySqlConnection conn = new MySqlConnection(ConfigurationManager.ConnectionStrings["DBCONN_VS"].ConnectionString);
            MySqlCommand comm = new MySqlCommand();
            MySqlDataAdapter DA = new MySqlDataAdapter();
            DataSet DS = new DataSet();

            try
            {
                comm.CommandType = CommandType.StoredProcedure;
                comm.CommandText = "proc_Blog_Stories_fetchAll";
                comm.Connection = conn;

                comm.Parameters.AddWithValue("pageIndex", PageIndex);
                comm.Parameters.AddWithValue("pageSize", pageSize);

                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                }

                DA = new MySqlDataAdapter(comm);
                DA.Fill(DS);

                if (DS.Tables[0].Rows.Count > 0)
                {
                    PopulatePager(Convert.ToInt32(DS.Tables[0].Rows[0]["rowCount"]), PageIndex);
                }

                if (DS.Tables[1].Rows.Count > 0)
                {
                    rptBlogs.DataSource = DS.Tables[1];
                    rptBlogs.DataBind();
                }
                else
                {
                    pnlBlogAlert.Attributes.Add("class", "ot-shortcode-alert-message alert-red");
                    pnlBlogAlert.Visible = true;
                    lblBlogAlert.Text = "No Data Found.";
                }

                if (DS.Tables[2].Rows.Count > 0)
                {
                    aVerticalAdv.HRef = DS.Tables[2].Rows[0]["webLink"].ToString();
                    aVerticalAdv.Title = DS.Tables[2].Rows[0]["companyName"].ToString();
                    imgVerticalAdv.Src = "cpanel/Advertise/" + DS.Tables[2].Rows[0]["verticalImg"].ToString();
                    imgVerticalAdv.Alt = DS.Tables[2].Rows[0]["companyName"].ToString();
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

        private void PopulatePager(int recordCount, int currentPage)
        {
            double dblPageCount = (double)((decimal)recordCount / Convert.ToDecimal(pageSize));
            int pageCount = (int)Math.Ceiling(dblPageCount);
            List<ListItem> pages = new List<ListItem>();
            if (pageCount > 0)
            {
                for (int i = 1; i <= pageCount; i++)
                {
                    pages.Add(new ListItem(i.ToString(), i.ToString(), i != currentPage));
                }
            }
            rptPager.DataSource = pages;
            rptPager.DataBind();
        }

        protected void Page_Changed(object sender, EventArgs e)
        {
            int pageIndex = int.Parse((sender as LinkButton).CommandArgument);
            //fetchAllRentProperties(pageIndex);
            getBlogs(pageIndex);
        }
    }
}