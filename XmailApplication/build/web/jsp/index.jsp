<%@page import="java.util.*, static java.lang.System.out, java.io.*, java.sql.*" %>
<%@include file="config.jsp" %>
<%
    PrintWriter pr = response.getWriter();
    if(request.getParameter("signup").equals("1")) {
        String name = request.getParameter("name");
        String emailid = request.getParameter("emailid");
        String static_email = request.getParameter("static_email");
        String password = request.getParameter("password");
        String cpassword = request.getParameter("cpassword");
        String bod = request.getParameter("bod");
        String gender = request.getParameter("gender");
        String mobile = request.getParameter("mobile");
        if(name.equals("")) {
            pr.println("Name is required.");
        } else if(emailid.equals("")) {
            pr.println("Email is required.");
        } else if(password.equals("")) {
            pr.println("Password is required.");
        } else if(cpassword.equals("")) {
            pr.println("Confirm password is required.");
        } else if(!password.equals(cpassword)) {
            pr.println("Password & Confirm password is not matched.");
        } else if(bod.equals("")) {
            pr.println("Birth date is required.");
        } else if(gender.equals("")) {
            pr.println("Gender is required.");
        } else if(mobile.equals("")) {
            pr.println("Mobile is required.");
        } else {
            try {
                UUID uniqueKey = UUID.randomUUID();
                String uniquekey = uniqueKey.toString();
                String users_unique_id = "xmail_"+uniquekey;
                System.out.println("users Unique Key : " + users_unique_id);
                String email = emailid + static_email;
                Class.forName(db_driver);
                Connection con = DriverManager.getConnection(db_url, db_username, db_password);
                db_sql = "SELECT users_unique_id FROM users WHERE users_xmail_id=?";
                PreparedStatement ps = con.prepareStatement(db_sql);
                ps.setString(1, email);
                ResultSet rs = ps.executeQuery();
                if(rs.next()) {
                    rs.close();
                    ps.close();
                    con.close();
                    pr.println("Email is already in use. Try with different emailid.");
                } else {
                    rs.close();
                    ps.close();
                    db_sql = "INSERT INTO users (users_unique_id, users_xmail_id, users_password, users_name, "
                            + "users_gender, users_phone, users_birthdate) VALUES (?, ?, ?, ?, ?, ?, ?)";
                    PreparedStatement pst = con.prepareStatement(db_sql);
                    pst.setString(1, users_unique_id);
                    pst.setString(2, email);
                    pst.setString(3, password);
                    pst.setString(4, name);
                    pst.setString(5, gender);
                    pst.setString(6, mobile);
                    pst.setString(7, bod);
                    pst.execute();
                    pst.close();
                    con.close();
                    pr.println("Sign up Successfully.");
                }
            } catch(ClassNotFoundException | SQLException ex) {
                pr.println(ex.getMessage());
            }
        }
    }
%>