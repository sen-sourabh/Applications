<%@page import="com.paytm.pg.merchant.CheckSumServiceHelper"%>
<%@page import="java.util.Map, java.util.TreeMap, java.util.Enumeration"%>
<%@include file="header.jsp" %>
<%
//    if(request.getParameter("paytm") != null) {
        PreparedStatement ps;
        ResultSet rs;
        String checksum = null;
        com.paytm.pg.merchant.CheckSumServiceHelper checkSumServiceHelper = com.paytm.pg.merchant.CheckSumServiceHelper.getCheckSumServiceHelper();
    //    if(request.getParameter("signup") != null) {

            Enumeration<String> paramNames = request.getParameterNames();
            Map<String, String[]> mapData = request.getParameterMap();
            /* initialize a TreeMap object */
            TreeMap<String, String> paytmParams = new TreeMap<String, String>();
            while(paramNames.hasMoreElements()) {
                String paramName = (String) paramNames.nextElement();
                paytmParams.put(paramName, mapData.get(paramName)[0]);
            }
            /* Find your MID in your Paytm Dashboard at https://dashboard.paytm.com/next/apikeys */
            paytmParams.put("MID", "QISpSe76624512725486");
            /* Find your WEBSITE in your Paytm Dashboard at https://dashboard.paytm.com/next/apikeys */
            paytmParams.put("WEBSITE", "WEBSTAGING");
            /* Find your INDUSTRY_TYPE_ID in your Paytm Dashboard at https://dashboard.paytm.com/next/apikeys */
            paytmParams.put("INDUSTRY_TYPE_ID", "Retail");
            /* WEB for website and WAP for Mobile-websites or App */
            paytmParams.put("CHANNEL_ID", "WEB");
            /* Enter your unique order id "ORDER001"+request.getParameter("product_id")*/
            paytmParams.put("ORDER_ID", "ORDER001"+request.getParameter("product_id"));
            /* unique id that belongs to your customer */
            paytmParams.put("CUST_ID", request.getParameter("userid"));
            /* customer's mobile number */
            paytmParams.put("MOBILE_NO", request.getParameter("userphone"));
            /* customer's email */
            paytmParams.put("EMAIL", request.getParameter("useremail"));
            /** * Amount in INR that is payble by customer
            * this should be numeric with optionally having two decimal points*/
            paytmParams.put("TXN_AMOUNT", request.getParameter("product_price"));
            /* on completion of transaction, we will send you the response on this URL */

            checksum = CheckSumServiceHelper.getCheckSumServiceHelper().genrateCheckSum("Y7zjARm%qU9rolc!", paytmParams);
            paytmParams.put("CALLBACK_URL", "http://localhost:8084/OnlineStore/success.jsp?productid="+checksum);
    //paytmParams.put("CHECKSUMHASH", checksum);
            /* for Staging */
            String url = "https://securegw-stage.paytm.in/order/process";

            /* for Production */
            // String url = "https://securegw.paytm.in/order/process";

            /* Prepare HTML Form and Submit to Paytm */
            StringBuilder outputHtml = new StringBuilder();
            outputHtml.append("<html>");
            outputHtml.append("<head>");
            outputHtml.append("<title>Merchant Checkout Page</title>");
            outputHtml.append("</head>");
            outputHtml.append("<body>");
            outputHtml.append("<center><h1>Please do not refresh this page...</h1></center>");
            outputHtml.append("<form method='post' action='" + url + "' name='paytm_form'>");

            for(Map.Entry<String,String> entry : paytmParams.entrySet()) {
                outputHtml.append("<input type='hidden' name='" + entry.getKey() + "' value='" + entry.getValue() + "'>");
            }

            outputHtml.append("<input type='hidden' name='CHECKSUMHASH' value='" + checksum + "'>");
            outputHtml.append("</form>");
            outputHtml.append("<script type='text/javascript'>");
            outputHtml.append("document.paytm_form.submit();");
            outputHtml.append("</script>");
            outputHtml.append("</body>");
            outputHtml.append("</html>");
    //    }
    %>
    <%=outputHtml%>
    <%
//        }
    %>
<!--<html>
    <head>
        <title>Merchant Check Out Page</title>
    </head>
    <body>
        <center>
            <h1>Please do not refresh this page...</h1>
        </center>
        <form method="POST" action="https://securegw-stage.paytm.in/order/process" name="paytm">
            <input type="hidden" name="MID" value="crElEM07496269755790">
            <input type="hidden" name="WEBSITE" value="WEBSTAGING">
            <input type="hidden" name="ORDER_ID" value="ORDER001<%//=request.getParameter("product_id")%>">
            <input type="hidden" name="CUST_ID" value="<%//=request.getParameter("userid")%>">
            <input type="hidden" name="MOBILE_NO" value="<%//=request.getParameter("userphone")%>">
            <input type="hidden" name="EMAIL" value="<%//=request.getParameter("useremail")%>">
            <input type="hidden" name="INDUSTRY_TYPE_ID" value="Retail">
            <input type="hidden" name="CHANNEL_ID" value="WEB">
            <input type="hidden" name="TXN_AMOUNT" value="<%//=request.getParameter("product_price")%>">
            <input type="hidden" name="CALLBACK_URL" value="http://localhost:8084/OnlineStore/success.jsp">
            <input type="hidden" name="CHECKSUMHASH" value="<%//=checksum%>">
            <script type="text/javascript">
                document.paytm.submit();
            </script>
        </form>
    </body>
</html>-->
<%@include file="footer.jsp" %>
<%//@page import="com.paytm.pg.merchant.CheckSumServiceHelper, java.util.Map, java.util.TreeMap"%>
<%
//    com.paytm.pg.merchant.CheckSumServiceHelper checkSumServiceHelper = com.paytm.pg.merchant.CheckSumServiceHelper.getCheckSumServiceHelper();
//    /* initialize a TreeMap object */
//    TreeMap<String, String> paytmParams = new TreeMap<String, String>();
//
//    /* Find your MID in your Paytm Dashboard at https://dashboard.paytm.com/next/apikeys */
//    paytmParams.put("MID", "crElEM07496269755790");
//
//    /* Find your WEBSITE in your Paytm Dashboard at https://dashboard.paytm.com/next/apikeys */
//    paytmParams.put("WEBSITE", "WEBSTAGING");
//
//    /* Find your INDUSTRY_TYPE_ID in your Paytm Dashboard at https://dashboard.paytm.com/next/apikeys */
//    paytmParams.put("INDUSTRY_TYPE_ID", "Retail");
//
//    /* WEB for website and WAP for Mobile-websites or App */
//    paytmParams.put("CHANNEL_ID", "WEB");
//
//    /* Enter your unique order id */
//    paytmParams.put("ORDER_ID", "10001");
//
//    /* unique id that belongs to your customer */
//    paytmParams.put("CUST_ID", "101");
//
//    /* customer's mobile number */
//    paytmParams.put("MOBILE_NO", "9893564045");
//
//    /* customer's email */
//    paytmParams.put("EMAIL", "sourabhsen201313@gmail.com");
//
//    /**
//    * Amount in INR that is payble by customer
//    * this should be numeric with optionally having two decimal points
//    */
//    paytmParams.put("TXN_AMOUNT", "125");
//
//    /* on completion of transaction, we will send you the response on this URL */
//    paytmParams.put("CALLBACK_URL", "http://localhost:8084/OnlineStore/success.jsp");
//
//    /**
//    * Generate checksum for parameters we have
//    * You can get Checksum JAR from https://developer.paytm.com/docs/checksum/
//    * Find your Merchant Key in your Paytm Dashboard at https://dashboard.paytm.com/next/apikeys 
//    */
//    String checksum = CheckSumServiceHelper.getCheckSumServiceHelper().genrateCheckSum("Y7zjARm%qU9rolc!", paytmParams);
//
//    /* for Staging */
//    String url = "https://securegw-stage.paytm.in/order/process";
//
//    /* for Production */
//    // String url = "https://securegw.paytm.in/order/process";
//
//    /* Prepare HTML Form and Submit to Paytm */
//    StringBuilder outputHtml = new StringBuilder();
//    outputHtml.append("<html>");
//    outputHtml.append("<head>");
//    outputHtml.append("<title>Merchant Checkout Page</title>");
//    outputHtml.append("</head>");
//    outputHtml.append("<body>");
//    outputHtml.append("<center><h1>Please do not refresh this page...</h1></center>");
//    outputHtml.append("<form method='post' action='" + url + "' name='paytm_form'>");
//
//    for(Map.Entry<String,String> entry : paytmParams.entrySet()) {
//        outputHtml.append("<input type='hidden' name='" + entry.getKey() + "' value='" + entry.getValue() + "'>");
//    }
//
//    outputHtml.append("<input type='hidden' name='CHECKSUMHASH' value='" + checksum + "'>");
//    outputHtml.append("</form>");
//    outputHtml.append("<script type='text/javascript'>");
//    outputHtml.append("document.paytm_form.submit();");
//    outputHtml.append("</script>");
//    outputHtml.append("</body>");
//    outputHtml.append("</html>");
%>