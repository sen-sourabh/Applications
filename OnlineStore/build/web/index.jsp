<%@include file="header.jsp" %>
<%
    st = conn.prepareStatement("SELECT * FROM category WHERE category_status=? LIMIT 4");
    st.setInt(1, 1);
    rs_category = st.executeQuery();
    st = conn.prepareStatement("SELECT * FROM brand WHERE brand_status=? LIMIT 4");
    st.setInt(1, 1);
    rs_brand = st.executeQuery();
    st = conn.prepareStatement("SELECT * FROM product WHERE product_status=? LIMIT 4");
    st.setInt(1, 1);
    rs_product = st.executeQuery();
%>
<style>
    .icon-primary {
        font-size: 1vw;
        color: #007bff; 
    }
    .icon-primary:hover {
        color: #0069D9;
    }
    .view_btn {
        border:1px solid #007bff;
    }
    .view_btn:hover {
        border:1px solid #0069D9;
    }
    .card {
        border: none;
    }
</style>
        <!-- Index Slider -->
        <div class="slider-store">
            <div class="row">
                <div id="demo" class="carousel slide" data-ride="carousel">
                    <!-- Indicators -->
                    <ul class="carousel-indicators">
                      <li data-target="#demo" data-slide-to="0" class="active"></li>
                      <li data-target="#demo" data-slide-to="1"></li>
                      <li data-target="#demo" data-slide-to="2"></li>
                      <li data-target="#demo" data-slide-to="3"></li>
                    </ul>

                    <!-- The slideshow -->
                    <div class="carousel-inner">
                      <div class="carousel-item active">
                        <img src="images/hhslider_1.jpg" alt="Los Angeles" style="width:100%;height:500px;">
                      </div>
                      <div class="carousel-item">
                        <img src="images/hhslider_2.jpg" alt="Chicago" style="width:100%;height:500px;">
                      </div>
                      <div class="carousel-item">
                        <img src="images/hhslider_3.jpg" alt="New York" style="width:100%;height:500px;">
                      </div>
                        <div class="carousel-item">
                        <img src="images/hhslider_4.jpg" alt="Chicago" style="width:100%;height:500px;">
                      </div>
                    </div>

                    <!-- Left and right controls -->
                    <a class="carousel-control-prev" href="#demo" data-slide="prev">
                      <span class="carousel-control-prev-icon"></span>
                    </a>
                    <a class="carousel-control-next" href="#demo" data-slide="next">
                      <span class="carousel-control-next-icon"></span>
                    </a>
                  </div>
            </div>
        </div>     
        <!-- Products -->
        <div class="products" style="margin-top:5%;margin-bottom:5%;">
            <center style="font-weight:bold;margin-bottom:5%;">
                <h1> Products </h1>
            </center>
            <div class="row">
                <%
                    while(rs_product.next()) {
                %>
                <div class="col-md-3">
                    <div class="card" style="width:100%;height:300px;">
                    <img class="card-img-top" src="images/shop/<%=rs_product.getString("product_image")%>" alt="<%=rs_product.getString("product_name")%>" style="height:187px;">
                    <div class="card-body" style="text-align:center;">
                      <h4 class="card-title"> <%=rs_product.getString("product_name").substring(0, 17)%> </h4>
                      <p class="card-text"><i class="fas fa-rupee-sign"></i>&nbsp;<%=rs_product.getString("product_price")%></p>
                      <a href="single_product.jsp?productid=<%=rs_product.getInt("product_id")%>" class="btn btn-default view_btn icon-primary" title="View Product"><i class="fas fa-eye"></i> View </a>
                    </div>
                  </div>
                </div>
                <%
                    }
                %>
            </div>
        </div>

        <!-- Category -->

        <div class="category" style="margin-top:5%;margin-bottom:5%;">
            <center style="font-weight:bold;margin-bottom:5%;">
                <h1> Categories </h1>
            </center>
            <div class="row">
                <%
                    while(rs_category.next()) {
                %>
                <div class="col-md-3">
                    <div class="card" style="width:100%;height:300px;">
                    <img class="card-img-top" src="images/<%=rs_category.getString("category_image")%>" alt="<%=rs_category.getString("category_name")%>" style="height:187px;">
                    <div class="card-body" style="text-align:center;">
                      <h4 class="card-title"> <%=rs_category.getString("category_name")%> </h4>
                      <a href="shop.jsp?cat_id=<%=rs_category.getInt("category_id")%>" class="btn btn-default view_btn icon-primary" title="View Products"><i class="fas fa-eye"></i> View </a>
                    </div>
                  </div>
                </div>
                <%
                    }
                %>
            </div>
        </div>        

        <!-- Brands -->

        <div class="category" style="margin-top:5%;margin-bottom:5%;">
            <center style="font-weight:bold;margin-bottom:5%;">
                <h1> Brands </h1>
            </center>
            <div class="row">
                <%
                    while(rs_brand.next()) {
                %>
                <div class="col-md-3">
                    <div class="card" style="width:100%;height:300px;">
                    <img class="card-img-top" src="images/shop/<%=rs_brand.getString("brand_image")%>" alt="<%=rs_brand.getString("brand_name")%>" style="height:187px;">
                    <div class="card-body" style="text-align:center;">
                      <h4 class="card-title"> <%=rs_brand.getString("brand_name")%> </h4>
                      <a href="shop.jsp?brand_id=<%=rs_brand.getInt("brand_id")%>" class="btn btn-default view_btn icon-primary" title="View Products"><i class="fas fa-eye"></i> View </a>
                    </div>
                  </div>
                </div>
                <%
                    }
                %>
            </div>
        </div>

<%@include file="footer.jsp" %>
<%
    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection connec = DriverManager.getConnection("jdbc:mysql://localhost:3306/online_store","root","root");
        PreparedStatement ps;
        if(request.getParameter("subscribe") != null) {
            String email = request.getParameter("email");
            java.util.Date join_date = new java.util.Date();
            java.sql.Date jdate = new java.sql.Date(join_date.getTime());
            ps = connec.prepareStatement("INSERT INTO subscriber (sub_email, sub_substatus, sub_date) VALUES (?, ?, ?)");
            ps.setString(1, email);
            ps.setInt(2, 1);
            ps.setDate(3, jdate);
            ps.execute();
            //if(SendEmail.sendMail("", email, "", "", "Subscription")) {
            //    System.out.println("Subscription Success");
            //} else {
            //    System.out.println("Subscription Failed");
            //}
%>
        <script>
            swal("Subscribe", "Your subscription has been successful.", "success");
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