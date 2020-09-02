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
    String users_xmails_user_subject_xmail = "";
    String users_xmails_user_mail_body = "";
    String opened_xmail_id = null;
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
    if(request.getParameter("xmail_page") != null) {
        opened_xmail_id = request.getParameter("xmail_user");
        String getPageName = request.getParameter("xmail_page");
        try {
            Class.forName(db_driver);
            Connection con = DriverManager.getConnection(db_url, db_username, db_password);
            db_sql = "SELECT users_xmails.users_xmails_unique_id, users.users_xmail_id, "
                    + "users_xmails.users_xmails_recievers_users_unique_id, users_xmails.users_xmails_user_subject_xmail, "
                    + "users_xmails.users_xmails_user_mail_body, users_xmails.users_xmails_user_sent_date FROM users_xmails JOIN users ON "
                    + "users_xmails.users_xmails_recievers_users_unique_id = users.users_unique_id WHERE "
                    + "users_xmails_unique_id=?";
            PreparedStatement pst = con.prepareStatement(db_sql);
            pst.setString(1, opened_xmail_id);
            ResultSet rs = pst.executeQuery();
            while(rs.next()) {
                users_xmails_user_subject_xmail = rs.getString("users_xmails_user_subject_xmail");
                users_xmails_user_mail_body = rs.getString("users_xmails_user_mail_body");
            }
            pst.close();
            rs.close();
            con.close();
        } catch(Exception ex) {
            pr.println(ex.getMessage().toString());
        }
    }
    System.out.println("opened_xmail_id: "+opened_xmail_id);
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Xmail | Compose</title>
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
            /*multi email input*/
            .multipleInput-container {
                 border:1px #ccc solid;
                 padding:1px;
                 padding-bottom:0;
                 cursor:text;
                 font-size:13px;
                 width:100%;
                 height: 50px;
                 overflow: auto;
                 background-color: white;
                border-radius:3px;
            }

            .multipleInput-container input {
                 font-size:13px;
                 /*clear:both;*/
                 width:150px;
                 height:24px;
                 border:0;
                 margin-bottom:1px;
                 outline: none
            }

            .multipleInput-container ul {
                 list-style-type: none;
                 padding-left: 0px !important;
            }

            li.multipleInput-email {
                 float:left;
                 margin-right:2px;
                 margin-bottom:1px;
                 border:1px #BBD8FB solid;
                 padding:2px;
                 background:#F3F7FD;
            }

            .multipleInput-close {
                 width:16px;
                 height:16px;
                 background:url('../images/close_1.png') no-repeat;
                 display:block;
                 float:right;
                 margin:0 3px;
            }
            .email_search{
              width: 100% !important;
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
                .form-vertical {
                    padding: 2%;
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
                    <li class="nav-item active">
                        <a class="nav-link" href="./user_composer.jsp">Compose <span class="sr-only">(current)</span></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="./user_home.jsp">Inbox</a>
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
                    <div class="col-md-8">
                        <form class="form-vertical" method="POST" action="./user_composer.jsp">
                            <input type="text" name="recipient_email" class="form-control" placeholder="To: " required/><br>
                            <input type="text" name="subject" class="form-control" placeholder="Subject: " value="<%=users_xmails_user_subject_xmail%>"/><br>
                            <textarea name="message" class="form-control" cols="20" rows="10" placeholder="Message: "><%=users_xmails_user_mail_body%></textarea><br>
                            <input type="submit" name="send" class="btn btn-outline try-btn" value="Send"/>&nbsp;
                            <input type="submit" name="draft" class="btn btn-outline try-btn" value="Save as Draft"/>&nbsp;
                            <input type="reset" name="reset" class="btn btn-outline btn-light" value="Reset"/>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
<%
    if(request.getParameter("send") != null) {
        String recipient_email = request.getParameter("recipient_email");
        String subject = request.getParameter("subject");
        String message = request.getParameter("message");
        String[] elements = recipient_email.split(",");
        try {
            Class.forName(db_driver);
            Connection con = DriverManager.getConnection(db_url, db_username, db_password);
            for (String element : elements) {
                UUID uniqueKey = UUID.randomUUID();
                String uniquekey = uniqueKey.toString();
                String users_xmails_unique_id = "xmail_"+uniquekey;
                System.out.println("users_xmails_unique Key 1 : " + users_xmails_unique_id);
                String trimmedrecipient_email = element.trim();
                System.out.println("trimmedrecipient_email : " + trimmedrecipient_email);
                db_sql = "SELECT users_unique_id FROM users WHERE users_xmail_id=? AND users_account_block_status=0 "
                        + "AND users_account_delete_status=0";
                PreparedStatement pst = con.prepareStatement(db_sql);
                pst.setString(1, trimmedrecipient_email);
                ResultSet rs = pst.executeQuery();
                System.out.println("users_xmails_unique Key 2 : " + users_xmails_unique_id);
                System.out.println("opened_xmail_id 89 : " + opened_xmail_id);
                if(rs.next()){
                    if(opened_xmail_id != null){
                        System.out.println("opened_xmail_id 3 : " + opened_xmail_id);
                        db_sql = "UPDATE users_xmails SET users_xmails_save_draft=1 WHERE users_xmails_unique_id=?";
                        PreparedStatement st = con.prepareStatement(db_sql);
                        st.setString(1, opened_xmail_id);
                        st.execute();
                        st.close();
                    } else {
                        System.out.println("users_xmails_unique Key 3 : " + users_xmails_unique_id);
                        db_sql = "INSERT INTO users_xmails (users_xmails_unique_id, users_xmails_sender_users_unique_id, "
                                + "users_xmails_recievers_users_unique_id, users_xmails_user_subject_xmail, "
                                + "users_xmails_user_mail_body) VALUES (?, ?, ?, ?, ?)";
                        PreparedStatement st = con.prepareStatement(db_sql);
                        st.setString(1, users_xmails_unique_id);
                        st.setString(2, users_unique_id);
                        st.setString(3, (String) rs.getString("users_unique_id"));
                        st.setString(4, subject);
                        st.setString(5, message);
                        st.execute();
                        st.close();
                    }
                    System.out.println("users_xmails_unique Key 4 : " + users_xmails_unique_id);
                } else {
                    System.out.println("users_xmails_unique Key 5 : " + users_xmails_unique_id);
                    continue;
                }
                rs.close();
            }
            System.out.println("Done send! 6");
            con.close();
        } catch(ClassNotFoundException | SQLException ex) {
            pr.println(ex.getMessage());
        }
    } else if(request.getParameter("draft") != null) {
        String recipient_email = request.getParameter("recipient_email");
        String subject = request.getParameter("subject");
        String message = request.getParameter("message");
        String draft = "1";
        String[] elements = recipient_email.split(",");
        try {
            Class.forName(db_driver);
            Connection con = DriverManager.getConnection(db_url, db_username, db_password);
            for (String element : elements) {
                UUID uniqueKey = UUID.randomUUID();
                String uniquekey = uniqueKey.toString();
                String users_xmails_unique_id = "xmail_"+uniquekey;
                System.out.println("users_xmails_unique Key 1 : " + users_xmails_unique_id);
                String trimmedrecipient_email = element.trim();
                System.out.println("trimmedrecipient_email : " + trimmedrecipient_email);
                db_sql = "SELECT users_unique_id FROM users WHERE users_xmail_id=? AND users_account_block_status=0 "
                        + "AND users_account_delete_status=0";
                PreparedStatement pst = con.prepareStatement(db_sql);
                pst.setString(1, trimmedrecipient_email);
                ResultSet rs = pst.executeQuery();
                System.out.println("users_xmails_unique Key 2 : " + users_xmails_unique_id);
                if(rs.next()){
                    System.out.println("users_xmails_unique Key 3 : " + users_xmails_unique_id);
                    db_sql = "INSERT INTO users_xmails (users_xmails_unique_id, users_xmails_sender_users_unique_id, "
                            + "users_xmails_recievers_users_unique_id, users_xmails_user_subject_xmail, "
                            + "users_xmails_user_mail_body, users_xmails_save_draft) VALUES (?, ?, ?, ?, ?, ?)";
                    PreparedStatement st = con.prepareStatement(db_sql);
                    st.setString(1, users_xmails_unique_id);
                    st.setString(2, users_unique_id);
                    st.setString(3, (String) rs.getString("users_unique_id"));
                    st.setString(4, subject);
                    st.setString(5, message);
                    st.setString(6, draft);
                    st.execute();
                    st.close();
                    System.out.println("users_xmails_unique Key 4 : " + users_xmails_unique_id);
                } else {
                    System.out.println("users_xmails_unique Key 5 : " + users_xmails_unique_id);
                    continue;
                }
                rs.close();
            }
            System.out.println("Done draft! 6");
            con.close();
        } catch(ClassNotFoundException | SQLException ex) {
            pr.println(ex.getMessage());
        }
    }
%>