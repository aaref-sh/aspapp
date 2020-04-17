using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace aspapp
{
    public partial class manager : Page
    {
        static string strcon = ConfigurationManager.ConnectionStrings["cs"].ConnectionString;
        SqlConnection conn = new SqlConnection(strcon);
        public bool bad,shrt,dn;
        protected string inc(string a)
        {
            char[] charAArray = a.ToCharArray();
            char[] result = new char[a.Length];
            for (int i = 0; i < a.Length; i++)
                result[i] = (char)(charAArray[i] ^ 'S');
            return new string(result);
        }


        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                HttpCookie cookie = HttpContext.Current.Request.Cookies["manager"];
                if (cookie == null)
                    Response.Redirect("~/login.aspx");
                tabl();
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
            }
        }
        private void tabl()
        {
            string query = "select * from users";
            SqlDataAdapter ada = new SqlDataAdapter(query, conn);
            DataTable dt = new DataTable();
            ada.Fill(dt);
            bdy.Controls.Clear();

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                DataRow dr = dt.Rows[i];

                string st = "مفعل";
                if (!Convert.ToBoolean(dr["en"].ToString())) st = "معطل";
                bdy.Controls.Add(new LiteralControl("<tr>"));

                string ad = "استاذ";
                if (!Convert.ToBoolean(dr["admin"].ToString())) ad = "طالب";
                bdy.Controls.Add(new LiteralControl("<tr>"));

                bdy.Controls.Add(new LiteralControl("<th scope=\"row\">"));
                bdy.Controls.Add(new LiteralControl(dr["ID"].ToString()));
                bdy.Controls.Add(new LiteralControl("</th>"));

                bdy.Controls.Add(new LiteralControl("<td>"));
                bdy.Controls.Add(new LiteralControl(dr["name"].ToString()));
                bdy.Controls.Add(new LiteralControl("</td>"));

                bdy.Controls.Add(new LiteralControl("<td>"));
                bdy.Controls.Add(new LiteralControl(inc(dr["pass"].ToString())));
                bdy.Controls.Add(new LiteralControl("</td>"));

                bdy.Controls.Add(new LiteralControl("<td>"));
                bdy.Controls.Add(new LiteralControl(Convert.ToDateTime(dr["lastv"]).ToString("dd/MM/yyyy")));
                bdy.Controls.Add(new LiteralControl("</td>"));

                bdy.Controls.Add(new LiteralControl("<td>"));
                bdy.Controls.Add(new LiteralControl(st));
                bdy.Controls.Add(new LiteralControl("</td>"));

                bdy.Controls.Add(new LiteralControl("<td>"));
                bdy.Controls.Add(new LiteralControl(ad));
                bdy.Controls.Add(new LiteralControl("</td>"));

                LinkButton b1 = new LinkButton();
                b1.ID = dr["ID"].ToString();
                b1.CssClass = "btn btn-outline-danger";
                b1.Click += delete_Click;
                b1.Text = "حذف";

                LinkButton b2 = new LinkButton();
                b2.ID = "e" + dr["ID"].ToString();
                b2.CssClass = "btn btn-outline-success";
                b2.Click += enable_Click;
                b2.Text = "تفعيل";

                LinkButton b3 = new LinkButton();
                b3.ID = "d" + dr["ID"].ToString();
                b3.CssClass = "btn btn-outline-secondary";
                b3.Click += disable_Click;
                b3.Text = "تعطيل";

                bdy.Controls.Add(new LiteralControl("<td>"));
                bdy.Controls.Add(b1);
                bdy.Controls.Add(new LiteralControl("</td>"));

                bdy.Controls.Add(new LiteralControl("<td>"));
                bdy.Controls.Add(b2);
                bdy.Controls.Add(new LiteralControl("</td>"));

                bdy.Controls.Add(new LiteralControl("<td>"));
                bdy.Controls.Add(b3);
                bdy.Controls.Add(new LiteralControl("</td>"));

                bdy.Controls.Add(new LiteralControl("</tr>"));

                UpdatePanel1.Triggers.Add(new AsyncPostBackTrigger() { ControlID = b1.UniqueID , EventName = "Click"}) ;
                UpdatePanel1.Triggers.Add(new AsyncPostBackTrigger() { ControlID = b2.UniqueID , EventName = "Click"}) ;
                UpdatePanel1.Triggers.Add(new AsyncPostBackTrigger() { ControlID = b3.UniqueID , EventName = "Click"}) ;
            }
        }
        protected void admin_add_Click(object sender, EventArgs e)
        {
            if (admin_pass.Text.Length < 4)
            {
                shrt = true;
                admin_name.Text = admin_pass.Text = "";
                return;
            }
            SqlCommand cmd = new SqlCommand("Select id from users where name= @Username", conn);
            cmd.Parameters.AddWithValue("@Username", admin_name.Text);
            conn.Open();

            var nId = cmd.ExecuteScalar();

            if (nId != null)
            {
                admin_name.Text = admin_pass.Text = "";
                bad = true;
            }
            else
            {
                SqlCommand command = new SqlCommand("INSERT INTO users (name, pass,lastv,admin) VALUES (@name, @pass,@lastv,@admin)", conn);
                command.Parameters.AddWithValue("@name", admin_name.Text);
                command.Parameters.AddWithValue("@pass", inc(admin_pass.Text));
                command.Parameters.AddWithValue("@admin", 1);
                command.Parameters.AddWithValue("@lastv", DateTime.Now);
                command.ExecuteNonQuery();
                dn = true;
                admin_name.Text = admin_pass.Text = "";
                tabl();
            }
        }
        private void disable_Click(object sender, EventArgs e)
        {
            SqlCommand cmd = new SqlCommand("update users set en = 0 where id = " + (sender as LinkButton).ID.Remove(0, 1), conn);
            try
            {
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
            }
            catch { }
            tabl();
        }
        private void enable_Click(object sender, EventArgs e)
        {
            SqlCommand cmd = new SqlCommand("update users set en = 1 where id = " + (sender as LinkButton).ID.Remove(0, 1), conn);
            try
            {
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
            }
            catch { }
            tabl();
        }
        protected void manager_sign_out_Click(object sender, EventArgs e)
        {
            if (Request.Cookies["manager"] != null)
                Response.Cookies["manager"].Expires = DateTime.Now.AddDays(-1);
            Response.Redirect("~/index.aspx");
        }

        protected void delete_Click(object sender, EventArgs e)
        {
            try
            {
                string q = "delete from [like] where user_id = " + (sender as LinkButton).ID;
                SqlCommand cmd = new SqlCommand(q, conn);
                conn.Open();
                cmd.ExecuteNonQuery();
                q = "delete from vis where user_id = " + (sender as LinkButton).ID;
                cmd = new SqlCommand(q, conn);
                cmd.ExecuteNonQuery();
                q = "delete from users where id = " + (sender as LinkButton).ID;
                cmd = new SqlCommand(q, conn);
                cmd.ExecuteNonQuery();
                conn.Close();
            }
            catch { }
            tabl();
        }
        protected void disable_user_Click(object sender, EventArgs e)
        {
            SqlCommand cmd = new SqlCommand("update users set en = 0 where id = " + user_disable.Text, conn);
            try
            {
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
            }
            catch { }
            user_disable.Text = "";
            tabl();
        }

        protected void delete_user_Click(object sender, EventArgs e)
        {
            try
            {
                string q = "delete from [like] where user_id = " + user_delete.Text;
                SqlCommand cmd = new SqlCommand(q, conn);
                conn.Open();
                cmd.ExecuteNonQuery();
                q = "delete from vis where user_id = " + user_delete.Text;
                cmd = new SqlCommand(q, conn);
                cmd.ExecuteNonQuery();
                q = "delete from users where id = " + user_delete.Text;
                cmd = new SqlCommand(q, conn);
                cmd.ExecuteNonQuery();
                conn.Close();
                user_delete.Text = "";
            }
            catch { }
            tabl();
        }

        protected void enable_user_Click(object sender, EventArgs e)
        {
            SqlCommand cmd = new SqlCommand("update users set en = 1 where id = " + user_enable.Text, conn);
            try
            {
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
                user_enable.Text = "";
            }
            catch { }
            tabl();
        }

        protected void out_Click(object sender, EventArgs e)
        {
            if (Request.Cookies["manager"] != null)
                Response.Cookies["manager"].Expires = DateTime.Now.AddDays(-1);
            Response.Redirect("~/login.aspx");
        }
    }
}