<%@include file="header.jsp" %>
<%
    st = conn.prepareStatement("SELECT * FROM category WHERE category_status=?");
    st.setInt(1, 1);
    rs_category = st.executeQuery();
    st = conn.prepareStatement("SELECT * FROM brand WHERE brand_status=?");
    st.setInt(1, 1);
    rs_brand = st.executeQuery();
    String cate = "", brand = "", cate_id="", brand_id="";
    int offset, limit = 6, pageno = 0;
    if(request.getParameter("cat_id") != null) {
        cate_id = request.getParameter("cat_id");
        cate = " AND product_category="+cate_id+"";
    }
    if(request.getParameter("brand_id") != null) {
        brand_id = request.getParameter("brand_id");
        brand = " AND product_brand="+brand_id+"";
    }
    if(request.getParameter("pageno") != null) {
        pageno = Integer.parseInt(request.getParameter("pageno"));
    }
    if(request.getParameter("searchbox") != null){
        st = conn.prepareStatement("SELECT * FROM product WHERE product_name LIKE ? AND product_status=? LIMIT ? OFFSET ?");
        st.setString(1, "%"+request.getParameter("searchbox")+"%");
        st.setInt(2, 1);
        st.setInt(3, limit);
        st.setInt(4, limit * pageno);
        rs_product = st.executeQuery();
    }else {
        st = conn.prepareStatement("SELECT * FROM product WHERE product_status=?"+cate+""+brand+" LIMIT ? OFFSET ?");
        st.setInt(1, 1);
        st.setInt(2, limit);
        st.setInt(3, limit * pageno);
        rs_product = st.executeQuery();
    }
%>
<style>
    .product_page {
        margin-top: 5%;
        margin-bottom: 5%;
    }
    .pagi-shop {
        margin-top: 3%;
        padding-left: 1%;
    }
    .search_product {
        margin-bottom: 10%;
    }
    .card {
        border: none;
    }
    .col1 {
        border-right: ridge;
    }
    .info_product li {
        padding-bottom: 3%; 
    }
    .product_box {
        width:250px;
        height:500px;
        text-align: -webkit-center;
    }
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
    .empty h3 {
        padding-left: 1%;
    }
</style>
    <!-- Shop Products -->
    <div class="row product_page">
        <div class="col-md-3 col1">
            <div class="search_product">
                <h3 text-align="left">Search</h3>
                <hr>
                <form action="shop.jsp" method="POST">
                    <input class="form-control" type="text" name="searchbox" placeholder="Search..."/>
                </form>
            </div>
            <div class="search_product">
                <h3 text-align="left">Categories</h3>
                <hr>
                <ul class="info_product">
                    <%
                        if(rs_category.next()) {
                            while(rs_category.next()) {
                    %>
                        <li><a href="shop.jsp?cat_id=<%=rs_category.getString("category_id")%>"><%=rs_category.getString("category_name")%></a></li>
                    <%
                            }
                        } else {
                    %>
                        <li>No Categories Found.</li>
                    <%
                        }
                    %>
                </ul>
            </div>
            <div class="search_product">
                <h3 text-align="left">Brands</h3>
                <hr>
                <ul class="info_product">
                    <%
                        if(rs_brand.next()) {
                            while(rs_brand.next()) {
                    %>
                        <li><a href="shop.jsp?brand_id=<%=rs_brand.getString("brand_id")%>"><%=rs_brand.getString("brand_name")%></a></li>
                    <%
                            }
                        } else {
                    %>
                        <li>No Brands Found.</li>
                    <%
                        }
                    %>
                </ul>
            </div>
        </div>
        <div class="col-offset-md-1 col-md-8">
            <h3 text-align="left">Products</h3>
            <hr>
            <div class="row">
            <%
                if(rs_product.next()) {
                    while(rs_product.next()) {
            %>
            <div class="col-md-4 product_box">
                <div class="card">
                    <img class="card-img-top" src="images/shop/<%=rs_product.getString("product_image")%>" alt="<%=rs_product.getString("product_name")%>" style="width:200px;height:260px;">
                    <div class="card-body" style="text-align:center;">
                        <h4 class="card-title"><%=rs_product.getString("product_name").substring(0, 17)%></h4>
                        <p class="card-text"><i class="fas fa-rupee-sign"></i>&nbsp;<%=rs_product.getString("product_price")%></p>
                        <div class="infobtn">
                            <a href="single_product.jsp?productid=<%=rs_product.getInt("product_id")%>" class="btn btn-default view_btn icon-primary" title="View Product"><i class="fas fa-eye"></i> View </a>
                        </div>
                    </div>
                </div>
            </div>
            <%
                    }
                } else {
            %>
            <div class="col-md-12 empty"><h3>No Products Found.</h3></div>
            <%
                }
            %>
    </div>
<!--                <div class="col-md-3">
                    <div class="card" style="width:100%;height:300px;">
                        <img class="card-img-top" src="images/view_1.jpg" alt="Card image" style="height:187px;">
                        <div class="card-body" style="text-align:center;">
                            <h4 class="card-title">Smartphone</h4>
                            <p class="card-text">$ 154.99</p>
                            <div class="infobtn">
                                <a href="shop.jsp" class="btn btn-md btn-success" title="Add to Cart"><i class="fas fa-shopping-cart"></i></a>
                                <a href="shop.jsp" class="btn btn-md btn-danger"><i class="fas fa-shopping-cart"></i></a>
                                <a href="single_product.jsp" class="btn btn-md btn-info" title="View Product"><i class="fas fa-eye"></i></a>
                            </div>
                        </div>
                    </div>
                </div>-->
            <div class="row pagi-shop">
                <div class="col-md-12">
                    <ul class="pagination pagination-md">
                        <li class="page-item"><a class="page-link" href="shop.jsp?pageno=0">1</a></li>
                        <li class="page-item"><a class="page-link" href="shop.jsp?pageno=1">2</a></li>
                        <li class="page-item"><a class="page-link" href="shop.jsp?pageno=2">3</a></li>
                        <li class="page-item"><a class="page-link" href="shop.jsp?pageno=3">4</a></li>
                        <li class="page-item"><a class="page-link" href="shop.jsp?pageno=4">5</a></li>
                        <li class="page-item"><a class="page-link" href="shop.jsp?pageno=5">6</a></li>
                        <li class="page-item"><a class="page-link" href="shop.jsp?pageno=6">7</a></li>
                    </ul>
                </div>
            </div>
        </div>            
    </div>
<%@include file="footer.jsp" %>