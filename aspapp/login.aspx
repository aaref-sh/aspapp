<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="aspapp.login" EnableEventValidation="false"%>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="css/bootstrap.css" />
    <link rel="icon" href="img/favicon.png" type="image/png" />
    <title>تسجيل الدخول</title>

    <!-- Font Icon -->
    <link rel="stylesheet" href="login/fonts/material-icon/css/material-design-iconic-font.min.css">

    <!-- Main css -->
    <link rel="stylesheet" href="login/css/style.css">
</head>
<body>
    <form id="form1" runat="server">
       <div class="main">
        <!-- Sing in  Form -->
            <section class="sign-in" style="text-align: center;">
                <div class="container">
                    <div class="signin-content">
                        <div class="signin-image">
                            <figure><img src="images/signin-image.jpg" alt="sing up image"></figure>
                            <a href="signup.aspx" class="signup-image-link">إنشاء حساب جديد</a>
                            <a href="index.aspx" class="signup-image-link">الصفحة الرئيسية</a>
                        </div>

                        <div class="signin-form">
                           <% if (wrong)
                               { %>
                            <div class="alert alert-warning alert-dismissible fade show" role="alert">
                              <strong>❕ خطأ في اسم المستخدم أو كلمة المرور </strong>
                              <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                              </button>
                            </div><%}wrong = false;
                                      if (bad)
                                      {%>
                                          <div class="alert alert-warning alert-dismissible fade show" role="alert">
                                          <strong>❕ حسابك معطل - راجع المدير </strong>
                                          <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                          </button>
                                        </div>
                                    <%  }bad = false;
                                      %>
                            <h2 class="form-title">تسجيل الدخول</h2>
                            <form method="POST" class="register-form" id="login-form">
                                <div class="form-group">
                                    <label for="your_name"><i class="zmdi zmdi-account material-icons-name"></i></label>
                                    <asp:Textbox runat="server" type="text" name="your_name" id="login_user" placeholder="اسم المستخدم" required/>
                                </div>
                                <div class="form-group">
                                    <label for="your_pass"><i class="zmdi zmdi-lock"></i></label>
                                    <asp:TextBox runat="server" type="password" name="your_pass" id="login_pass" placeholder="كلمة المرور" required/>
                                </div>
                                <div class="form-group form-button">
                                    <asp:Button runat="server" type="submit" name="signin" id="signin" CssClass="form-submit" Text="تسجيل الدخول" OnClick="signin_Click" OnClientClick="btnlogin"/>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </section>
        </div>

        <!-- JS -->
        <script src="login/vendor/jquery/jquery.min.js"></script>
        <script src="login/js/main.js"></script>
          <script src="js/jquery-3.2.1.min.js"></script>
          <script src="js/popper.js"></script>
          <script src="js/bootstrap.min.js"></script>
          <script src="vendors/nice-select/js/jquery.nice-select.min.js"></script>
    </form>
</body>
</html>
