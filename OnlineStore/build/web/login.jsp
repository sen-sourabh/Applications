<%-- 
    Document   : login
    Created on : May 30, 2020, 5:09:08 PM
    Author     : Sourabh
--%>
<%@ page import = "java.io.*,java.util.*" %>
<%
    String uemail = request.getParameter("email");
    String upass = request.getParameter("pass");
    if(uemail.equals("sourabh@gmail.com") && upass.equals("123")){
//        response.sendRedirect("http://localhost:8084/OnlineStore/index.jsp");
        response.setHeader("Location", "http://localhost:8084/OnlineStore/index.jsp");
    }else{
        response.setHeader("Location", "http://localhost:8084/OnlineStore/signin.jsp");
//        response.sendRedirect("http://localhost:8084/OnlineStore/signin.jsp");
    }
%>