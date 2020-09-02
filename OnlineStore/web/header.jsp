<%@page import="java.sql.*, java.util.*" contentType="text/html" pageEncoding="UTF-8"%>
<%
    String uri = request.getRequestURI();
    String pageName = uri.substring(uri.lastIndexOf("/")+1);
    String page_name = null;
    String span_home = "",span_shop = "",span_category = "",span_contact = "",span_brands = "",span_signup = "",span_signin = "", span_corona = " ";
    if(pageName.equals("index.jsp")) {
        page_name = "Home";
        span_home = "active";
    } else if(pageName.equals("shop.jsp")) {
        page_name = "Shop";
        span_shop = "active";
    } else if(pageName.equals("category.jsp")) {
        page_name = "Category";
        span_category = "active";
    } else if(pageName.equals("contact.jsp")) {
        page_name = "Contact";
        span_contact = "active";
    } else if(pageName.equals("featured_brands.jsp")) {
        page_name = "Brands";
        span_brands = "active";
    } else if(pageName.equals("signup.jsp")) {
        page_name = "Sign Up";
        span_signup = "active";
    } else if(pageName.equals("signin.jsp")) {
        page_name = "Sign In";
        span_signin = "active";
    } else if(pageName.equals("CoronaUpdate.jsp")) {
        page_name = "Corona";
        span_corona = "active";
    } else {
        page_name = "Home";
        span_home = "active";
    }
    Connection conn;
    Class.forName("com.mysql.jdbc.Driver");
    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/online_store","root","root");
    PreparedStatement st;
    ResultSet rs_category, rs_brand, rs_product;
    int cat_id = 0;
    st = conn.prepareStatement("SELECT * FROM category WHERE category_status=?");
    st.setInt(1, 1);
    rs_category = st.executeQuery();
%>

<!DOCTYPE html>
<html lang="en">
<head>
<title> EStore | <%=page_name%> </title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="description" content="OneTech shop project">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="styles/bootstrap4/bootstrap.min.css">
<link href="plugins/fontawesome-free-5.0.1/css/fontawesome-all.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="styles/main_styles.css"/>
<link rel="stylesheet" type="text/css" href="styles/responsive.css"/>
<link rel="stylesheet" type="text/css" href="styles/sweetalert.css"/>

<style>
    .dropdown-menu_user {
        left: -101px;
    }
    .user_menu {
        cursor: pointer;
    }
</style>
</head>

<body class="container">

<div class="super_container">
	
	<!-- Header -->
	
	<header class="header">
            <nav class="navbar navbar-expand-lg navbar-light" style="background-color: #fafafa;">
                    <a class="navbar-brand" href="index.jsp">EStore</a>
                    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                      <span class="navbar-toggler-icon"></span>
                    </button>

                    <div class="collapse navbar-collapse" id="navbarSupportedContent">
                        <ul class="navbar-nav mr-auto">
                            <li class="nav-item <%=span_home%>">
                              <a class="nav-link" href="index.jsp">Home </a>
                            </li>
                            <li class="nav-item <%=span_shop%>">
                              <a class="nav-link" href="shop.jsp">Shop </a>
                            </li>
                            <li class="nav-item dropdown <%=span_category%>">
                              <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                Category 
                              </a>
                              <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                                    <%
                                        if(rs_category.next()) {
                                            while(rs_category.next()) {
                                    %>
                                    <a class="dropdown-item" href="shop.jsp?cat_id=<%=rs_category.getString("category_id")%>"><%=rs_category.getString("category_name")%></a>
                                    <%
                                            }
                                        }else{
                                    %>
                                        <a class="dropdown-item" href="shop.jsp">Go to Shop</a>
                                    <%
                                        }
                                    %>
                              </div>
                            </li>
                            <li class="nav-item <%=span_brands%>">
                              <a class="nav-link" href="featured_brands.jsp">Brands </a>
                            </li>
                            <li class="nav-item <%=span_corona%>">
                              <a class="nav-link" href="CoronaUpdate.jsp">COVID-19 Updates </a>
                            </li>
                            <%
                                if(session.getAttribute("userid") == null) {
                            %>
                            <li class="nav-item <%=span_signup%>">
                                <a class="nav-link" href="signup.jsp">Sign Up </a>
                            </li>
                            <li class="nav-item <%=span_signin%>">
                                <a class="nav-link" href="signin.jsp">Sign In </a>
                            </li>
                            <%
                                }
                            %>
                        </ul>
                        <div>
                            <form action="shop.jsp" metod="POST" class="form-inline">
                                <input class="form-control mr-sm-2" type="search" name="searchbox" placeholder="Search..." aria-label="Search">
                                <!--<input class="btn btn-outline-success my-2 my-sm-0" name="search" type="submit" style="cursor:pointer;" value="Search" />-->
                            </form>
                        </div>
                        <%
//                            int session_user_id = 0;
                            if(session.getAttribute("userid") != null) {
//                                session_user_id = Integer.parseInt(session.getAttribute("userid"));
                        %>
                        <div class="dropdown">
                            <button class="btn btn-default dropdown-toggle user_menu" type="button" id="menu1" data-toggle="dropdown">
                                <i class="fas fa-user-alt" style="width:20px;height:20px;">
                                    <span class="caret"></span>
                                </i>
                            </button>
                            <ul class="dropdown-menu dropdown-menu_user" role="menu" aria-labelledby="menu1">
                              <li role="presentation"><a class="dropdown-item" href="profile.jsp"> Profile </a></li>
                              <li role="presentation"><a class="dropdown-item" href="setting.jsp"> Setting </a></li>
                              <li role="presentation"><a class="dropdown-item" href="logout.jsp"> Logout </a></li>
                            </ul>
                        </div>
                        <%
                            } else {}
                        %>
                    </div>
              </nav>
	</header>
        
        <style>
            .home {
                width:100%;
                height:10%;
                background-image: url("images/shop_back.jpg");
                background-repeat: no-repeat;
                background-size: 100%;
            }
            .home_title {
                color: #FFFFFF;
                text-align: center;
                margin-top: 10%;
            }
            .home_sub_title {
                color: #FFFFFF;
                text-align: center;
                margin-bottom: 10%;
            }
        </style>
        
        <%
            if(!page_name.equals("Home")){
        %>
            <!-- common Banner -->
            <div class="home">
                    <div class="home_content d-flex flex-column align-items-center justify-content-center">
                            <h2 class="home_title"><%=page_name%></h2>
                            <%
                                if(page_name.equals("Shop")) {
                            %>
                            <h3 class="home_sub_title">Experience the lifestyle</h3>
                            <%
                                } else if(page_name.equals("Brands")) {
                            %>
                            <h3 class="home_sub_title">There Is No Finish Line</h3>
                            <%
                                } else if(page_name.equals("Sign Up")) {
                            %>
                            <h3 class="home_sub_title">Save Time, Save Money</h3>
                            <%
                                } else if(page_name.equals("Sign In")) {
                            %>
                            <h3 class="home_sub_title">Save Time, Save Money</h3>
                            <%
                                } else if(page_name.equals("Corona")) {
                            %>
                            <h3 class="home_sub_title">Stay Home, Stay Safe</h3>
                            <%
                                }
                            %>
                    </div>
            </div>
        <%
            }
        %>
