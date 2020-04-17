<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="aspapp.index" EnableEventValidation="false" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <!-- Required meta tags -->
    <meta charset="utf-8" />
    <meta
        name="viewport"
        content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <link rel="icon" href="img/favicon.png" type="image/png" />
    <title>Kid-Edu</title>
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
        .resp-container {
    position: relative;
    overflow: hidden;
    padding-top: 56.25%;
}
        .resp-iframe {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    border: 0;
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
        <div style="text-align: center; position: fixed; z-index: 999; top: 0; left: 0; right: 0; bottom: 0; background-color: black; width: 100%; height: 100%; font-size: small;"
            id="dvProgress" runat="server">
            <img src="images/load.gif" style="padding-top: 200px;" alt="Processing" />
        </div>
        <%
            HttpCookie cookie = HttpContext.Current.Request.Cookies["user"];

            HttpCookie cookie1 = HttpContext.Current.Request.Cookies["admin"];
            HttpCookie cookie2 = HttpContext.Current.Request.Cookies["manager"];

        %>
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

                                <%
                                    if (cookie == null && cookie1 == null && cookie2 == null)
                                    { %>
                                <li class="nav-item">
                                    <a class="nav-link" href="login.aspx" id="login">تسجيل دخول <i class="fa fa-unlock"></i></a>
                                </li>
                                <%}
                                    else if (cookie != null)
                                    {%>
                                <li class="nav-item">
                                    <a class="nav-link" href="lessons.aspx">الدروس <i class="fa fa-book"></i></a>
                                </li>
                                <li class="nav-item">
                                    <asp:LinkButton runat="server" CssClass="nav-link" OnClick="signout_Click" ID="signout">تسجيل خروج <i class="fa fa-sign-out-alt"></i></asp:LinkButton>
                                </li>
                                <%}
                                    else
                                    {%>
                                <li class="nav-item">
                                    <asp:LinkButton runat="server" CssClass="nav-link" OnClick="signout_Click">تسجيل خروج <i class="fa fa-sign-out-alt"></i></asp:LinkButton>
                                </li>
                                <li class="nav-item">
                                    <a href="login.aspx" class="nav-link">بدء الإدارة والتعديل <i class="fa fa-shield"></i></a>
                                </li>
                                <%} %>
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
                                    أفضل خدمة مجانية تعليمية للأطفال
                                </p>
                                <h2 class="text-uppercase mt-4 mb-5">سجل دخولك وابدأ التعلم مجاناً
                                </h2>
                                <div>
                                    <a href="login.aspx" class="primary-btn2 mb-3 mb-sm-0">ابدأ الآن</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!--================ End Home Banner Area =================-->

        <!--================ Start Feature Area =================-->
        <section class="feature_area section_gap_top text-center">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-5">
                        <div class="main_title">
                            <h2 class="mb-3">ميزات رائعة</h2>
                            <p>
                                Kid-Edu لمحة خاطفة على أهم ميزات 
                            </p>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-4 col-md-6">
                        <div class="single_feature">
                            <div class="icon"><span class="flaticon-student"></span></div>
                            <div class="desc">
                                <h4 class="mt-3 mb-2">ابداع بعد التعلم</h4>
                                <p>
                                    تقديم المنهج بطريقة في غاية السلاسة ستعزز ربط الافكار وتنمية "كيف أفكر" لدى المتعلم
                                </p>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-4 col-md-6">
                        <div class="single_feature">
                            <div class="icon"><span class="flaticon-book"></span></div>
                            <div class="desc">
                                <h4 class="mt-3 mb-2">موازنة تلخيص - شرح</h4>
                                <p>
                                    اختصار الاجزاء الغير مهمة والمقيتة وتسليط الضوء بشكل ممتع على الاجزاء الهامة ضمن الدرس
                                </p>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-4 col-md-6">
                        <div class="single_feature">
                            <div class="icon"><span class="flaticon-earth"></span></div>
                            <div class="desc">
                                <h4 class="mt-3 mb-2">سرعة التعلم</h4>
                                <p>
                                    بميزات التعلم المرح سيتستوعب الطالب كميات كبيرة من المعلومات في وقت وجيز
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!--================ End Feature Area =================-->
        <% string s = "التسجيل مجاني وسريع وغير معقد<br />لا تتردد بالتسجيل لدينا فهو سبيلك للتحصيل العلمي الاسرع على الاطلاق"; %>
        <!--================ Start Registration Area =================-->
        <div class="section_gap registration_area text-center">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-lg-12">
                        <div class="row clock_sec clockdiv" id="clockdiv">
                            <div class="col-lg-12">
                                <h1 class="mb-3">سجل الآن</h1>
                                <p>
                                    <%=s %>
                                </p>
                                <a href="signup.aspx" class="primary-btn mb-3 mb-sm-0">سجل الآن</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--================ End Registration Area =================-->
        <div class="testimonial_area section_gap text-center">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-5">
                        <div class="main_title">
                            <h2 class="mb-3">فلننظر ماذا لدينا</h2>
                            <p dir="rtl">
                                سنستعرض ما يمكننا القيام به والخصائص المتوفرة في هذا الموقع <i class="fa fa-smile-o"></i>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="resp-container" runat="server" id="vid">
                </div>
            </div>
        </div>
        <!--================ Start Testimonial Area =================-->
        <div class="testimonial_area section_gap text-center">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-5">
                        <div class="main_title">
                            <h2 class="mb-3">ماذا يقولون عنا؟</h2>
                            <p>
                                هذه بعض المقتطفات مما يقوله الطلاب حول هذا الموقع 
                            </p>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="testi_slider owl-carousel">
                        <div class="testi_item">
                            <div class="row">
                                <div class="col-lg-4 col-md-6">
                                    <img src="img/testimonials/t1.jpg" alt="" />
                                </div>
                                <div class="col-lg-8">
                                    <div class="testi_text">
                                        <h4>يمان النشواتي</h4>
                                        <p>
                                            من اجمل وابسط المواقع التعليمية! اتمنى من الطلاب الاستفادة الكبيرة 
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="testi_item">
                            <div class="row">
                                <div class="col-lg-4 col-md-6">
                                    <img src="img/testimonials/t2.jpg" alt="" />
                                </div>
                                <div class="col-lg-8">
                                    <div class="testi_text">
                                        <h4>محمد عارف الشامي</h4>
                                        <p>
                                            ساعة من التعلم على هذا الموقع تعدل 32 سنة تعلّم بالطريقة التقليدية
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="testi_item">
                            <div class="row">
                                <div class="col-lg-4 col-md-6">
                                    <img src="img/testimonials/t3.jpg" alt="" />
                                </div>
                                <div class="col-lg-8">
                                    <div class="testi_text">
                                        <h4>المصطفى نمّوز</h4>
                                        <p>
                                            شكرا على أتاحة التعليم من راحة منزلي 
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="testi_item">
                            <div class="row">
                                <div class="col-lg-4 col-md-6">
                                    <img src="img/testimonials/t4.jpg" alt="" />
                                </div>
                                <div class="col-lg-8">
                                    <div class="testi_text">
                                        <h4>سامر دك الباب</h4>
                                        <p>
                                            موقع أتاح لأولادي التعلم من المنزل دون الذهاب الى المدرسة. شكرا لكم
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--================ End Testimonial Area =================-->

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
                        <p>
                            <asp:LinkButton runat="server" CssClass="ftr" OnClick="lesson_Click">الدروس <i class="fa fa-book"></i></asp:LinkButton>
                        </p>
                        <p>
                            <asp:LinkButton runat="server" CssClass="ftr" OnClick="index_admin_Click">المدير <i class="fa fa-user-shield"></i></asp:LinkButton>
                        </p>
                    </div>
                </div>
                <p style="text-align:center; font-size:large; color:#ffc952;">Producted with <font color="red">❤</font> by</p> 
                <div class="row">
                    <div class="col-sm-4" ><a href="https://fb.com/m.aaref.sh" target="_blank" style="color:wheat; text-align:center;">Aaref</a></div>
                    <div class="col-sm-4" ><a href="https://fb.com/mnamoz" target="_blank" style="color:wheat; text-align:center;">Mustafa</a></div>
                    <div class="col-sm-4" ><a href="https://fb.com/Y.Nashawati" target="_blank" style="color:wheat; text-align:center;">Yaman</a></div>
                </div>
                <br />
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
