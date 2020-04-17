<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="lessons.aspx.cs" Inherits="aspapp.lessons" EnableEventValidation="false"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8" />
    <meta
        name="viewport"
        content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <link rel="icon" href="img/favicon.png" type="image/png" />
    <title>الدروس</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="css/bootstrap.css" />
    <link rel="stylesheet" href="css/flaticon.css" />
    <link rel="stylesheet" href="css/themify-icons.css" />
    <link rel="stylesheet" href="vendors/owl-carousel/owl.carousel.min.css" />
    <link rel="stylesheet" href="vendors/nice-select/css/nice-select.css" />
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.12.0/css/all.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.12.0/css/v4-shims.css">
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    <!-- main css -->
    <link rel="stylesheet" href="css/style.css" />
    <link rel="stylesheet" href="css/my.css" />
    <style>
    div.sticky {
      position: -webkit-sticky;
      position: sticky;
      top: 12%;
    }
    html {
        scroll-behavior: smooth;
    }
    ::-webkit-scrollbar {
      width: 10px;
    }
    ::-webkit-scrollbar-track {
      background: #f1f1f1; 
    }
    ::-webkit-scrollbar-thumb {
      background: #fdc632; 
    }
    ::-webkit-scrollbar-thumb:hover {
      background: #dbaa26; 
    }
    </style>
</head>
    
<body onload="dvProgress.style.display = 'none';">
    <form id="form1" runat="server">
        <div style="text-align: center; 
            position: fixed; z-index:999; top: 0; left: 0; right:0; bottom:0; background-color:black;
            width:100%; height:100%; font-size: small;"
            id="dvProgress" runat="server">
            <img src="images/load.gif" style=" padding-top:200px;" alt="Processing" />
        </div>
        <!--================ Start Header Menu Area =================-->
        <header class="header_area">
            <div class="main_menu">

                <nav class="navbar navbar-expand-lg navbar-light">
                    <div class="container">
                        <!-- Brand and toggle get grouped for better mobile display -->
                        <a class="navbar-brand logo_h" href="index.aspx">
                            <img src="img/logo.png" alt="" /></a>
                        <button
                            class="navbar-toggler"
                            type="button"
                            data-toggle="collapse"
                            data-target="#navbarSupportedContent"
                            aria-controls="navbarSupportedContent"
                            aria-expanded="false"
                            aria-label="Toggle navigation">
                            <span class="icon-bar"></span><span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button>
                        <!-- Collect the nav links, forms, and other content for toggling -->
                        <div
                            class="collapse navbar-collapse offset"
                            id="navbarSupportedContent">

                            <ul class="nav navbar-nav menu_nav ml-auto">
                                <li class="nav-item">
                                    <a class="nav-link" href="index.aspx">الرئيسية <i class="fa fa-home"></i></a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="lessons.aspx">الدروس <i class="fa fa-book"></i></a>
                                </li>
                                <li class="nav-item">
                                    <asp:LinkButton runat="server" CssClass="nav-link" OnClick="lesson_manager_Click">المدير <i class="fa fa-user-shield"></i></asp:LinkButton>
                                </li>
                                <li class="nav-item">
                                    <asp:LinkButton runat="server" CssClass="nav-link" OnClick="lessons_signout_Click">تسجيل خروج <i class="fa fa-sign-out-alt"></i></asp:LinkButton>
                                </li>
                            </ul>

                        </div>
                    </div>
                </nav>
            </div>
        </header>
        <!--================ End Header Menu Area =================-->

        <!--================ Start Home Banner Area =================-->
        <section class="home_banner_area">
            <div class="banner_inner">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="banner_content text-center">
                                <p class="text-uppercase">
                                    كن مستعد لتشاهد أول موقع يقدم المحتوى العلمي بهذه الطريقة
                                </p>
                                <h2 class="text-uppercase mt-4 mb-5">رحلة الألف ميل تبدأ بخطوة
                                </h2>
                                <div>
                                    <a href="#less" class="primary-btn mb-3 mb-sm-0">ابدأها الآن</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!--================ End Home Banner Area =================-->

        <!--================Blog Area =================-->
        <section class="blog_area section_gap" id="less">
            <div class="container">
                <div class="row text-right">
                    <div class="col-lg-4">
                        <div class="review-top blog_right_sidebar sticky">
                            <aside class="single_sidebar_widget search_widget">
                                <div class="input-group">
                                    <asp:TextBox runat="server" ID="lessons_search_tb" CssClass="form-control" placeholder="البحث عن درس" />
                                    <span class="input-group-btn">
                                        <asp:LinkButton runat="server" ID="lessons_search_button" CssClass="btn btn-default" type="button" OnClick="lessons_search_button_Click"><i class="ti-search"></i></asp:LinkButton>
                                    </span>
                                </div>
                                <!-- /input-group -->
                                <div class="br"></div>
                            </aside>
                            <aside class="single_sidebar_widget author_widget">
                                <img class="author_img rounded-circle" src="img/blog/student.png" alt="">
                                <h4><%=name %></h4>

                                <div class="blog_info text-right">
                                    <ul class="blog_meta list text-right">
                                        <li><a>آخر زيارة <%=date %><i class="ti-time"></i></a></li>
                                        <li><a>الدروس التي زرتها <%=vis %><i class="ti-book"></i></a></li>
                                        <li><a>الدروس التي أعجبتني <%=like %><i class="ti-thumb-up"></i></a></li>
                                    </ul>
                                </div>
                            </aside>
                        </div>
                    </div>
                    <div class="col-lg-8">
                        <div class="blog_left_sidebar">
                            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                <ContentTemplate>
                                    <%if (counter == 0)
                                        { %>
                                    <div class="alert alert-primary" role="alert">
                                        لا يوجد أي دروس تطابق البحث
                                    </div>
                                    <% }
                                        for (int i = 0; i < counter; i++)
                                        {   %>
                                    <article class="row blog_item">
                                        <div class="col-md-3">
                                            <div class="blog_info text-right">
                                                <ul class="blog_meta list text-right">
                                                    <li><a>آخر تحديث <%=lastupdate[i]%><i class="ti-pencil"></i></a></li>
                                                    <li><a>المشاهدات <%=views[i]%><i class="ti-eye"></i></a></li>
                                                    <li><a>الاعجابات <%=likes[i]%><i class="ti-thumb-up"></i></a></li>
                                                </ul>
                                            </div>
                                        </div>
                                        <div class="col-md-9">
                                            <div class="blog_post">
                                                <video style="max-height: 600px; width: 100%;" controls>
                                                    <source src="video/<%=vid[i]%>" type="video/mp4">
                                                    Your browser does not support HTML5 video.
                                                </video>
                                                <div class="blog_details">
                                                    <h2 dir="rtl"><%=title[i]%></h2>
                                                    <a href="lesson.aspx?lesson=<%=title[i]%>" class="blog_btn">الانتقال لصفحة الدرس</a>
                                                </div>
                                            </div>
                                        </div>
                                    </article>
                                    <hr style="border: 1px solid #b2becb;">
                                    <%} %>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="lessons_search_button" EventName="Click" />
                                </Triggers>
                            </asp:UpdatePanel>

                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!--================Blog Area =================-->

        <!--================ Start footer Area  =================-->
        <footer class="footer">
            <div class="container text-center">
                <div class="row" style="color: white">
                    <div class="col-sm-6">

                        <a href="index.aspx" style="width: 100%;">
                            <img src="img/logo2.png" style="margin-top: 20%;" />
                        </a>
                        <br />
                    </div>
                    <div class="col-sm-6">
                        <h4 style="color: white">الذهاب إلى</h4>
                        <p><a href="index.aspx" class="ftr">الرئيسية <i class="fa fa-home"></i></a></p>
                        <p><a href="lessons.aspx" class="ftr">الدروس <i class="fa fa-book"></i></a></p>
                        <p>
                            <asp:LinkButton runat="server" CssClass="ftr" OnClick="lesson_manager_Click">المدير <i class="fa fa-user-shield"></i></asp:LinkButton>
                        </p>
                        <p>
                            <asp:LinkButton runat="server" CssClass="ftr" OnClick="lessons_signout_Click">تسجيل خروج <i class="fa fa-sign-out-alt"></i></asp:LinkButton>
                        </p>
                    </div>
                </div>
            </div>
        </footer>
    </form>
    <!--================ End footer Area  =================-->

    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="js/jquery-3.2.1.min.js"></script>
    <script src="js/popper.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="vendors/nice-select/js/jquery.nice-select.min.js"></script>
    <script src="vendors/owl-carousel/owl.carousel.min.js"></script>
    <script src="js/owl-carousel-thumb.min.js"></script>
    <script src="js/jquery.ajaxchimp.min.js"></script>
    <script src="js/mail-script.js"></script>
    <!--gmaps Js-->
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCjCGmQ0Uq4exrzdcL6rvxywDDOvfAu6eE"></script>
    <script src="js/gmaps.min.js"></script>
    <script src="js/theme.js"></script>
</body>
</html>
