<%@include file="header.jsp" %>
<%
    ResultSet rs_single_product, rs_user;
    String userid=null, username=null, useremail=null, userphone=null;
    String product_id = request.getParameter("productid");
    st = conn.prepareStatement("SELECT * FROM product WHERE product_id=? AND product_status=?");
    st.setString(1, product_id);
    st.setInt(2, 1);
    rs_single_product = st.executeQuery();
    if(session.getAttribute("userid") != null) {
        st = conn.prepareStatement("SELECT user_id, user_name, user_email, user_phone FROM user WHERE user_id=?");
        st.setInt(1, (int)session.getAttribute("userid"));
        rs_user = st.executeQuery();
        while(rs_user.next()) {
            userid = rs_user.getString("user_id");
            username = rs_user.getString("user_name");
            useremail = rs_user.getString("user_email");
            userphone = rs_user.getString("user_phone");
        }
    }
%>
<style>
    .single_product {
        margin-top: 10%;
        margin-bottom: 10%;
    }
    .image_box {
        width: 100%;
        height:550px;
        padding-left: 10%;
        padding-right: 10%;
        border-right: ridge;
    }
    .product_title {
        margin-bottom: 6%;
    }
    .product_price {
        margin-bottom: 6%;
        color: #ff6100;
    }
    .product_desc p {
        margin-bottom: 12%;
        text-align: justify;
        width:90%;
    }
    product_btn {
        width:90%;
    }
</style>
<div class="single_product">
    <!-- Single Product -->
    <%
        while(rs_single_product.next()) {
    %>
    <div class="row">
        <div class="col-md-6 image_box">
            <img src="images/shop/<%=rs_single_product.getString("product_image")%>" alt="<%=rs_single_product.getString("product_name").substring(0, 15)+"..."%>" style="width:100%;height:100%"/>
        </div>
        <div class="col-md-6">
            <div class="product_title">
                <h2> <%=rs_single_product.getString("product_name")%> </h2>
            </div>
            <div class="product_price">
                <h3> <i class="fas fa-rupee-sign"></i>&nbsp;<%=rs_single_product.getString("product_price")%> </h3>
            </div>
            <div class="product_desc">
                <h4> Product Description </h4>
                <hr>
                <p> 
                    <%=rs_single_product.getString("product_desc")%>
                </p>
            </div>
            <div class="product_btn">
                <%
                    if(session.getAttribute("userid") != null) {
                %>
                    <form method="POST" action="checksum.jsp">
                        <input type="hidden" name="product_id" value="<%=rs_single_product.getString("product_id")%>"/>
                        <input type="hidden" name="product_price" value="<%=rs_single_product.getString("product_price")%>"/>
                        <input type="hidden" name="userid" value="<%=userid%>"/>
                        <input type="hidden" name="username" value="<%=username%>"/>
                        <input type="hidden" name="useremail" value="<%=useremail%>"/>
                        <input type="hidden" name="userphone" value="<%=userphone%>"/>
                        <button class="btn btn-link" type="submit" name="paytm" value="paytm"><img src="images/Buy-now.png"/></button>
                    </form>
                <%
                    } else {
                %>
                    <a href="signin.jsp" class="btn btn-link">
                        <img src="images/Buy-now.png"/>
                    </a>
                <%    
                    }
                %>
            </div>
        </div>
    </div>
    <%
        }
    %>
</div>
<%@include file="footer.jsp" %>