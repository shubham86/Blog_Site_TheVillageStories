using MySql.Data.MySqlClient;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace villageStories
{
    public partial class index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                mainSliderBlogs();
                visitorentry();
            }
        }

        private void mainSliderBlogs()
        {
            MySqlConnection conn = new MySqlConnection(ConfigurationManager.ConnectionStrings["DBCONN_VS"].ConnectionString);
            MySqlCommand comm = new MySqlCommand();
            MySqlDataAdapter DA = new MySqlDataAdapter();
            DataSet DS = new DataSet();

            try
            {
                comm.CommandType = CommandType.StoredProcedure;
                comm.CommandText = "proc_index_Blog_LatestFromAllCategories";
                comm.Connection = conn;
                
                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                }

                DA = new MySqlDataAdapter(comm);
                DA.Fill(DS);

                if (DS.Tables[0].Rows.Count > 0)
                {
                    rptMainSlider.DataSource = DS.Tables[0];
                    rptMainSlider.DataBind();
                }
                else
                {
                    rptMainSlider.DataSource = null;
                    rptMainSlider.DataBind();

                    pnlMainSliderAlert.Attributes.Add("class", "ot-shortcode-alert-message alert-red");
                    pnlMainSliderAlert.Visible = true;
                    lblMainSliderError.Text = "No Data Found.";
                }

                if (DS.Tables[1].Rows.Count > 0)
                {
                    rptRecentPost.DataSource = DS.Tables[1];
                    rptRecentPost.DataBind();
                }
                else
                {
                    rptRecentPost.DataSource = null;
                    rptRecentPost.DataBind();

                    pnlRecentPostAlert.Attributes.Add("class", "ot-shortcode-alert-message alert-red");
                    pnlRecentPostAlert.Visible = true;
                    lblRecentPostError.Text = "No Data Found.";
                }

                if (DS.Tables[2].Rows.Count > 0)
                {
                    lblSeconCategory.Text = DS.Tables[2].Rows[0]["category"].ToString();
                    lblSecondComment.Text = DS.Tables[2].Rows[0]["comments"].ToString();
                    lblSecondDate.Text = Convert.ToDateTime(DS.Tables[2].Rows[0]["date"]).ToString("dd MMMM yyyy");
                    lblSecondTitle.Text = (DS.Tables[2].Rows[0]["postTitle"].ToString().Length) >= 70 ? DS.Tables[2].Rows[0]["postTitle"].ToString().Substring(0, 70) + "..." : DS.Tables[2].Rows[0]["postTitle"].ToString().ToString() + "...";
                    aSecondimgURL.HRef = "blog_details.aspx?ID=" + DS.Tables[2].Rows[0]["postID"].ToString();
                    aSecondLink.HRef = "blog_details.aspx?ID=" + DS.Tables[2].Rows[0]["postID"].ToString();
                    imgSecond.Src = "cpanel/blogHeadingImg/" + DS.Tables[2].Rows[0]["headingPhoto"].ToString();
                    lblSecondDetail.Text = (Convert.ToInt32(DS.Tables[2].Rows[0]["shortDescription"].ToString().Length) >= 170 && Convert.ToInt32(DS.Tables[2].Rows[0]["shortDescription"].ToString().Length) > 0) ? DS.Tables[2].Rows[0]["shortDescription"].ToString().Substring(0, 170) + "..." : DS.Tables[2].Rows[0]["shortDescription"].ToString().ToString() + "...";


                    DS.Tables[2].Rows.RemoveAt(0);

                    rptSecond.DataSource = DS.Tables[2];
                    rptSecond.DataBind();
                }
                else
                {
                    rptSecond.DataSource = null;
                    rptSecond.DataBind();
                    divSecondLarge.Visible = false;
                    btnSecondMore.Visible = false;

                    pnlSecondAlert.Attributes.Add("class", "ot-shortcode-alert-message alert-red");
                    pnlSecondAlert.Visible = true;
                    lblSecondAlert.Text = "No Data Found.";
                }

                if (DS.Tables[3].Rows.Count > 0)
                {
                    rptThird.DataSource = DS.Tables[3];
                    rptThird.DataBind();
                }
                else
                {
                    rptThird.DataSource = null;
                    rptThird.DataBind();
                    btnThirdMore.Visible = false;

                    pnlThirdAlert.Attributes.Add("class", "ot-shortcode-alert-message alert-red");
                    pnlThirdAlert.Visible = true;
                    lblThirdAlert.Text = "No Data Found.";
                }

                if (DS.Tables[4].Rows.Count > 0)
                {
                    rptFourth.DataSource = DS.Tables[4];
                    rptFourth.DataBind();
                }
                else
                {
                    rptFourth.DataSource = null;
                    rptFourth.DataBind();
                    btnFourthMore.Visible = false;

                    pnlFourthAlert.Attributes.Add("class", "ot-shortcode-alert-message alert-red");
                    pnlFourthAlert.Visible = true;
                    lblFourthAlert.Text = "No Data Found.";
                }

                if (DS.Tables[5].Rows.Count > 0)
                {
                    aVerticalAdv.HRef = DS.Tables[5].Rows[0]["webLink"].ToString();
                    aVerticalAdv.Title = DS.Tables[5].Rows[0]["companyName"].ToString();
                    imgVerticalAdv.Src = "cpanel/Advertise/" + DS.Tables[5].Rows[0]["verticalImg"].ToString();
                    imgVerticalAdv.Alt = DS.Tables[5].Rows[0]["companyName"].ToString();
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
                    imgVerticalAdv  .Alt = DT.Rows[0]["companyName"].ToString(); 
                }
                else
                {
                    aVerticalAdv.Visible = false;
                    imgVerticalAdv.Visible = false;
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

        private void visitorentry()
        {
            MySqlConnection conn = new MySqlConnection(ConfigurationManager.ConnectionStrings["DBCONN_VS"].ConnectionString);
            MySqlCommand comm = new MySqlCommand();
            MySqlDataAdapter DA = new MySqlDataAdapter();
            DataTable DT = new DataTable();

            string IP = Request.Cookies["ip"] != null ? Request.Cookies["ip"].Value : ""; 

            try
            {
                comm.CommandType = CommandType.StoredProcedure;
                comm.CommandText = "proc_Visitor_verify";
                comm.Connection = conn;

                comm.Parameters.AddWithValue("ip", IP);

                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                }

                DA = new MySqlDataAdapter(comm);
                DA.Fill(DT);

                if (DT.Rows.Count <= 0)
                {
                    addVisitor(IP);

                    if (Request.Cookies["isRepeat"] == null)
                    {
                        HttpCookie Cookie = new HttpCookie("ipRepeat");
                        Cookie.Value = "0";
                        Cookie.Expires = DateTime.Now.AddDays(1);
                        Response.Cookies.Add(Cookie);
                    }                    
                }
                else {
                    if (Request.Cookies["isRepeat"] == null)
                    {
                        HttpCookie Cookie = new HttpCookie("ipRepeat");
                        Cookie.Value = "1";
                        Cookie.Expires = DateTime.Now.AddDays(1);
                        Response.Cookies.Add(Cookie);
                    }
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

        private void GetVisitorIP()
        {
            string varIPAddress = string.Empty;

            //if (HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"] != null)
            //{
            //    varIPAddress = HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];
            //}

            if (HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"] != null)
            {
                varIPAddress = HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];
            }
            
            HttpCookie Cookie = new HttpCookie("ip");
            Cookie.Value = varIPAddress;
            Cookie.Expires = DateTime.Now.AddMinutes(360);
            Response.Cookies.Add(Cookie);
        }

        public class IpInfo
        {
            [JsonProperty("ip")]
            public string Ip { get; set; }

            [JsonProperty("hostname")]
            public string Hostname { get; set; }

            [JsonProperty("city")]
            public string City { get; set; }

            [JsonProperty("region")]
            public string Region { get; set; }

            [JsonProperty("country")]
            public string Country { get; set; }

            [JsonProperty("postal")]
            public string Postal { get; set; }
        }

        private static string[] GetLocation(string ip)
        {
            IpInfo ipInfo = new IpInfo();
            try
            {
                string info = new WebClient().DownloadString("http://ipinfo.io/" + ip);
                ipInfo = JsonConvert.DeserializeObject<IpInfo>(info);
                RegionInfo myRI1 = new RegionInfo(ipInfo.Country);
                ipInfo.Country = myRI1.EnglishName;
            }
            catch (Exception ex)
            {
                ipInfo.Country = null;
            }

            //string ret = ipInfo.City;
            string[] ret = { ipInfo.City, ipInfo.Country, ipInfo.Region };
            return ret;
        }

        private void addVisitor(string ip)
        {
            MySqlConnection conn = new MySqlConnection(ConfigurationManager.ConnectionStrings["DBCONN_VS"].ConnectionString);
            MySqlCommand comm = new MySqlCommand();

            string[] array = GetLocation(ip);

            string City = array[0] == null ? "" : array[0];
            string Country = array[1] == null ? "" : array[1];
            string State = array[2] == null ? "" : array[2];

            try
            {
                comm.CommandType = CommandType.StoredProcedure;
                comm.CommandText = "proc_Visitor_add";
                comm.Connection = conn;

                comm.Parameters.AddWithValue("ip", ip);
                comm.Parameters.AddWithValue("city", City);
                comm.Parameters.AddWithValue("state", State);
                comm.Parameters.AddWithValue("country", Country);
                comm.Parameters.AddWithValue("vDate", DateTime.Now);

                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                }

                comm.ExecuteNonQuery();
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
    }
}