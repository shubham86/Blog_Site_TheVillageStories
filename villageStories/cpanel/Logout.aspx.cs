using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace villageStories
{
    public partial class Logout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!(Page.IsPostBack))
            {
                
                if (Request.Cookies["userName"] != null)
                {
                    Response.Cookies["userName"].Expires = DateTime.Now.AddDays(-1);
                }
                if (Request.Cookies["userID"] != null)
                {
                    Response.Cookies["userID"].Expires = DateTime.Now.AddDays(-1);
                }
                if (Request.Cookies["role"] != null)
                {
                    Response.Cookies["role"].Expires = DateTime.Now.AddDays(-1);
                }

                Response.Redirect("LoginPage.aspx", false);
            }
        }
    }
}