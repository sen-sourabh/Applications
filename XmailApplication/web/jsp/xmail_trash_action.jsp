<%@page import="java.text.DateFormat"%>
<%@include file="config.jsp"  %>
<%
    HttpSession hs = request.getSession();
    if(hs.getAttribute("users_unique_id") == null) {
        response.sendRedirect("../");
    }
    String users_unique_id = (String) hs.getAttribute("users_unique_id");
    PrintWriter pr = response.getWriter();
    try {
        String opened_xmail_id = request.getParameter("xmail_user");
        String getActionName = request.getParameter("xmail_page");
        Class.forName(db_driver);
        Connection con = DriverManager.getConnection(db_url, db_username, db_password);
        if(getActionName.equals("restore")) {
            db_sql = "UPDATE users_xmails SET users_xmails_trash_status=0 WHERE users_xmails_unique_id=?";
            PreparedStatement pst = con.prepareStatement(db_sql);
            pst.setString(1, opened_xmail_id);
            pst.executeUpdate();
            pst.close();
        } else if(getActionName.equals("delete")) {
            db_sql = "UPDATE users_xmails SET users_xmails_delete_trash_status=1 WHERE users_xmails_unique_id=?";
            PreparedStatement pst = con.prepareStatement(db_sql);
            pst.setString(1, opened_xmail_id);
            pst.executeUpdate();
            pst.close();
        }
        con.close();
        response.sendRedirect("./user_trash.jsp");
    } catch(Exception ex) {
        pr.println(ex.getMessage().toString());
    }    
%>