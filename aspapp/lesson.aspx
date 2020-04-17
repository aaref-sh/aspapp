<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="lesson.aspx.cs" Inherits="aspapp.corce" EnableEventValidation="false" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <!-- Required meta tags -->
    <meta charset="utf-8" />
    <meta
        name="viewport"
        content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <link rel="icon" href="img/favicon.png" type="image/png" />
    <title><%=title%></title>
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
        <header class="header_area white-header">
            <div class="main_menu">
                <nav class="navbar navbar-expand-lg navbar-light">
                    <div class="container">
                        <!-- Brand and toggle get grouped for better mobile display -->
                        <a class="navbar-brand" href="index.aspx">
                            <img class="logo-2" src="img/logo2.png" alt="" />
                        </a>
                        <button
                            class="navbar-toggler"
                            type="button"
                            data-toggle="collapse"
                            data-target="#navbarSupportedContent"
                            aria-controls="navbarSupportedContent"
                            aria-expanded="false"
                            aria-label="Toggle navigation">
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
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
                                    <asp:LinkButton runat="server" CssClass="nav-link" OnClick="lesson_signout_Click">تسجيل خروج <i class="fa fa-sign-out-alt"></i></asp:LinkButton>
                                </li>
                            </ul>
                        </div>
                    </div>
                </nav>
            </div>
        </header>
        <!--================ End Header Menu Area =================-->

        <!--================Home Banner Area =================-->
        <section class="banner_area">
            <div class="banner_inner d-flex align-items-center">
                <div class="overlay"></div>
                <div class="container">
                    <div class="row justify-content-center">
                        <div class="col-lg-6">
                            <div class="banner_content text-center">
                                <h2><%=title%></h2>
                                <div class="page_link">
                                    <a href="index.aspx">الرئيسية</a>
                                    <a href="lessons.aspx">الدروس</a>
                                    <a>/  <%=title%></a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!--================End Home Banner Area =================-->

        <!--================ Start Course Details Area =================-->
        <section class="course_details_area section_gap text-right">
            <div class="container">
                <%if (has_lesson)
                    { %>
                <div class="row">
                    <div class="col-lg-8 course_details_left" dir="rtl">
                        <video controls style="width: 100%; max-height: 600px;">
                            <source src="video/<%=vid%>" type="video/mp4">
                            Your browser does not support HTML5 video.
                        </video>

                        <div class="content_wrapper">
                            <%if (dis != "")
                                { %>
                            <h4 class="title">عرض الشرائح <i class="fa fa-file-powerpoint-o"></i></h4>
                            <div class="content">
                                <%=dis%>
                            </div>
                            <%} %>
                            <div class="section-top-border">
                                <h3 class="title_color">صور الدرس <i class="fa fa-images"></i></h3>
                                <div class="row gallery-item">
                                    <%for (int i = 0; i < pics; i++)
                                        { %>
                                    <div class="col-md-4">
                                        <a href="pics/<%=pic[i] %>" class="img-gal">
                                            <div class="single-gallery-image" style="background: url(pics/<%=pic[i]%>);"></div>
                                        </a>
                                    </div>
                                    <%} %>
                                </div>
                            </div>
                            <%if (flash != "0")
                                { %>
                            <h4 class="title">العب لتتعلم <i class="fa fa-gamepad"></i></h4>
                            <div class="content">
                                <object height="400">
                                    <embed src="swf/<%=flash %>" style="width: 100%; height: 400px;" /></object>
                            </div>
                            <%} %>

                            <%if (quis != "") %>
                            <h4 class="title">أختبر نفسي <i class="fa fa-edit"></i></h4>
                            <div style="width: 100%;">
                                <%=quis %>
                            </div>
                        </div>
                    </div>


                    <div class="col-lg-4 right-contents text-right">
                        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <ul>
                                    <li>
                                        <div class="justify-content-between d-flex" style="height: 25px;">
                                            <p><%=lastupdate%></p>
                                            <span class="or">آخر تحديث <i class="fas fa-pencil-alt"></i></span>
                                        </div>
                                    </li>
                                    <li>
                                        <div class="justify-content-between d-flex" style="height: 25px;">
                                            <p><%=views%></p>
                                            <span class="or">عدد مشاهدات الدرس <i class="fas fa-eye"></i></span>
                                        </div>
                                    </li>
                                    <li>
                                        <div class="justify-content-between d-flex" style="height: 25px;">
                                            <p><%=likes%></p>
                                            <span class="or">الإعجابات <i class="fa fa-thumbs-up"></i></span>
                                        </div>
                                    </li>
                                </ul>


                                <asp:LinkButton runat="server" ID="lesson_like" OnClick="lesson_like_Click" CssClass="primary-btn2 text-uppercase enroll rounded-0 text-blue"> <i class="fa fa-thumbs-up"></i> أعجبني هذا الدرس</asp:LinkButton>

                                <h4 class="title">الاقتراحات <i class="fas fa-lightbulb"></i></h4>
                                <div class="content">

                                    <div class="feedeback">
                                        <h5>هل ترى خطأ ما؟ أخبرنا به</h5>
                                        <asp:TextBox runat="server" ID="feedback_textbox" Style="direction: rtl;" TextMode="multiline" CssClass="form-control" cols="10" Rows="10" MaxLength="500" />
                                        <div class="mt-6">
                                            <asp:LinkButton runat="server" ID="feedback" OnClick="send_feedback_Click" CssClass="primary-btn2 text-right rounded-0 text-blue">ارسال</asp:LinkButton>
                                        </div>
                                    </div>
                                    <h4 class="title">دروس قد تهمّك  <i class="fa fa-info-circle"></i></h4>
                                    <%for (int i = 0; i < see_lessons; i++)
                                        { %>
                                    <div id="accordion" dir="rtl">
                                        <div class="card">
                                            <div class="card-header text-center">
                                                <a class="card-link" data-toggle="collapse" href="#collapseOne">الدرس <%=i+1 %> | <%=see_title[i] %></a>
                                            </div>
                                            <div id="collapseOne" class="collapse" data-parent="#accordion">
                                                <div class="card-body">
                                                    <a href="lesson.aspx?lesson=<%=see_title[i]%>" class="card-link">عرض الدرس</a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <br />
                                    <%} %>
                                </div>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="feedback" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="lesson_like" EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
                </div>
                <%}
                    else
                    {%>
                <div class="alert alert-primary" role="alert">
                    رابط درس غير صالح <a href="lessons.aspx" class="alert-link">العودة لصفحة الدروس</a>
                </div>
                <% }%>
            </div>
        </section>
        <!--================ End Course Details Area =================-->

        <!--================ Start footer Area  =================-->
        <footer class="footer">
            <div class="container text-center">
                <div class="row" style="color: white">
                    <div class="col-sm-6">

                        <a href="index.aspx" style="width: 100%;">
                            <img src="img/logo2.png" style="margin-top: 20%;" /></a>
                        <br />
                    </div>
                    <div class="col-sm-6">
                        <h4 style="color: white">الذهاب إلى</h4>
                        <p><a href="index.aspx" class="ftr">الرئيسية <i class="fa fa-home"></i></a></p>
                        <p><a href="lessons.aspx" class="ftr">الدروس <i class="fa fa-book"></i></a></p>
                        <p>
                            <asp:LinkButton runat="server" CssClass="ftr" OnClick="lesson_signout_Click">تسجيل خروج <i class="fa fa-sign-out-alt"></i></asp:LinkButton>
                        </p>
                    </div>
                </div>
            </div>
        </footer>
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

    </form>
</body>
</html>
