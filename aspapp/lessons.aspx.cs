using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web;

namespace aspapp
{
    public partial class lessons : System.Web.UI.Page
    {
        static string strcon = ConfigurationManager.ConnectionStrings["cs"].ConnectionString;
        SqlConnection conn = new SqlConnection(strcon);

        public string name, date;
        public int x, vis, like;


        #region lesson info
        public string[] vid = new string[100];
        public string[] title = new string[100];

        public string[] lastupdate = new string[100];
        public string[] views = new string[100];
        public string[] likes = new string[100];
        #endregion


        public int counter = 0;

        protected void lessons_search_button_Click(object sender, EventArgs e)
        {
            conn.Open();
            string query = "select * from lesson where title like N'%" + lessons_search_tb.Text + "%'";
            SqlDataAdapter ada = new SqlDataAdapter(query, conn);
            DataTable dt = new DataTable();
            ada.Fill(dt);
            counter = 0;
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                counter++;
                DataRow dr = dt.Rows[i];
                int id = Int32.Parse(dr["id"].ToString());
                vid[i] = dr["vid"].ToString();
                title[i] = dr["title"].ToString();
                lastupdate[i] = Convert.ToDateTime(dr["lastupdate"]).ToString("dd/MM/yyyy");

                SqlCommand command = new SqlCommand("select count (*) from [like] where lesson_id = " + id);
                command.Connection = conn;
                likes[i] = Convert.ToString(command.ExecuteScalar());

                command = new SqlCommand("select count (*) from vis where lesson_id = " + id);
                command.Connection = conn;
                views[i] = Convert.ToString(command.ExecuteScalar());
            }
            conn.Close();
            string t;
            for (int i = 0; i < counter-1; i++)
                for (int j = i + 1; j < counter; j++)
                    if (string.Compare(title[i], title[j]) > 0)
                    {
                        t = title[i];
                        title[i] = title[j];
                        title[j] = t;

                        t = vid[i];
                        vid[i] = vid[j];
                        vid[j] = t;

                        t = lastupdate[i];
                        lastupdate[i] = lastupdate[j];
                        lastupdate[j] = t;

                        t = likes[i];
                        likes[i] = likes[j];
                        likes[j] = t;

                        t = views[i];
                        views[i] = views[j];
                        views[j] = t;

                    }

        }
        protected void lesson_manager_Click(object sender, EventArgs e)
        {
            if (Request.Cookies["user"] != null)
                Response.Cookies["user"].Expires = DateTime.Now.AddDays(-1);
            Response.Redirect("~/login.aspx");
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            HttpCookie cookie = HttpContext.Current.Request.Cookies["user"];
            if (cookie == null)
            {
                Response.Redirect("~/login.aspx");
            }
            x = Int32.Parse(cookie["id"]);

            conn.Open();
            string query = "select * from users where id = " + x;
            SqlDataAdapter ada = new SqlDataAdapter(query, conn);
            DataTable dt = new DataTable();
            ada.Fill(dt);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                DataRow dr = dt.Rows[i];
                date = Convert.ToDateTime(dr["lastv"]).ToString("yyyy/MM/dd");
                name = dr["name"].ToString();
            }

            SqlCommand cmd = new SqlCommand("update users set lastv = cast(@date as datetime) where id = " + x, conn);
            cmd.Parameters.AddWithValue("@date", DateTime.Now);
            cmd.ExecuteNonQuery();

            SqlCommand command = new SqlCommand("select count (*) from vis where user_id = " + x);
            command.Connection = conn;
            vis = Convert.ToInt32(command.ExecuteScalar());

            command = new SqlCommand("select count (*) from [like] where user_id = " + x);
            command.Connection = conn;
            like = Convert.ToInt32(command.ExecuteScalar());
            
            conn.Close();

            lessons_search_button_Click(sender, e);
        }

        protected void lessons_signout_Click(object sender, EventArgs e)
        {
            if (Request.Cookies["user"] != null)
            {
                Response.Cookies["user"].Expires = DateTime.Now.AddDays(-1);
                Response.Redirect("~/index.aspx");
            }
        }
    }
}