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
<!DOCTYPE html>
<html>
    <head>
        <title>Xmail | Sent</title>
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
            
            .logo-navbar-brand {
                padding-left: 45%;
            }

            .search-box {
                border: 1px solid #e85600;
                width: 30%;
            }
            .common-table {
                border-top: hidden;
            }
            .fa-icon {
                color: #e85600!important;
            }
            .subject_a {
                text-decoration: none;
                color: #e85600;
            }
            .subject_a:hover {
                text-decoration: none;
                color: #ababab;
            }
            .my_account {
                text-decoration: none;
                color: #e85600;
            }
            .my_account:hover {
                text-decoration: none;
                color: #e85612;
            }
                
            @media only screen and (max-width: 420px){
                .titulo{font-size: 22px}
            }
            @media only screen and (max-width: 325px){
                .vertical-tabs{ padding:8px;}
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
                .search-box {
                    border: 1px solid #e85600;
                    width: 100%;
                }
                .common-table {
                    border-top: hidden;
                }
                .fa-icon {
                    color: #e85600!important;
                }
                .logo-navbar-brand {
                    padding-left: 35%;
                }
                .subject_a {
                    text-decoration: none;
                    color: #e85600;
                }
                .subject_a:hover {
                    text-decoration: none;
                    color: #ababab;
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
                    <li class="nav-item">
                        <a class="nav-link" href="./user_home.jsp">Inbox</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="./user_draft.jsp">Draft</a>
                    </li>
                    <li class="nav-item active">
                        <a class="nav-link" href="./user_sent.jsp">Sent <span class="sr-only">(current)</span></a>
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
                <div>
                    <form method="POST">
                        <input id="searchFunction" class="form-control search-box" name="search_box" placeholder="Search..."/>
                    </form>
                    <hr class="hrline">
                </div>
                <table id="mail-table" class="table table-hover common-table">
                    <%
                        DateFormat Date = DateFormat.getDateInstance();
                        //Initializing Calender Object
                        Calendar cals = Calendar.getInstance();
                        String page_name = "sent";
                        try {
                            Class.forName(db_driver);
                            Connection con = DriverManager.getConnection(db_url, db_username, db_password);
                            db_sql = "SELECT users_xmails_unique_id, users_xmails_user_subject_xmail, "
                                    + "users_xmails_user_sent_date FROM users_xmails WHERE "
                                    + "users_xmails_sender_users_unique_id=? AND users_xmails_trash_status=0 AND users_xmails_save_draft=0 ORDER BY users_xmails_user_sent_date DESC";
                            PreparedStatement ps = con.prepareStatement(db_sql);
                            ps.setString(1, users_unique_id);
                            ResultSet rs = ps.executeQuery();
                            while(rs.next()) {
                                String Sent_Date = Date.format(rs.getDate("users_xmails_user_sent_date"));
                    %>
                                <tr>
                                    <td><input type="checkbox" name="check_xmail" value="<%=rs.getString("users_xmails_unique_id")%>"/></td>
                                    <td>
                                        <a class="subject_a" href="./xmail_open.jsp?xmail_user=<%=rs.getString("users_xmails_unique_id")%>&xmail_page=<%=page_name%>">
                                            <%=rs.getString("users_xmails_user_subject_xmail")%>
                                        </a>
                                    </td>
                                    <td><i><%=Sent_Date%></i></td>
                                    <td><a class="fa-icon" href="./xmail_open.jsp?xmail_user=<%=rs.getString("users_xmails_unique_id")%>&xmail_page=<%=page_name%>" title="Open"><i class="fa fa-eye"></i></a></td>
                                    <td><a class="fa-icon" href="./xmail_trash.jsp?xmail_user=<%=rs.getString("users_xmails_unique_id")%>&xmail_page=<%=page_name%>" title="Trash"><i class="fa fa-remove"></i></a></td>
                                </tr>
                    <%
                            }
                        } catch (Exception ex) {
                            pr.println(ex.getMessage().toString());
                        }
                    %>
                </table>
            </div>
        </div>
                
        <!-- Search JQuery -->
        <script>
            $(document).ready(function(){
                $("#searchFunction").on("keyup", function() {
                  var value = $(this).val().toLowerCase();
                  $("#mail-table tr").filter(function() {
                        $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                    });
                });
            });
        </script>
    </body>
</html>