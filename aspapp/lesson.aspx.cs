using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace aspapp
{
    public partial class corce : System.Web.UI.Page
    {
        static string strcon = ConfigurationManager.ConnectionStrings["cs"].ConnectionString;
        SqlConnection conn = new SqlConnection(strcon);

        public string title, vid, dis="", flash, lastupdate, likes, views, quis;
        public string[] pic = new string[20];
        public int pics = 0, see_lessons = 0;
        public bool has_lesson = false;
        public string[] see_title = new string[3];
        int user_id, lesson_id;
        protected void Page_Load(object sender, EventArgs e)
        {
            HttpCookie cookie = HttpContext.Current.Request.Cookies["user"];
            if (cookie == null)
                Response.Redirect("~/login.aspx");
            user_id = Int32.Parse(cookie["id"]);
            title = Request.QueryString["lesson"];
            string query = "select * from lesson where title like N'" + title + "'";
            SqlDataAdapter ada = new SqlDataAdapter(query, conn);
            DataTable dt = new DataTable();
            ada.Fill(dt);
            int id = 0;
            conn.Open();

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                has_lesson = true;
                string path = Server.MapPath("~") + @"\txt\";
                DataRow dr = dt.Rows[i];
                id = Int32.Parse(dr["id"].ToString());
                path += dr["dis"].ToString();
                vid = dr["vid"].ToString();
                flash = dr["flash"].ToString();
                quis = dr["quis"].ToString();
                if(dr["dis"].ToString().Length > 4)
                    dis = File.ReadAllText(path);
                lastupdate = Convert.ToDateTime(dr["lastupdate"]).ToString("dd/MM/yyyy");

                SqlCommand command = new SqlCommand("select count (*) from vis where lesson_id = " + id, conn);
                views = Convert.ToString(command.ExecuteScalar());
            }
            lesson_id = id;
            if (id != 0)
            {
                query = "select * from pics where lesson_id =" + id;
                ada = new SqlDataAdapter(query, conn);
                dt = new DataTable();
                ada.Fill(dt);
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    pics++;
                    DataRow dr = dt.Rows[i];
                    pic[i] = dr["pic"].ToString();
                }
            }
            query = "select top 3 * from lesson order by newid()";
            ada = new SqlDataAdapter(query, conn);
            dt = new DataTable();
            ada.Fill(dt);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                see_lessons++;
                DataRow dr = dt.Rows[i];
                see_title[i] = dr["title"].ToString();
            }
            try
            {
                SqlCommand command = new SqlCommand("insert into vis (lesson_id , user_id) values (" + id + " , " + Int32.Parse(cookie["id"]) + ")", conn);
                command.ExecuteNonQuery();
            }
            catch
            {
            }
            conn.Close();
            liks();
        }
        void liks()
        {

            SqlCommand command = new SqlCommand("select count (*) from [like] where lesson_id = " + lesson_id, conn);
            conn.Open();
            likes = Convert.ToString(command.ExecuteScalar());
            conn.Close();

        }
        protected void lesson_like_Click(object sender, EventArgs e)
        {
            conn.Open();
            try
            {
                SqlCommand command = new SqlCommand("insert into [like] (lesson_id , user_id) values (" + lesson_id + " , " + user_id + ")", conn);
                command.ExecuteNonQuery();
                conn.Close();
            }
            catch
            {
            }
            liks();
        }

        protected void send_feedback_Click(object sender, EventArgs e)
        {

            conn.Open();
            SqlCommand command = new SqlCommand("select name from users where id = " + user_id, conn);
            string user_name = Convert.ToString(command.ExecuteScalar());
            string message = feedback_textbox.Text;
            message = message.Trim();
            if (message != "")
            {
                command = new SqlCommand("insert into [feedback] (user_name , message) values (N'" + user_name + "' , N'" + message + "')", conn);
                command.ExecuteNonQuery();
            }
            feedback_textbox.Text = "";

            conn.Close();
        }
        public void lesson_signout_Click(object sender, EventArgs e)
        {
            if (Request.Cookies["user"] != null)
            {
                Response.Cookies["user"].Expires = DateTime.Now.AddDays(-1);
                Response.Redirect("~/index.aspx");
            }
        }
        protected void lesson_manager_Click(object sender, EventArgs e)
        {
            if (Request.Cookies["user"] != null)
                Response.Cookies["user"].Expires = DateTime.Now.AddDays(-1);
            Response.Redirect("~/login.aspx");
        }
    }
}