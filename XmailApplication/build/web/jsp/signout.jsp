<%
    HttpSession hs = request.getSession();
    hs.removeAttribute("users_unique_id");
    response.sendRedirect("../");
%>