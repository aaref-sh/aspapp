using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace aspapp
{
    public partial class admin : System.Web.UI.Page
    {
        static string strcon = ConfigurationManager.ConnectionStrings["cs"].ConnectionString;
        SqlConnection conn = new SqlConnection(strcon);

        public bool done = false;
        public string message, status, lastv, all;
        public int lessons = 0, students = 0, x = 0, tab;

        protected void Page_Load(object sender, EventArgs e)
        {
            HttpCookie cookie = HttpContext.Current.Request.Cookies["admin"];
            if (cookie == null)
                Response.Redirect("~/login.aspx");

            conn.Open();
            try
            {
                SqlCommand command = new SqlCommand("select lastv from users where id = " + Int32.Parse(cookie["id"]), conn);
                lastv = Convert.ToDateTime(command.ExecuteScalar()).ToString("dd-MM-yyyy");

                command = new SqlCommand("select count (*) from users where [admin] = " + 0, conn);
                students = Convert.ToInt32(command.ExecuteScalar());
                string qs; qs = Request.QueryString["tab"];
                if (qs != null) x = Int32.Parse(qs);

                command = new SqlCommand("update users set lastv = cast(@date as datetime) where id = " + Int32.Parse(cookie["id"]), conn);
                command.Parameters.AddWithValue("@date", DateTime.Now);
                command.ExecuteNonQuery();
                conn.Close();
                lessons_n();
                card();
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message.ToString());
            }
        }
        void lessons_n()
        {
            lessons = 0;
            all = "";
            string query = "select title from [lesson]";
            SqlDataAdapter ada = new SqlDataAdapter(query, conn);
            DataTable dt = new DataTable();
            ada.Fill(dt);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                lessons++;
                DataRow dr = dt.Rows[i];
                all += dr["title"].ToString() + "<br />";
            }

        }
        void card()
        {
            bool c = false;

            string query = "select * from [feedback]";
            SqlDataAdapter ada = new SqlDataAdapter(query, conn);
            DataTable dt = new DataTable();
            ada.Fill(dt);
            sug.Controls.Clear();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                c = true;
                DataRow dr = dt.Rows[i];

                sug.Controls.Add(new LiteralControl("<div class=\"card bg-light mb-3\" dir=\"rtl\"><div class=\"card-header\">اقتراح "));
                sug.Controls.Add(new LiteralControl( (i + 1) + "</div><div class=\"card-body\">"));
                sug.Controls.Add(new LiteralControl("<h5 class=\"card-title\">من: " + dr["user_name"].ToString() + "</h5><p class=\"card-text\">" + dr["message"].ToString() + "</p><p>"));

                LinkButton lb = new LinkButton();
                lb.ID = dr["id"].ToString();
                lb.Text = "حذف";
                lb.Click += delete_message_Click;
                sug.Controls.Add(lb);
                sug.Controls.Add(new LiteralControl("</p></div></div>"));

            }
            if (!c)
            {
                sug.Controls.Add(new LiteralControl(" <div class=\"alert alert-primary\" role=\"alert\">ما من اقتراحات حتى الآن</div>"));
            }
        }
        protected void lessons_Click(object sender, EventArgs e)
        {
            if (Request.Cookies["admin"] != null)
                Response.Cookies["admin"].Expires = DateTime.Now.AddDays(-1);
            HttpCookie cookie = new HttpCookie("user");
            Response.Cookies.Add(cookie);
            cookie["id"] = "10";
            Response.Redirect("~/lessons.aspx");
        }
        protected void admin_sign_out_Click(object sender, EventArgs e)
        {
            if (Request.Cookies["admin"] != null)
                Response.Cookies["admin"].Expires = DateTime.Now.AddDays(-1);
            Response.Redirect("~/index.aspx");
        }
        string nowname()
        {
            return DateTime.Now.ToString("dd-MM-yyyy-HH-mm-ss");
        }
        protected void upload_Click(object sender, EventArgs e)
        {
            tab = 1;
            if (add_Images.HasFiles && add_vid.HasFile && add_title.Text != "" && add_quistion.Text != "")
            {
                SqlCommand command = new SqlCommand("select id from lesson where title like N'" + add_title.Text + "'", conn);
                conn.Open();
                string exist = Convert.ToString(command.ExecuteScalar());
                if (exist != "")
                {
                    add_title.Text = add_quistion.Text = "";
                    message = "⚠ عنوان الدرس موجود بالفعل";
                    status = "warning";
                    done = true;
                    conn.Close();
                    return;
                }
                try
                {
                    string vid_name, txt_name="", flash_name = "0";
                    string[] img_name = new string[20];
                    int i = 0;
                    if(add_text.HasFile)
                        txt_name = nowname() + Path.GetExtension(add_text.FileName);
                    vid_name = nowname() + Path.GetExtension(add_vid.FileName);
                    if (add_flash.HasFile)
                    {
                        flash_name = nowname() + Path.GetExtension(add_flash.FileName);
                        add_flash.SaveAs(Path.Combine(Server.MapPath("~/swf/"), flash_name));

                    }
                    if(add_text.HasFile)
                        add_text.SaveAs(Path.Combine(Server.MapPath("~/txt/"), txt_name));
                    add_vid.SaveAs(Path.Combine(Server.MapPath("~/Video/"), vid_name));

                    command = new SqlCommand("INSERT INTO lesson (title, vid,dis,lastupdate,quis,flash) VALUES (N'" + add_title.Text + "', @vid,@dis,@date,@quis,@flash)", conn);
                    command.Parameters.AddWithValue("@vid", vid_name);
                    command.Parameters.AddWithValue("@dis", txt_name);
                    command.Parameters.AddWithValue("@date", DateTime.Now);
                    command.Parameters.AddWithValue("@quis", add_quistion.Text);
                    command.Parameters.AddWithValue("@flash", flash_name);
                    command.ExecuteNonQuery();

                    command = new SqlCommand("select id from lesson where title like N'" + add_title.Text + "'", conn);

                    int id = Convert.ToInt32(command.ExecuteScalar());

                    foreach (HttpPostedFile uploadedFile in add_Images.PostedFiles)
                    {
                        img_name[i] = nowname() +i+Path.GetExtension(uploadedFile.FileName);
                        uploadedFile.SaveAs(Path.Combine(Server.MapPath("~/pics/"), img_name[i]));
                        command = new SqlCommand("INSERT INTO pics (lesson_id,pic) VALUES (" + id + ",'" + img_name[i] + "')", conn);
                        command.ExecuteNonQuery();
                        i++;
                    }
                    message = "✔ تمت إضافة الدرس بنجاح";
                    status = "success";
                    done = true;

                }
                catch (Exception ex)
                {
                    message = "❌ لم يتم رفع الملفات";
                    message += "رسالة الخطأ: " + ex.Message.ToString();
                    status = "danger";
                    done = true;
                }
                add_title.Text = add_quistion.Text = "";
                conn.Close();
            }
            else
            {
                message = " يرجى ملئ كافة الحقول ⚠ <br>";
                if (!add_Images.HasFile) message += "،قم بتحديد صور <br>";
                if (!add_vid.HasFile) message += "،قم بتحديد ملف فيديو <br>";
                if (add_title.Text == "") message += "،اكتب عنواناً للدرس <br>";
                if (add_quistion.Text == "") message += "أدخل رابط تضمين اختبار الدرس.";
                status = "warning";
                done = true;
            }
            lessons_n();
        }
        protected void edit_Click(object sender, EventArgs e)
        {
            tab = 2;
            SqlCommand command = new SqlCommand("select id from lesson where title like N'" + edit_title.Text + "'", conn);
            conn.Open();
            string exist = Convert.ToString(command.ExecuteScalar());

            if (exist == "")
            {
                edit_title.Text = "";
                message = "⚠ لا يوجد درس بهذا العنوان";
                status = "warning";
                done = true;
                conn.Close();
                return;
            }
            try
            {
                int id = Int32.Parse(exist);
                string vid_name, txt_name, flash_name;
                string[] img_name = new string[20];

                if (edit_vid.HasFile)
                {
                    command = new SqlCommand("select vid from lesson where id =" + id, conn);
                    string video = Convert.ToString(command.ExecuteScalar());
                    File.Delete(Server.MapPath("~/Video/") + video);
                    vid_name = nowname() + Path.GetExtension(edit_vid.FileName);
                    edit_vid.SaveAs(Path.Combine(Server.MapPath("~/Video/"), vid_name));
                    command = new SqlCommand("update lesson set vid = N'" + vid_name + "', lastupdate = @date  where id = " + id, conn);
                    command.Parameters.AddWithValue("@date", DateTime.Now);
                    command.ExecuteNonQuery();
                }
                if (edit_flash.HasFile)
                {
                    command = new SqlCommand("select flash from lesson where id =" + id, conn);
                    string flash = Convert.ToString(command.ExecuteScalar());
                    File.Delete(Server.MapPath("~/swf/") + flash);
                    flash_name = nowname() + Path.GetExtension(edit_flash.FileName);
                    edit_flash.SaveAs(Path.Combine(Server.MapPath("~/swf/"), flash_name));
                    command = new SqlCommand("update lesson set flash = N'" + flash_name + "', lastupdate = @date  where id = " + id, conn);
                    command.Parameters.AddWithValue("@date", DateTime.Now);
                    command.ExecuteNonQuery();
                }
                if (edit_quistion.Text != "")
                {
                    command = new SqlCommand("update lesson set quis = N'" + edit_quistion.Text + "' where id = " + id, conn);
                    command.ExecuteNonQuery();

                }
                if (edit_txt.HasFile)
                {
                    command = new SqlCommand("select dis from lesson where id =" + id, conn);
                    string txt = Convert.ToString(command.ExecuteScalar());
                    if(txt != "")
                        File.Delete(Server.MapPath("~/txt/") + txt);
                    txt_name = nowname() + Path.GetExtension(edit_txt.FileName);
                    edit_txt.SaveAs(Path.Combine(Server.MapPath("~/txt/"), txt_name));
                    command = new SqlCommand("update lesson set dis = N'" + txt_name + "', lastupdate = @date where id = " + id, conn);
                    command.Parameters.AddWithValue("@date", DateTime.Now);
                    command.ExecuteNonQuery();
                }
                if (edit_image.HasFile)
                {

                    string query = "select pic from pics where lesson_id = " + id;
                    SqlDataAdapter ada = new SqlDataAdapter(query, conn);
                    DataTable dt = new DataTable();
                    ada.Fill(dt);

                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        DataRow dr = dt.Rows[i];
                        string pic = dr["pic"].ToString();
                        File.Delete(Server.MapPath("~/pics/") + pic);
                    }
                    command = new SqlCommand("delete from pics where lesson_id = " + id, conn);
                    command.ExecuteNonQuery();
                    int k=0;
                    foreach (HttpPostedFile uploadedFile in edit_image.PostedFiles)
                    {
                        string pic = nowname() + k + Path.GetExtension(uploadedFile.FileName);
                        uploadedFile.SaveAs(Path.Combine(Server.MapPath("~/pics/"), pic));
                        command = new SqlCommand("INSERT INTO pics (lesson_id,pic) VALUES (" + id + ",'" + pic + "')", conn);
                        command.ExecuteNonQuery();
                    }
                    command = new SqlCommand("update lesson set lastupdate = @date where id = " + id, conn);
                    command.Parameters.AddWithValue("@date", DateTime.Now);
                    command.ExecuteNonQuery();
                }
                edit_title.Text = edit_quistion.Text = "";
                message = "✔ تم تحديث بيانات الدرس بنجاح";
                status = "success";
                done = true;

            }
            catch (Exception ex)
            {
                add_title.Text = "";
                message = "❌ لم يتم تعديل الملفات";
                message += "رسالة الخطأ: " + ex.Message.ToString();
                status = "danger";
                done = true;
            }
            conn.Close();

        }

        protected void lesson_delete_Click(object sender, EventArgs e)
        {
            tab = 3;
            SqlCommand command = new SqlCommand("select id from lesson where title like N'" + title_lesson_delete.Text + "'", conn);
            conn.Open();
            string exist = Convert.ToString(command.ExecuteScalar());

            if (exist == "")
            {
                title_lesson_delete.Text = "";
                message = "⚠ لا يوجد درس بهذا العنوان";
                status = "warning";
                done = true;
                conn.Close();
                return;
            }
            try
            {
                int id = Int32.Parse(exist);
                string[] img_name = new string[20];

                command = new SqlCommand("select vid from lesson where id =" + id, conn);
                string video = Convert.ToString(command.ExecuteScalar());
                File.Delete(Server.MapPath("~/Video/") + video);
                command = new SqlCommand("select dis from lesson where id =" + id, conn);
                string txt = Convert.ToString(command.ExecuteScalar());
                if(txt != "")
                    File.Delete(Server.MapPath("~/txt/") + txt);
                command = new SqlCommand("select flash from lesson where id =" + id, conn);
                string flash = Convert.ToString(command.ExecuteScalar());
                File.Delete(Server.MapPath("~/swf/") + flash);

                string query = "select pic from pics where lesson_id = " + id;
                SqlDataAdapter ada = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                ada.Fill(dt);
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    DataRow dr = dt.Rows[i];
                    File.Delete(Server.MapPath("~/pics/") + dr["pic"].ToString());
                }
                command = new SqlCommand("delete from pics where lesson_id = " + id, conn);
                command.ExecuteNonQuery();
                command = new SqlCommand("delete from vis where lesson_id = " + id, conn);
                command.ExecuteNonQuery();
                command = new SqlCommand("delete from [like] where lesson_id = " + id, conn);
                command.ExecuteNonQuery();
                command = new SqlCommand("delete from lesson where id = " + id, conn);
                command.ExecuteNonQuery();

                title_lesson_delete.Text = "";
                message = "✔ تم حذف الدرس بنجاح";
                status = "success";
                done = true;

            }
            catch (Exception ex)
            {
                title_lesson_delete.Text = "";
                message = "❌ لم تتم عملية الحذف";
                message += "رسالة الخطأ: " + ex.Message.ToString();

                status = "danger";
                done = true;

            }
            conn.Close();
            lessons_n();
        }
        protected void delete_message_Click(object sender, EventArgs e)
        {
            try
            {
                string id = (sender as LinkButton).ID ;
                SqlCommand command = new SqlCommand("delete from [feedback] where id = " + id, conn);
                conn.Open();
                command.ExecuteNonQuery();
                conn.Close();
            }
            catch
            {
            }
            card();
        }
    }
}