<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="manager.aspx.cs" Inherits="aspapp.manager" EnableEventValidation="false" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <!-- Required meta tags -->
    <meta charset="utf-8" />
    <meta
        name="viewport"
        content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <link rel="icon" href="img/favicon.png" type="image/png" />
    <title>Manager Page</title>
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
        <header class="header_area white-header">
            <div class="main_menu">
                <nav class="navbar navbar-expand-lg navbar-light">
                    <div class="container">
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
                        <div
                            class="collapse navbar-collapse offset"
                            id="navbarSupportedContent">
                            <ul class="nav navbar-nav menu_nav ml-auto">
                                <li class="nav-item">
                                    <a class="nav-link" href="index.aspx">الرئيسية <i class="fa fa-home"></i></a>
                                </li>
                                <li class="nav-item">
                                    <asp:LinkButton runat="server" CssClass="nav-link" OnClick="out_Click">الدروس <i class="fa fa-book"></i></asp:LinkButton>
                                </li>
                                <li class="nav-item">
                                    <asp:LinkButton runat="server" CssClass="nav-link" OnClick="out_Click">المدير <i class="fa fa-user-shield"></i></asp:LinkButton>
                                </li>
                                <li class="nav-item">
                                    <asp:LinkButton runat="server" CssClass="nav-link" OnClick="manager_sign_out_Click">تسجيل خروج <i class="fa fa-sign-out-alt"></i></asp:LinkButton>
                                </li>
                            </ul>
                        </div>
                    </div>
                </nav>
            </div>
        </header>
        <section class="banner_area">
            <div class="banner_inner d-flex align-items-center">
                <div class="overlay"></div>
                <div class="container">
                    <div class="row justify-content-center">
                        <div class="col-lg-6">
                            <div class="banner_content text-center">
                                <h2>Manager Page</h2>
                                <div class="page_link">
                                    <a href="index.aspx">Home</a>
                                    <a>manager</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <section class="course_details_area section_gap text-right">
            <div class="container">
                <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <div class="row">


                            <div class="col-lg-8 course_details_left">
                                <table class="table text-center" dir="rtl">
                                    <thead class="thead-light">
                                        <tr>
                                            <th scope="col">#</th>
                                            <th scope="col">الاسم</th>
                                            <th scope="col">كلمة المرور</th>
                                            <th scope="col">اخر زيارة</th>
                                            <th scope="col">الحالة</th>
                                            <th scope="col">التصريح</th>
                                            <th scope="col">الحذف</th>
                                            <th scope="col">التفعيل</th>
                                            <th scope="col">التعطيل</th>
                                        </tr>
                                    </thead>
                                    <tbody id="bdy" runat="server">
                                    </tbody>
                                </table>

                            </div>



                            <div class="col-lg-4 right-contents text-right">
                                <div class="sticky">
                                    <h2 class="title">إضافة مدرسين <i class="fa fa-plus-square"></i></h2>
                                    <%if (bad)
                                        {%>
                                    <div class="alert alert-warning alert-dismissible fade show" dir="rtl" role="alert">
                                      هذا الاسم موجود مسبقاً جرب اسماً آخر.
                                      <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                      </button>
                                    </div>
                                    <%  }
                                        if (shrt)
                                        {%>
                                    <div class="alert alert-warning alert-dismissible fade show" dir="rtl" role="alert">
                                      كلمة المرور قصيرة للغاية، يجب أن لا تقل عن 4 محارف
                                      <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                      </button>
                                    </div>
                                    <%  }
                                        shrt = false;
                                        if (dn)
                                        {%>
                                    <div class="alert alert-success alert-dismissible fade show" dir="rtl" role="alert">
                                      تم تسجيل حساب المدرس بنجاح ✔
                                      <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                      </button>
                                    </div>
                                    <%  }
                                        dn = false;%>
                                    <div class="row" dir="rtl">
                                        <div class="col-sm-6">
                                            <asp:TextBox runat="server" ID="admin_name" CssClass="form-control text-right" Style="width: 100%;" placeholder="ادخل اسم المدرس" />
                                        </div>
                                        <div class="col-sm-6">
                                            <asp:TextBox runat="server" ID="admin_pass" CssClass="form-control text-right" Style="width: 100%;" placeholder="ادخل كلمة المرور" />
                                        </div>
                                    </div>
                                    <br />
                                    <asp:LinkButton runat="server" ID="admin_add" Style="width: 100%;" OnClick="admin_add_Click" CssClass="btn btn-outline-success">إضافة المدرس <i class="fa fa-plus"></i></asp:LinkButton>


                                    <br />
                                    <br />
                                    <h2 class="title">التعديل السريع <i class="fa fa-edit"></i></h2>
                                    <div class="row">
                                        <div class="col-sm-5">
                                            <asp:LinkButton runat="server" ID="delete_user" Style="width: 100%;" OnClick="delete_user_Click" CssClass="btn btn-outline-danger">❌ حذف</asp:LinkButton>
                                        </div>
                                        <div class="col-sm-7">
                                            <asp:TextBox runat="server" ID="user_delete" CssClass="form-control text-right" Style="width: 100%;" placeholder="ادخل رقم مستخدم لحذفه" />
                                        </div>
                                    </div>
                                    <br />
                                    <div class="row">
                                        <div class="col-sm-5">
                                            <asp:LinkButton runat="server" ID="disable_user" Style="width: 100%;" OnClick="disable_user_Click" CssClass="btn btn-outline-secondary">⛔ تعطيل</asp:LinkButton>
                                        </div>
                                        <div class="col-sm-7">
                                            <asp:TextBox runat="server" ID="user_disable" CssClass="form-control text-right" Style="width: 100%;" placeholder="ادخل رقم مستخدم لتعطيله" />
                                        </div>
                                    </div>
                                    <br />
                                    <div class="row">
                                        <div class="col-sm-5">
                                            <asp:LinkButton runat="server" ID="enable_user" Style="width: 100%;" OnClick="enable_user_Click" CssClass="btn btn-outline-success">✔ تفعيل</asp:LinkButton>
                                        </div>
                                        <div class="col-sm-7">
                                            <asp:TextBox runat="server" ID="user_enable" CssClass="form-control text-right" Style="width: 100%;" placeholder="ادخل رقم مستخدم لتفعيله" />
                                        </div>
                                    </div>
                                </div>

                            </div>


                        </div>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="admin_add" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="delete_user" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="disable_user" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="enable_user" EventName="Click" />
                    </Triggers>
                </asp:UpdatePanel>

            </div>
        </section>

        <footer class="footer">
            <div class="container text-center">
                <div class="row" style="color: white">
                    <div class="col-sm-6">

                        <a href="index.aspx" style="width: 100%;">
                            <img src="img/logo2.png" style="margin-top: 20%;" /></a>
                        <br />
                    </div>
                    <div class="col-sm-6">
                        <h4 style="color: white">الذهاب إلى  </h4>
                        <p><a href="index.aspx" class="ftr">الرئيسية <i class="fa fa-home"></i></a></p>
                        <p>
                            <asp:LinkButton runat="server" CssClass="ftr" OnClick="out_Click">الدروس <i class="fa fa-book"></i></asp:LinkButton>
                        </p>
                        <p>
                            <asp:LinkButton runat="server" CssClass="ftr" OnClick="out_Click">المدير <i class="fa fa-user-shield"></i></asp:LinkButton>
                        </p>
                        <p>
                            <asp:LinkButton runat="server" CssClass="ftr" OnClick="manager_sign_out_Click"> تسجيل خروج <i class="fa fa-sign-out-alt"></i></asp:LinkButton>
                        </p>

                    </div>
                </div>
            </div>
        </footer>
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
