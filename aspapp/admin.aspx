<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="admin.aspx.cs" Inherits="aspapp.admin" EnableEventValidation="false" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <!-- Required meta tags -->
    <meta charset="utf-8" />
    <meta
        name="viewport"
        content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <link rel="icon" href="img/favicon.png" type="image/png" />
    <title>Teacher Page</title>
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
                                    <asp:LinkButton runat="server" CssClass="nav-link" OnClick="lessons_Click">الدروس <i class="fa fa-book"></i></asp:LinkButton>
                                </li>
                                <li class="nav-item">
                                    <asp:LinkButton runat="server" CssClass="nav-link" OnClick="admin_sign_out_Click">تسجيل خروج <i class="fa fa-sign-out-alt"></i></asp:LinkButton>
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
                                <h2>Teacher Page</h2>
                                <div class="page_link">
                                    <a href="index.aspx">Home</a>
                                    <a>Teacher</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <section class="course_details_area section_gap text-right">
            <div class="container">
                
                        <div class="row">


                            <div class="col-lg-8 course_details_left">

                                <%if (done)
                                    { %>
                                <div class="alert alert-<%=status%> alert-dismissible fade show" role="alert">
                                    <strong><%=message%> </strong>
                                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <%}
                                    done = false;%>
                                <nav>
                                    <div class="nav nav-tabs justify-content-end" id="nav-tab" role="tablist">
                                        <a class="nav-item nav-link<%if (tab == 3)
                                            { %> active<%} %>"
                                            id="nav-del-tab" data-toggle="tab" href="#nav-del" role="tab" aria-controls="nav-del" aria-selected="false">
                                            <h4>حذف درس <i class="fa fa-trash-alt"></i></h4>
                                        </a>
                                        <a class="nav-item nav-link<%if (tab == 2)
                                            { %> active<%} %>"
                                            id="nav-edit-tab" data-toggle="tab" href="#nav-edit" role="tab" aria-controls="nav-edit" aria-selected="false">
                                            <h4>تعديل درس <i class="fa fa-edit"></i></h4>
                                        </a>
                                        <a class="nav-item nav-link<%if (tab != 2 && tab != 3)
                                            { %> active<%} %>"
                                            id="nav-add-tab" data-toggle="tab" href="#nav-add" role="tab" aria-controls="nav-add" aria-selected="true">
                                            <h4>إضافة درس <i class="fa fa-plus-square"></i></h4>
                                        </a>
                                    </div>
                                </nav>
                                <div class="tab-content" id="nav-tabContent">
                                    <div class="tab-pane fade<%if (tab != 2 && tab != 3)
                                        { %> show active<%} %>"
                                        id="nav-add" role="tabpanel" aria-labelledby="nav-add-tab">
                                        <div class="content_wrapper">
                                            <div class="content">
                                                <br>
                                                <h4>اكتب عنوان الدرس</h4>
                                                <asp:TextBox runat="server" dir="rtl" ID="add_title" CssClass="form-control text-right" placeholder="اختر عنواناً موجز ومعبر" />
                                                <br>
                                                <h4>اختر ملف الفيديو </h4>
                                                <p>mp4 احرص على أن يكون امتداد الملف</p>
                                                <div class="custom-file text-left">
                                                    <asp:FileUpload runat="server" ID="add_vid" CssClass="custom-file-input" accept="video/mp4" />
                                                    <label class="custom-file-label" for="addvid">تحميل الفيديو</label>
                                                </div>
                                                <br>
                                                <br>
                                                <h4>اختر ملف اللعبة </h4>
                                                <p>SWF احرص على أن يكون امتداد الملف</p>
                                                <div class="custom-file text-left">
                                                    <asp:FileUpload runat="server" ID="add_flash" CssClass="custom-file-input" accept=".swf" />
                                                    <label class="custom-file-label" for="addflash">تحميل ملف اللعبة</label>
                                                </div>
                                                <br>
                                                <br>
                                                <h4>اختر الملف النصي لعرض الشرائح</h4>
                                                <p>TXT يجب ان يكون النص صرف بملف</p>
                                                <div class="custom-file text-left">
                                                    <asp:FileUpload runat="server" ID="add_text" CssClass="custom-file-input" accept="text/plain" />
                                                    <label class="custom-file-label" for="addtxt">تحميل الملف النصي</label>
                                                </div>
                                                <br>
                                                <br>
                                                <h4>اختر صور الدرس</h4>
                                                <p>اختر الصور التي يتم عرضها في صفحة الدرس</p>
                                                <div class="custom-file text-left">
                                                    <asp:FileUpload runat="server" ID="add_Images" AllowMultiple="true" CssClass="custom-file-input" accept="image/*" />
                                                    <label class="custom-file-label" for="addimg">تحميل الصور - 20 صوة كحد أقصى</label>
                                                </div>
                                                <br>
                                                <h4>:أدخل رابط تضمين اسئلة الدرس</h4>
                                                <asp:TextBox runat="server" ID="add_quistion" CssClass="form-control text-right" placeholder="ادخل رابطة اسئلة الدرس" />
                                                <br />
                                                <br />
                                                <asp:LinkButton runat="server" OnClick="upload_Click" CssClass="btn btn-outline-primary">رفع الملفات <i class ="fa fa-upload"></i></asp:LinkButton>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tab-pane fade<%if (tab == 3)
                                        { %> show active<%} %>"
                                        id="nav-del" role="tabpanel" aria-labelledby="nav-del-tab">
                                        <br>
                                        <h4>حدد عنوان الدرس للحذف</h4>
                                        <div class="row">
                                            <div class="col-sm-3">
                                                <asp:LinkButton runat="server" Style="width: 100%;" OnClick="lesson_delete_Click" CssClass="btn btn-outline-danger">❌ حذف</asp:LinkButton>
                                            </div>
                                            <div class="col-sm-9">
                                                <asp:TextBox runat="server" dir="rtl" ID="title_lesson_delete" CssClass="form-control text-right" Style="width: 100%;" placeholder="اختر عنوان الدرس الذي تريد حذفه" />
                                            </div>
                                        </div>

                                    </div>
                                    <div class="tab-pane fade<%if (tab == 2)
                                        { %> show active<%} %>"
                                        id="nav-edit" role="tabpanel" aria-labelledby="nav-edit-tab">
                                        <div class="content_wrapper">
                                            <div class="content">
                                                <br>
                                                <h4>حدد عنوان الدرس للتعديل</h4>
                                                <asp:TextBox runat="server" dir="rtl" ID="edit_title" CssClass="form-control text-right" />
                                                <br>
                                                <h4>اختر ملف الفيديو الجديد</h4>
                                                <p>mp4 احرص على أن يكون امتداد الملف</p>
                                                <div class="custom-file text-left">
                                                    <asp:FileUpload runat="server" ID="edit_vid" CssClass="custom-file-input" accept="video/mp4" />
                                                    <label class="custom-file-label" for="addvid">تحميل الفيديو</label>
                                                </div>
                                                <br>
                                                <br>
                                                <h4>اختر ملف اللعبة الجديد </h4>
                                                <p>SWF احرص على أن يكون امتداد الملف</p>
                                                <div class="custom-file text-left">
                                                    <asp:FileUpload runat="server" ID="edit_flash" CssClass="custom-file-input" accept=".swf" />
                                                    <label class="custom-file-label" for="edit_flash">تحميل ملف اللعبة</label>
                                                </div>
                                                <br>
                                                <br>
                                                <h4>اختر الملف النصي لعرض الشرائح الجديد</h4>
                                                <p>TXT يجب ان يكون النص صرف بملف</p>
                                                <div class="custom-file text-left">
                                                    <asp:FileUpload runat="server" ID="edit_txt" CssClass="custom-file-input" accept="text/plain" />
                                                    <label class="custom-file-label" for="edit_txt">تحميل الملف النصي</label>
                                                </div>
                                                <br>
                                                <br>
                                                <h4>اختر صور الدرس الجدد</h4>
                                                <p>اختر الصور التي يتم عرضها في صفحة الدرس</p>
                                                <div class="custom-file text-left">
                                                    <asp:FileUpload runat="server" ID="edit_image" CssClass="custom-file-input" AllowMultiple="true" accept="image/*" />
                                                    <label class="custom-file-label" for="addimg">تحميل الصور</label>
                                                </div>
                                                <br>
                                                <h4>:ادخل رابط الاسئلة الجديدة</h4>
                                                <asp:TextBox runat="server" ID="edit_quistion" CssClass="form-control text-right" placeholder="ادخل رابط الاسئلة الجديدة" />
                                                <br>
                                                <br>
                                                <asp:LinkButton runat="server" OnClick="edit_Click" CssClass="btn btn-outline-primary">تحديث <i class ="fa fa-sync-alt"></i></asp:LinkButton>

                                                <br>
                                                <br>

                                                <div class="alert alert-primary" role="alert">لست مضطرا لاختيار ملفات للحقول التي لا ترغب بتعديلها ℹ</div>

                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </div>



                            <div class="col-lg-4 right-contents text-right">

                                <ul>
                                    <li>
                                        <a class="justify-content-between d-flex" style="max-height: 25px;">
                                            <p><%=lastv %></p>
                                            <span class="or">أخر زيارة للصفحة <i class="fa fa-clock"></i></span>
                                        </a>
                                    </li>
                                    <li>
                                        <div class="justify-content-between d-flex" style="max-height: 25px;">
                                            <p><%=lessons%></p>
                                            <span class="or">عدد الدروس في الموقع <i class="fas fa-book"></i></span>
                                        </div>
                                    </li>
                                    <li>
                                        <div class="justify-content-between d-flex" style="height: 25px;">
                                            <p><%=students %></p>
                                            <span class="or">عدد الطلاب المسجلين  <i class="fa fa-user-graduate"></i></span>
                                        </div>
                                    </li>
                                </ul>
                                <div id="accordion" dir="rtl">
                                    <div class="card text-center">
                                        <div class="card-header">
                                            <a class="card-link" data-toggle="collapse" href="#collapseOne" style="height: 100%; width: 100%;">عناوين الدروس المسجلة
                                            </a>
                                        </div>
                                        <div id="collapseOne" class="collapse show" data-parent="#accordion">
                                            <div class="card-body">
                                                <%=all %>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <a href="index.aspx" class="primary-btn2 text-uppercase enroll rounded-0 text-blue">الخروج للصفحة الرئيسية <i class="fa fa-sign-out-alt"></i></a>
                                <h4 class="title">الاقتراحات <i class="fas fa-lightbulb"></i></h4>

                                <br />
                                <div id="sug" runat="server">
                                </div>
                            </div>
                        </div>
                   
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
                            <asp:LinkButton runat="server" CssClass="ftr" OnClick="lessons_Click">الدروس <i class="fa fa-book"></i></asp:LinkButton>
                        </p>
                        <p><a href="admin.aspx" class="ftr">المدير <i class="fa fa-user-shield"></i></a></p>
                        <p>
                            <asp:LinkButton runat="server" CssClass="ftr" OnClick="admin_sign_out_Click"> تسجيل خروج <i class="fa fa-sign-out-alt"></i></asp:LinkButton>
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
