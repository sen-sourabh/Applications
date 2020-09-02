<%--<%@include file="config.jsp" %>--%>
<%@include file="header.jsp"%>
<style>
    .input_field {
        font-size: larger;
        font-weight: 500;
    }
    .contact_submit_button {
        font-weight: 500;
    }
</style>
        <!-- Contact Form -->

	<div class="contact_form">
		<div class="container">
			<div class="row">
				<div class="col-lg-10 offset-lg-1">
					<div class="contact_form_container">
						<div class="contact_form_title">Sign Up</div>

						<form action="" method="post" id="contact_form">
							<div class="contact_form_inputs d-flex flex-md-row flex-column justify-content-between align-items-between">
								<input name="name" type="text" id="contact_form_name" class="contact_form_name input_field" placeholder="Your Name" required="required" data-error="Name is required.">
								<input name="email" type="email" id="contact_form_email" class="contact_form_email input_field" placeholder="Your Email" required="required" data-error="Email is required.">
                                                                <input name="password" type="password" id="contact_form_name" class="contact_form_name input_field" placeholder="Your Password" required="required" data-error="Password is required.">
                                                        </div>
                                                        <div class="contact_form_inputs d-flex flex-md-row flex-column justify-content-between align-items-between">
								<input name="phone" type="text" id="contact_form_phone" class="contact_form_phone input_field" placeholder="Your Phone" required="required" data-error="Phone is required.">
								<input name="address" type="text" id="contact_form_email" class="contact_form_email input_field" placeholder="Your Address" required="required" data-error="Address is required.">
                                                                <select name="gender" id="contact_form_phone" class="contact_form_phone input_field" required="required" data-error="Gender is required.">
                                                                    <option value="">Select Gender</option>
                                                                    <option value="male">Male</option>
                                                                    <option value="female">Female</option>
                                                                    <option value="transgender">Transgender</option>
                                                                </select>
                                                        </div>
                                                        <div class="contact_form_inputs d-flex flex-md-row flex-column justify-content-between align-items-between">
								<input name="city" type="text" id="contact_form_name" class="contact_form_name input_field" placeholder="Your City" required="required" data-error="City is required.">
								<input name="state" type="text" id="contact_form_email" class="contact_form_email input_field" placeholder="Your State" required="required" data-error="State is required.">
                                                                <input name="pincode" type="text" id="contact_form_phone" class="contact_form_phone input_field" placeholder="Your Pincode" required="required" data-error="Pincode is required.">
							</div>
							<div class="contact_form_button">
								<input type="submit" class="button contact_submit_button" name="signup" value="Sign Up"/>
							</div>
						</form>
<!--                                                <center>
                                                    <h2>OR</h2><br>
                                                    <a href="https://www.gmail.com/"><image src="images/signin-button.png"/></a>
                                                </center>-->
<!--                                                <center>
                                                    <h2>OR</h2><br>
                                                    <a href="https://www.facebook.com/"><image src=""/></a>
                                                </center>-->
					</div>
				</div>
			</div>
		</div>
		<div class="panel" style="background-color: #ffffff;"></div>
	</div>
<%
    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/online_store","root","root");
        PreparedStatement ps;
        ResultSet rs;
        if(request.getParameter("signup") != null) {
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String pass = request.getParameter("password");
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
            if(SendEmail.sendMail(name, email, pass, category, "register")) {
                System.out.println("Email Success");
            } else {
                System.out.println("Email Failed");
            }
%>
        <script>
            swal("Welcome to OnlineStore", "Your registration has been successful.", "success");
        </script>
<%
        }
    } catch(Exception ex) {
%>
        <script>
            swal("Exception", ex.getMessage(), "error");
        </script>
<%
    }
%>        
<%@include file="footer.jsp"%>

