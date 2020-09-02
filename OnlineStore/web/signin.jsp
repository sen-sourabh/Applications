<%@include file="header.jsp"%>
<style>
    .signin_page {
        margin-bottom: 5%;
        margin-top: 5%;
    }
    .form-control {
        margin-bottom: 3%; 
    }
    .sign-btn {
        width:100%;
        text-align: center;
        cursor:pointer;
        margin-top: 3%;
    }
</style>
    <!-- Sign In -->
    <div class="signin_page">
        <form action="signin.jsp" method="POST">
            <div class="row">
                <div class="col-md-12">
                    <input class="form-control" type="email" name="email" placeholder="Email" required/>
                </div>
                <div class="col-md-12">
                    <input class="form-control" type="password" name="password" placeholder="Password" required/>
                </div>
                <div class="col-md-6">
                    <input class="btn btn-success sign-btn" type="submit" name="signin" value="Sign In"/>
                </div>
                <div class="col-md-6">
                    <input class="btn btn-default sign-btn" type="reset" name="reset" value="Reset"/>
                </div>
            </div>
        </form>
    </div>
<%@include file="footer.jsp"%>
<%
    try {
        ResultSet r_set;
        if(request.getParameter("signin") != null) {
            String email = request.getParameter("email");
            String pass = request.getParameter("password");
            st = conn.prepareStatement("SELECT * FROM user WHERE user_email=? AND user_password=?");
            st.setString(1, email);
            st.setString(2, pass);
            r_set = st.executeQuery();
            if(r_set.next() == false){
%>
        <script>
            swal("Sorry!", "Invalid Email or Password, Please try again.", "error");
        </script>
<%
            } else {
                int userid = r_set.getInt("user_id");
                session.setAttribute("userid", userid);
                String site = new String("index.jsp");
                response.setStatus(response.SC_MOVED_TEMPORARILY);
                response.setHeader("Location", site);
            }
        }
    } catch(Exception ex) {
%>
        <script>
            swal("Exception", ex.getMessage(), "error");
        </script>
<%        
    }
%>