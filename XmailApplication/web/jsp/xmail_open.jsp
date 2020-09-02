<%@page import="java.text.*"%>
<%@include file="config.jsp" %>
<%@page import="java.text.DateFormat"%>
<%
    HttpSession hs = request.getSession();
    if(hs.getAttribute("users_unique_id") == null) {
        response.sendRedirect("../");
    }
    PrintWriter pr = response.getWriter();
    String users_unique_id = (String)hs.getAttribute("users_unique_id");
    String User_account = "User_account";
    try {
        Class.forName(db_driver);
        Connection con = DriverManager.getConnection(db_url, db_username, db_password);
        db_sql = "SELECT users_xmail_id FROM users WHERE users_unique_id=?";
        PreparedStatement ps = con.prepareStatement(db_sql);
        ps.setString(1, users_unique_id);
        ResultSet rs = ps.executeQuery();
        while(rs.next()) {
            User_account = rs.getString("users_xmail_id");
        }
    } catch(Exception ex) {
        pr.println(ex.getMessage().toString());
    }
%>
<%    String users_xmails_unique_id = null;
    String users_xmail_id = null;
    String users_xmails_sender_users_unique_id = null;
    String users_xmails_user_subject_xmail = null;
    String users_xmails_user_mail_body = null;
    String Sent_Date = null;
    try {
        String opened_xmail_id = request.getParameter("xmail_user");
        String getPageName = request.getParameter("xmail_page");
        Class.forName(db_driver);
        Connection con = DriverManager.getConnection(db_url, db_username, db_password);
        if(getPageName.equalsIgnoreCase("sent")){
            db_sql = "SELECT users_xmails.users_xmails_unique_id, users.users_xmail_id, "
                + "users_xmails.users_xmails_recievers_users_unique_id, users_xmails.users_xmails_user_subject_xmail, "
                + "users_xmails.users_xmails_user_mail_body, users_xmails.users_xmails_user_sent_date FROM users_xmails JOIN users ON "
                + "users_xmails.users_xmails_recievers_users_unique_id = users.users_unique_id WHERE "
                + "users_xmails_unique_id=?";
        } else if(getPageName.equalsIgnoreCase("inbox")) {
            db_sql = "SELECT users_xmails.users_xmails_unique_id, users.users_xmail_id, users_xmails.users_xmails_sender_users_unique_id, "
                + "users_xmails.users_xmails_user_subject_xmail, "
                + "users_xmails.users_xmails_user_mail_body, users_xmails.users_xmails_user_sent_date FROM users_xmails JOIN users ON "
                + "users_xmails.users_xmails_sender_users_unique_id = users.users_unique_id WHERE "
                + "users_xmails_unique_id=?";
        }
        PreparedStatement pst = con.prepareStatement(db_sql);
        pst.setString(1, opened_xmail_id);
        ResultSet rs = pst.executeQuery();
        while(rs.next()) {
            users_xmails_unique_id = rs.getString("users_xmails_unique_id");
            users_xmail_id = rs.getString("users_xmail_id");
            users_xmails_user_subject_xmail = rs.getString("users_xmails_user_subject_xmail");
            users_xmails_user_mail_body = rs.getString("users_xmails_user_mail_body");
            Sent_Date = rs.getString("users_xmails_user_sent_date");
        }
        pst.close();
        rs.close();
        con.close();
    } catch(Exception ex) {
        pr.println(ex.getMessage().toString());
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Xmail | <%=users_xmails_user_subject_xmail%></title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="icon" href="../images/xmail_title_photo.png" type="image/x-icon">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>
        <style>
            .main_body {
                padding-left: 1%;
                margin-top: 1%;
                padding-right: 2%;
                position: absolute;
                float: left;
                width: 100%;
                height: 100%;
                background-color: white;
                background-repeat: no-repeat;
                background-size: 100%;
            }
            .hrline {
                width: 100%;
                border: 1px solid #e85600;
            }
            .try-btn {
                background-color: transparent;
                color: #e85600;
                border: 1px solid #e85600;
                font-weight: bold;
                font-size: 1.2vw;
            }
            .try-btn:hover {
                background-color: #e85600;
                color: white;
            }
            .fa-icon {
                color: #e85600!important;
            }
            .logo-navbar-brand {
                padding-left: 45%;
            }
            .opened-intro {
                width: 100%;
                padding-left: 7%;
                padding-right: 7%;
                margin-bottom: 1%;
            }
            .opened-intro li {
                list-style: none;
                display: inline-block;
            }
            .li_1 {
                width: 6%;
                position: relative;
                bottom: 22%;
                height: 78%;
            }
            .responsive {
                width: 70%;
                border-radius: 50%;
            }
            .li_2 {
                width:80%
            }
            .hrline {
                margin-top: 0%;
                width: 87%;
                border: 1px solid #e85600;
            }
            .content {
                width: 100%;
                height: auto;
                padding-left: 7%;
                padding-right: 7%;
            }
            .subject {
                width: 100%;
                padding-left: 7%;
                padding-right: 7%;
            }
            .my_account {
                text-decoration: none;
                color: #e85600;
            }
            .my_account:hover {
                text-decoration: none;
                color: #e85612;
            }
                
            @media only screen and (max-width: 600px) {
                .main_body {
                    margin-top:2%;
                    float: left;
                    position: absolute;
                    width: 100%;
                    height: 100%;
                    background-color: white;
                    background-repeat: repeat;
                    background-size: 100%;
                }
                .try-btn {
                    background-color: transparent;
                    color: #e85600;
                    border: 1px solid #e85600;
                    font-weight: bold;
                    font-size: 3vw;
                }
                .try-btn:hover {
                    background-color: #e85600;
                    color: white;
                }
                .fa-icon {
                    color: #e85600!important;
                }
                .logo-navbar-brand {
                    padding-left: 35%;
                }
                .opened-intro {
                    width: 100%;
                    padding-left: 7%;
                    padding-right: 7%;
                    margin-bottom: 1%;
                }
                .opened-intro li {
                    list-style: none;
                    display: inline-block;
                }
                .li_1 {
                    width: 9%;
                    position: relative;
                    bottom: 22%;
                    height: 150%;
                }
                .responsive {
                    width: 150%;
                    border-radius: 50%;
                }
                .li_2 {
                    padding-left: 6%;
                }
                .hrline {
                    margin-top: 0%;
                    width: 87%;
                    border: 1px solid #e85600;
                }
                .content {
                    width: 100%;
                    height: auto;
                    padding-left: 8%;
                    padding-right: 6%;
                }
                .subject {
                    width: 100%;
                    padding-left: 7%;
                    padding-right: 7%;
                }
                .my_account {
                    text-decoration: none;
                    color: #e85600;
                }
                .my_account:hover {
                    text-decoration: none;
                    color: #e85612;
                }
            }
        </style>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-light shadow-sm">
            <a class="navbar-brand" href="#"><img src="../images/xmail_photo_200x200.png"/></a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarTogglerDemo03" aria-controls="navbarTogglerDemo03" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarTogglerDemo03">
                <ul class="navbar-nav mr-auto mt-2 mt-lg-0">
                    <li class="nav-item">
                        <a class="nav-link" href="./user_composer.jsp">Compose</a>
                    </li>
                    <li class="nav-item active">
                        <a class="nav-link" href="./user_home.jsp">Inbox <span class="sr-only">(current)</span></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="./user_draft.jsp">Draft</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="./user_sent.jsp">Sent</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="./user_trash.jsp">Trash</a>
                    </li>
                    <!--<li class="nav-item">
                        <a class="nav-link disabled" href="#" tabindex="-1" aria-disabled="true">Disabled</a>
                    </li>-->
                </ul>
                <form class="form-inline my-2 my-lg-0">
                    <a class="my_account" href="#"><%=User_account%></a>&emsp;
                    <!--<input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">-->
                    <a class="btn btn-outline try-btn" href="./signout.jsp">Sign Out</a>&emsp;
                    <!--<a class="btn btn-outline try-btn" href="signin.html">Sign In</a>-->
                </form>
            </div>
        </nav>
        <div class="main_body">
            <div class="main-headings">
                <div class="row">
                    <ul class="opened-intro">
                        <li class="li_1">
                            <img class="responsive" src="../images/img_avatar.png"/>
                        </li>
                        <li class="li_2">
                            <h6> <%=users_xmail_id%> </h6>
                            <p><i> <%=Sent_Date%> </i></p>
                        </li>
                    </ul>
                    <div class="subject">
                        <h5><%=users_xmails_user_subject_xmail%></h5>
                    </div>
                    <hr class="hrline">
                    <div class="content">
                            <%=users_xmails_user_mail_body%>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>