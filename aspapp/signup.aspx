<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="signup.aspx.cs" Inherits="aspapp.signup" EnableEventValidation="false"%>

<!DOCTYPE html>

<html lang="en">
<head runat="server">
    <% HttpCookie cookie = HttpContext.Current.Request.Cookies["user"];
        if (cookie != null)
        { %>
        <meta http-equiv="Refresh" content="0; url=lessons.aspx" />
    <%}
        cookie = HttpContext.Current.Request.Cookies["admin"];
        if (cookie != null)
        { %>
        <meta http-equiv="Refresh" content="0; url=admin.aspx" />
        <%}%>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="icon" href="img/favicon.png" type="image/png" />
    <title>نسجيل حساب</title>

    <!-- Font Icon -->
    <link rel="stylesheet" href="login/fonts/material-icon/css/material-design-iconic-font.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <!-- Main css -->
    <link rel="stylesheet" href="login/css/style.css">
</head>
<body>
    <form id="form1" runat="server">
        <div class="main">

        <!-- Sign up form -->
            <section class="signup">
                <div class="container" style="text-align: center;">
                    <div class="signup-content">
                        <div class="signup-form">
                            <h2 class="form-title">انشاء حساب</h2>
                            <form method="POST" class="register-form" id="register-form">
                                <form class="pure-form">
                                    <%if (ex1 == true)
                                        { %>
                                    <div class="alert alert-warning" role="alert">
                                        اسم المستخدم موجود بالفعل ,, جرب اختيار اسم اخر
                                    </div>
                                    <%} %>
                                    <%if (ex2 == true)
                                        { %>
                                    <div class="alert alert-warning" role="alert">
                                        كلمتي المرور غير متطابقتين
                                    </div>
                                    <%} %>
                                    <%if (ex3 == true)
                                        { %>
                                    <div class="alert alert-warning" role="alert">
                                        يجب أن تكون كلمة المرور من 4 محارف على الأقل
                                    </div>
                                    <%} %>
                                    <div class="form-group">
                                        <label for="name"><i class="zmdi zmdi-account material-icons-name"></i></label>
                                        <asp:Textbox runat="server" type="text" name="name" id="signup_name" placeholder="اسم المستخدم" required/>
                                    </div>
                                    <div class="form-group">
                                        <label for="pass"><i class="zmdi zmdi-lock"></i></label>
                                        <asp:Textbox runat="server" type="password" placeholder="كلمة المرور" id="signup_password" required></asp:Textbox>
                                    </div>
                                    <div class="form-group">
                                        <label for="re-pass"><i class="zmdi zmdi-lock-outline"></i></label>
                                        <asp:Textbox runat="server" type="password" placeholder="أعد كتابة كلمة المرور" id="signup_repassword" required></asp:Textbox>
                                    </div>
                                    <asp:button runat="server" type="submit" CssClass="form-submit pure-button pure-button-primary" ID="sign_up" Text="تسجيل" OnClick="sign_up_Click"></asp:button>
                                </form>
                            </form>
                        </div>
                        <div class="signup-image">
                            <figure><img src="images/signup-image.jpg" alt="sing up image"></figure>
                            <a href="login.aspx" class="signup-image-link">لدي حساب بالفعل</a>
                            <a href="index.aspx" class="signup-image-link">الصفحة الرئيسية</a>
                        </div>
                    </div>
                </div>
            </section>
        </div>

        <!-- JS -->
        <script src="login/vendor/jquery/jquery.min.js"></script>
        <script src="login/js/main.js"></script>
    </form>
</body>
</html>
