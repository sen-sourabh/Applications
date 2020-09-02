<%@include file="header.jsp" %>
<%
    st = conn.prepareStatement("SELECT * FROM category WHERE category_status=?");
    st.setInt(1, 1);
    rs_category = st.executeQuery();
    String cate = "", cate_id="";
    int offset, limit = 6, pageno = 0;
    if(request.getParameter("cat_id") != null) {
        cate_id = request.getParameter("cat_id");
        cate = " AND product_category="+cate_id+"";
    }
    if(request.getParameter("pageno") != null) {
        pageno = Integer.parseInt(request.getParameter("pageno"));
    }
    if(request.getParameter("searchbox") != null){
        st = conn.prepareStatement("SELECT * FROM brand WHERE brand_name LIKE ? AND brand_status=? LIMIT ? OFFSET ?");
        st.setString(1, "%"+request.getParameter("searchbox")+"%");
        st.setInt(2, 1);
        st.setInt(3, limit);
        st.setInt(4, limit * pageno);
        rs_brand = st.executeQuery();
    }else if(request.getParameter("cat_id") != null) {
        cate_id = request.getParameter("cat_id");
        cate = " AND product_category="+cate_id+"";
        st = conn.prepareStatement("SELECT * FROM brand WHERE brand_id IN (SELECT product_brand FROM product WHERE product_status=?"+cate+") LIMIT ? OFFSET ?");
        st.setInt(1, 1);
        st.setInt(2, limit);
        st.setInt(3, limit * pageno);
        rs_brand = st.executeQuery();
    } else {
        st = conn.prepareStatement("SELECT * FROM brand WHERE brand_status=? LIMIT ? OFFSET ?");
        st.setInt(1, 1);
        st.setInt(2, limit);
        st.setInt(3, limit * pageno);
        rs_brand = st.executeQuery();
    }
%>
<style>
    .product_page {
        margin-top: 5%;
        margin-bottom: 5%;
    }
    .pagi-shop {
        margin-top: 3%;
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
        height:400px;
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
</style>
    <!-- Shop Products -->
    <div class="row product_page">
        <div class="col-md-3 col1">
            <div class="search_product">
                <h3 text-align="left">Search</h3>
                <hr>
                <form action="featured_brands.jsp" method="POST">
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
                        <li><a href="featured_brands.jsp?cat_id=<%=rs_category.getString("category_id")%>"><%=rs_category.getString("category_name")%></a></li>
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
        </div>
        <div class="col-offset-md-1 col-md-8">
            <h3 text-align="left">Brands</h3>
            <hr>
            <div class="row">
            <%
                while(rs_brand.next()) {
            %>
            <div class="col-md-4 product_box">
                <div class="card">
                    <img class="card-img-top" src="images/shop/<%=rs_brand.getString("brand_image")%>" alt="<%=rs_brand.getString("brand_name")%>" style="width:200px;height:260px;">
                    <div class="card-body" style="text-align:center;">
                        <h4 class="card-title"><%=rs_brand.getString("brand_name")%></h4>
                        <div class="infobtn">
                            <a href="shop.jsp?brandid=<%=rs_brand.getInt("brand_id")%>" class="btn btn-default view_btn icon-primary" title="View Product"><i class="fas fa-eye"></i> View </a>
                        </div>
                    </div>
                </div>
            </div>
            <%
                }
            %>
            </div>
<!--            <div class="col-md-3">
                    <div class="card" style="width:100%;height:300px;">
                        <img class="card-img-top" src="images/dell.jpg" alt="Card image" style="height:187px;">
                        <div class="card-body" style="text-align:center;">
                            <h4 class="card-title">Dell</h4>
                            <div class="infobtn">
                                <a href="shop.jsp" class="btn btn-md btn-success" title="View Products"><i class="fas fa-dice-d6"></i></a>
                                <a href="shop.jsp" class="btn btn-md btn-danger"><i class="fas fa-shopping-cart"></i></a>
                                <a href="single_product.jsp" class="btn btn-md btn-info"><i class="fas fa-eye"></i></a>
                            </div>
                        </div>
                    </div>
                </div>-->
            <div class="row pagi-shop">
                <div class="col-md-12">
                    <ul class="pagination pagination-md">
                        <li class="page-item"><a class="page-link" href="featured_brands.jsp?pageno=0">1</a></li>
                        <li class="page-item"><a class="page-link" href="featured_brands.jsp?pageno=1">2</a></li>
                        <li class="page-item"><a class="page-link" href="featured_brands.jsp?pageno=2">3</a></li>
                        <li class="page-item"><a class="page-link" href="featured_brands.jsp?pageno=3">4</a></li>
                        <li class="page-item"><a class="page-link" href="featured_brands.jsp?pageno=4">5</a></li>
                    </ul>
                </div>
            </div>
        </div>
            
    </div>
<%@include file="footer.jsp" %>