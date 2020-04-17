using System;
using System.IO;
using System.Web.UI;

namespace aspapp
{
    public partial class index : System.Web.UI.Page
    {
        public int x = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            string path = Server.MapPath("~") + @"\vid.txt";
            string s = File.ReadAllText(path);
            vid.Controls.Add(new LiteralControl(s));
        }

        protected void signin_Click(object sender, EventArgs e)
        {

        }
        protected void signout_Click(object sender, EventArgs e)
        {
            if (Request.Cookies["user"] != null)
                Response.Cookies["user"].Expires = DateTime.Now.AddDays(-1);
            else if (Request.Cookies["admin"] != null)
                Response.Cookies["admin"].Expires = DateTime.Now.AddDays(-1);
            else if (Request.Cookies["manager"] != null)
                Response.Cookies["manager"].Expires = DateTime.Now.AddDays(-1);
            Response.Redirect("~/index.aspx");
        }

        protected void index_admin_Click(object sender, EventArgs e)
        {
            if (Request.Cookies["user"] != null)
                Response.Cookies["user"].Expires = DateTime.Now.AddDays(-1);
            Response.Redirect("~/login.aspx");
        }
        protected void lesson_Click(object sender, EventArgs e)
        {
            if (Request.Cookies["admin"] != null)
                Response.Cookies["admin"].Expires = DateTime.Now.AddDays(-1);
            Response.Redirect("~/login.aspx");
        }
    }
}