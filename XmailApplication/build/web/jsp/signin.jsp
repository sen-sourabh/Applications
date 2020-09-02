<%@include file="config.jsp" %>
<%
    PrintWriter pr = response.getWriter();
    if(request.getParameter("sign_in").equals("Sign In")) {
        String emailid = request.getParameter("signin_emailid");
        String static_email = request.getParameter("signin_static_email");
        String password = request.getParameter("signin_password");
        if(emailid.equals("")) {
            pr.println("Email is required.");
        } else if(password.equals("")) {
            pr.println("Password is required.");
        } else {
            try {
                String email = emailid + static_email;
                Class.forName(db_driver);
                Connection con = DriverManager.getConnection(db_url, db_username, db_password);
                db_sql = "SELECT users_unique_id FROM users WHERE users_xmail_id=? AND users_password=?";
                PreparedStatement ps = con.prepareStatement(db_sql);
                ps.setString(1, email);
                ps.setString(2, password);
                ResultSet rs = ps.executeQuery();
                if(rs.next()) {
                    HttpSession hs = request.getSession();
                    hs.setAttribute("users_unique_id", rs.getString("users_unique_id"));
                    rs.close();
                    ps.close();
                    con.close();
                    response.sendRedirect("./user_home.jsp");
                } else {
                    rs.close();
                    ps.close();
                    con.close();
                    pr.println("<h3>Email or Password is invalid.<a href='../html/index.html'>Click Here to login page...</a></h3>");
                }
            } catch(ClassNotFoundException | SQLException ex) {
                pr.println(ex.getMessage());
            }
        }
    }
%>