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
    public partial class MasterCP : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (Request.Cookies["userID"] != null)
                {
                    lblName.Text = Request.Cookies["userName"].Value;
                    lblName2.Text = Request.Cookies["userName"].Value;

                    if (Request.Cookies["role"].Value == "Admin")
                    {
                        liUser.Visible = true;
                    }
                }
                else
                {
                    Response.Redirect("Logout.aspx");
                    return;
                }
            }
        }
    }
}