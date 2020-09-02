<%@include file="header.jsp" %>
<%@page import="java.util.regex.Pattern, java.sql.*, java.util.*" %>
<style>
    .signup_page {
        margin-bottom: 5%;
        margin-top: 5%;
    }
    .form-control {
        margin-bottom: 3%; 
    }
    .select-gender {
        position: relative;
        right: 3%;
    }
    .sign-btn {
        width:100%;
        text-align: center;
        cursor:pointer;
        margin-top: 3%;
    }
</style>
    <!-- Sign Up -->
    <div class="signup_page">
        <form action="signup.jsp" method="POST">
            <div class="row">    
                <div class="col-md-4">
                    <input class="form-control" type="text" name="name" placeholder="Name" required/>
                </div>
                <div class="col-md-4">
                    <input class="form-control" type="email" name="email" placeholder="Email" required/>
                </div>
                <div class="col-md-4">
                    <input class="form-control" type="password" name="pass" placeholder="Password" required/>
                </div>
                <div class="col-md-4">
                    <input class="form-control" type="text" name="phone" placeholder="Phone" required/>
                </div>
                <div class="col-md-4">
                    <input class="form-control" type="text" name="address" placeholder="Address" required/>
                </div>
                <div class="col-md-4">
                    <select class="form-control select-gender" name="gender" required>
                        <option value="">Select Gender</option>
                        <option value="male">Male</option>
                        <option value="female">Female</option>
                        <option value="transgender">Transgender</option>
                    </select>
                </div>
                <div class="col-md-4">
                    <input class="form-control" type="text" name="city" placeholder="City" required/>
                </div>
                <div class="col-md-4">
                    <input class="form-control" type="text" name="state" placeholder="State" required/>
                </div>
                <div class="col-md-4">
                    <input class="form-control" type="text" name="pincode" placeholder="Pincode" required/>
                </div>
                <div class="col-md-6">
                    <input class="btn btn-success sign-btn" type="submit" name="signup" value="Sign Up"/>
                </div>
                <div class="col-md-6">
                    <input class="btn btn-default sign-btn" type="reset" name="reset" value="Reset"/>
                </div>
            </div>
        </form>
    </div>
<%@include file="footer.jsp" %>
<%
    PreparedStatement ps;
    ResultSet rs;
    if(request.getParameter("signup") != null) {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String pass = request.getParameter("pass");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String gender = request.getParameter("gender");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String pincode = request.getParameter("pincode");
        java.util.Date jdate = new java.util.Date();
        java.sql.Date join_date = new java.sql.Date(jdate.getTime());
        String category = "user";
        int status = 1;
        ps = conn.prepareStatement("INSERT INTO user (user_name, user_email, user_password, user_phone, user_address, user_gender, user_city, user_state, user_pincode, user_join, user_status, user_category) VALUES (?,?,?,?,?,?,?,?,?,?,?,?)");
        ps.setString(1, name);
        ps.setString(2, email);
        ps.setString(3, pass);
        ps.setString(4, phone);
        ps.setString(5, address);
        ps.setString(6, gender);
        ps.setString(7, city);
        ps.setString(8, state);
        ps.setString(9, pincode);
        ps.setDate(10, join_date);
        ps.setInt(11, status);
        ps.setString(12, category);
        ps.execute();
%>
    <script>
        swal("Welcome to OnlineStore", "Your registration has been successful.", "success");
    </script>
<%
    }
%>