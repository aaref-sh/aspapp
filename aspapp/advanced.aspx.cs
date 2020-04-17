using System;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace aspapp
{
    public partial class advanced : System.Web.UI.Page
    {
        public string row ,s;
        static string strcon = ConfigurationManager.ConnectionStrings["cs"].ConnectionString;
        SqlConnection conn = new SqlConnection(strcon);
        public Button[] b = new Button[1000];
        public int n;
        public string[] ss = new string[1000];
        StringBuilder sb = new StringBuilder();
       
        public HtmlTextWriter htmlWriter;
        

        protected void Page_Load(object sender, EventArgs e)
        {
            
            LinkButton b = new LinkButton();
            b.Text = "del";
            b.ID = "1112";
            b.Click += answer_Click;
            
            dd.Controls.Add(b);

            
        }
        public void butn()
        {
            
        }
        private void answer_Click(object sender, EventArgs e)
        {
            var d = sender as LinkButton;
            Response.Write(d.ID.ToString());
        }

        protected void btnunzip_Click(object sender, EventArgs e)
        {
            try
            {
                string zipPath = Server.MapPath("~/") + filename.Text + ".zip";
                string extractPath = Server.MapPath("~/extract/");
                System.IO.Compression.ZipFile.ExtractToDirectory(zipPath, extractPath);
            }
            catch (Exception ex)
            {
                labelunzip.Text = ex.Message.ToString();
            }
        }

        protected void btnupload_Click(object sender, EventArgs e)
        {
            try
            {
                foreach (HttpPostedFile uploadedFile in FileUpload1.PostedFiles)
                {
                    string name = uploadedFile.FileName;
                    uploadedFile.SaveAs(Path.Combine(Server.MapPath("~/files/"), name));
                }
            }
            catch (Exception ex)
            {
                lableupload.Text = ex.Message.ToString();
            }
        }

        protected void btnquery_Click(object sender, EventArgs e)
        {
            SqlCommand cmd = new SqlCommand(query.Text, conn);
            conn.Open();
            try
            {
                cmd.ExecuteNonQuery();
                GridView1.DataSource = cmd.ExecuteScalar();
            }
            catch (Exception ex)
            {
                result.Text = ex.Message.ToString();
            }
        }
    }
}