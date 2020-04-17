using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web;

namespace aspapp
{
    public partial class login : System.Web.UI.Page
    {
        static string strcon = ConfigurationManager.ConnectionStrings["cs"].ConnectionString;
        SqlConnection conn = new SqlConnection(strcon);

        public bool wrong = false, bad=false;
        protected void Page_Load(object sender, EventArgs e)
        {
            HttpCookie cookie = HttpContext.Current.Request.Cookies["user"];
            if (cookie != null)
                Response.Redirect("~/lessons.aspx");
            cookie = HttpContext.Current.Request.Cookies["admin"];
            if (cookie != null)
                Response.Redirect("~/admin.aspx");
            cookie = HttpContext.Current.Request.Cookies["manager"];
            if (cookie != null)
                Response.Redirect("~/manager.aspx");

        }
        protected string inc(string a)
        {
            char[] charAArray = a.ToCharArray();
            char[] result = new char[a.Length];
            for (int i = 0; i < a.Length; i++)
                result[i] = (char)(charAArray[i] ^ 'S');
            return new string(result);
        }
        protected void signin_Click(object sender, EventArgs e)
        {
            try
            {
                string user = login_user.Text;
                string pass = inc(login_pass.Text);

                if (user == "manager" && inc(pass) == "manager")
                {
                    HttpCookie cookie = new HttpCookie("manager");
                    Response.Cookies.Add(cookie);
                    Response.Redirect("~/manager.aspx");
                }

                SqlCommand command = new SqlCommand("select id from users where name like N'" + user + "' and pass like N'" + pass + "'");
                command.Connection = conn;
                conn.Open();
                string id = Convert.ToString(command.ExecuteScalar());
                command = new SqlCommand("select [admin] from users where name like N'" + user + "' and pass like N'" + pass + "'");
                command.Connection = conn;
                bool admin = Convert.ToBoolean(command.ExecuteScalar());

                if (id != "")
                {
                    command = new SqlCommand("select [en] from users where id = " + id, conn);
                    bool enabled = Convert.ToBoolean(command.ExecuteScalar());
                    conn.Close();
                    if (enabled == false)
                    {
                        bad = true;
                        return;
                    }
                    if (!admin)
                    {
                        HttpCookie cookie = new HttpCookie("user");
                        Response.Cookies.Add(cookie);
                        cookie["id"] = id;
                        Response.Redirect("~/lessons.aspx");
                    }
                    else
                    {
                        HttpCookie cookie = new HttpCookie("admin");
                        Response.Cookies.Add(cookie);
                        cookie["id"] = id;
                        Response.Redirect("~/admin.aspx");
                    }
                }
                else
                {
                    wrong = true;
                }
            }
            catch(Exception ex)
            {
                Response.Write(ex.Message);
            }
        }
    }
}