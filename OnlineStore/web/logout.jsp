<%@page import="java.util.*"%>
<%
//    if(session.getAttribute("userid") != null) {
        session.invalidate();
        String site = new String("signin.jsp");
        response.setStatus(response.SC_MOVED_TEMPORARILY);
        response.setHeader("Location", site);
//        response.sendRedirect("signin.jsp");
//    }
//    if(session.getAttribute("userid") != null) {
//        session.invalidate();
//        response.sendRedirect("signin.jsp");
//    }
%>