<%@page import="java.util.TreeMap, java.util.Enumeration"%>
<%@page import="java.util.Map.Entry"%>
<%@page import="com.paytm.pg.merchant.CheckSumServiceHelper"%>
<%@include file="header.jsp" %>
<%
            String paytmChecksum = "";
            boolean isValidChecksum = false;
            String MKEY = "Y7zjARm%qU9rolc!";
            String outputHtml = "";
            Enumeration<String> paramNames = request.getParameterNames();
            Map<String, String[]> mapData = request.getParameterMap();
            /* Create a TreeMap from the parameters received in POST */
            TreeMap<String, String> paytmParams = new TreeMap<String, String>();
            while(paramNames.hasMoreElements()) {
                String paramName = (String) paramNames.nextElement();
                if(paramName.equals("CHECKSUMHASH")) {
                    paytmChecksum = mapData.get(paramName)[0];
                } else {
                    paytmParams.put(paramName, mapData.get(paramName)[0]);
                }
            }
//            for (Entry<String, String[]> requestParamsEntry : request.getParameterMap().entrySet()) {
//                if ("CHECKSUMHASH".equalsIgnoreCase(requestParamsEntry.getKey())){
//                    paytmChecksum = requestParamsEntry.getValue()[0];
//                } else {
//                    paytmParams.put(requestParamsEntry.getKey(), requestParamsEntry.getValue()[0]);
//                }
//            }

            try{
                /**
                * Verify checksum
                * Find your Merchant Key in your Paytm Dashboard at https://dashboard.paytm.com/next/apikeys 
                */
                isValidChecksum = CheckSumServiceHelper.getCheckSumServiceHelper().verifycheckSum(MKEY, paytmParams, paytmChecksum);
                if (isValidChecksum && paytmParams.containsKey("RESPCODE")) {
                    if(paytmParams.get("RESPCODE").equals("01")) {
                        outputHtml = paytmParams.toString();
                        Enumeration aa = request.getParameterNames();
                        while(aa.hasMoreElements()) {
                            Object a = aa.nextElement();
                    %>
                    <h2>
                        Your Payment has been successful.
                    </h2>
                    <%
                        }
                    } else {
                        outputHtml = "<b>Payment Failed.</b>";
                        Enumeration aa = request.getParameterNames();
                        while(aa.hasMoreElements()) {
                            Object a = aa.nextElement();
                            out.println(a);
                        }
                    }
                } else {
                    outputHtml = "<a href='shop.jsp'>Go to Shop</a><br><b>Checksum Mismatched.</b> " + paytmParams.get("RESPCODE")+" "+isValidChecksum;
                }
            }catch(Exception ex) {
                outputHtml = ex.toString();
            }
        %>
        <%=outputHtml%>
<%@include file="footer.jsp" %>
