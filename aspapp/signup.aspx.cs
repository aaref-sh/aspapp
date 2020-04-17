using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web;

namespace aspapp
{
    public partial class signup : System.Web.UI.Page
    {
        static string strcon = ConfigurationManager.ConnectionStrings["cs"].ConnectionString;
        SqlConnection conn = new SqlConnection(strcon);

        public bool ex1=false,ex2=false,ex3=false;
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected string inc(string a)
        {
            char[] charAArray = a.ToCharArray();
            char[] result = new char[a.Length];
            for (int i = 0; i < a.Length; i++)
                result[i] = (char)(charAArray[i] ^ 'S');
            return new string(result);
        }
        protected void sign_up_Click(object sender, EventArgs e)
        {
            if(signup_password.Text != signup_repassword.Text)
            {
                ex2 = true;
                signup_password.Text = signup_repassword.Text = "";
                return;
            }
            else if(signup_password.Text.Length < 4)
            {
                ex3 = true;
                signup_password.Text = signup_repassword.Text = "";
                return;
            }
            SqlCommand cmd = new SqlCommand("Select id from users where name= @Username", conn);
            cmd.Parameters.AddWithValue("@Username", signup_name.Text);
            conn.Open();

            var nId = cmd.ExecuteScalar();

            if (nId != null)
            {
                signup_password.Text = signup_repassword.Text = signup_name.Text = "";
                ex1 = true;
            }
            else
            {
                SqlCommand command = new SqlCommand("INSERT INTO users (name, pass,lastv) VALUES (@name, @pass,@lastv)", conn);
                command.Parameters.AddWithValue("@name", signup_name.Text);
                command.Parameters.AddWithValue("@pass", inc(signup_password.Text));
                command.Parameters.AddWithValue("@lastv", DateTime.Now);
                command.ExecuteNonQuery();
                command = new SqlCommand("select id from users where name like N'" + signup_name.Text + "'");
                command.Connection = conn;
                string id = Convert.ToString(command.ExecuteScalar());
                conn.Close();
                HttpCookie cookie = new HttpCookie("user");
                Response.Cookies.Add(cookie);
                cookie["id"] = id;
                Response.Redirect("~/lessons.aspx");
            }
        }
    }
}