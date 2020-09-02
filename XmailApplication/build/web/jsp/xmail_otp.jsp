<%@include file="config.jsp" %>
<%@page import="java.net.*"%>
<%
    int xmail_OTP = 0;
    String result = null;
    PrintWriter pr = response.getWriter();
    if(request.getParameter("send_otp").equals("1")) {
        String mobile = request.getParameter("mobile");
        System.out.println("mobile for otp: "+mobile);
        xmail_OTP = Integer.parseInt(request.getParameter("otp"));
        String apiKey = "apikey=" + "Cc4CkMOsxcE-GzBT5L2VaV8OvgGUjIZ6fA741yNowQ";
        String sender = "&sender=" + "TXTLCL";
        String message = "&message=" + "Your One Time Password(OTP) for xmail is " + xmail_OTP;
        String number = "&numbers=" + mobile;
        try {
            Class.forName(db_driver);
            Connection con = DriverManager.getConnection(db_url, db_username, db_password);
            db_sql = "SELECT users_unique_id FROM users WHERE users_phone=? AND users_account_block_status=0 AND "
                    + "users_account_delete_status=0";
            PreparedStatement ps = con.prepareStatement(db_sql);
            ps.setString(1, mobile);
            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
                try {
                    // Send data
                    HttpURLConnection conn = (HttpURLConnection) new URL("https://api.textlocal.in/send/?").openConnection();
                    String data = apiKey + number + message + sender;
                    conn.setDoOutput(true);
                    conn.setRequestMethod("POST");
                    conn.setRequestProperty("Content-Length", Integer.toString(data.length()));
                    conn.getOutputStream().write(data.getBytes("UTF-8"));
                    final BufferedReader rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
                    final StringBuffer stringBuffer = new StringBuffer();
                    String line;
                    while ((line = rd.readLine()) != null) {
                            stringBuffer.append(line);
                            System.out.println(line);
                    }
                    rd.close();
                    result = "success";
                } catch (Exception e) {
                    System.out.println("Error " + e.getMessage().toString());
                    result = "Error " + e.getMessage().toString();
                }
                if(result.equals("success")) {
                    pr.println("success");
                } else {
                    pr.println("* Something went wrong, Please try later.");
                }
            } else {
                pr.println("* Invalid mobile number.");
            }
        } catch(Exception ex) {
            pr.println(ex.getMessage().toString());
        }
    }
%>