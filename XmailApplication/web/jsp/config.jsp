<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, static java.lang.System.out, java.io.*, java.sql.*" %>
<%
    ServletContext sc = config.getServletContext();
    String db_driver = sc.getInitParameter("driver");
    String db_url = sc.getInitParameter("url");
    String db_username = sc.getInitParameter("username");
    String db_password = sc.getInitParameter("password");
    String db_sql = null;
%>