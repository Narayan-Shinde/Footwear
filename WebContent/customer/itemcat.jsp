<%@page import="java.sql.ResultSet"%>
<%@ include file="../header.jsp" %>

<!-- Start Products -->
<div class="products-box">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <div class="title-all text-center">
                    <h1>Footwear Collection</h1>
                    <p>Find the best footwear that suits your style.</p>
                </div>
            </div>
        </div>
        
        <div class="row">
            <div class="col-lg-12">
                <div class="special-menu text-center">
                    <div class="button-group filter-button-group">
                        <button class="active" data-filter="*">All</button>
                        <button data-filter=".top-featured">Top featured</button>
                        <button data-filter=".best-seller">Best seller</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="row special-list">
            <%
            ResultSet rs = db.getRows("SELECT * FROM ItemView"); 
            while (rs.next()) {
            %>
            <div class="col-lg-3 col-md-6 special-grid best-seller">
                <div class="products-single fix">
                    <div class="box-img-hover">
                        <div class="type-lb">
                            <p class="sale">Sale</p>
                        </div>
                        <img src="../itemimages/<%= rs.getString("ItemImage") %>" class="img-fluid" alt="<%= rs.getString("ItemName") %>">
                        <div class="mask-icon">
                            <ul>
                                <li><a href="#" data-toggle="tooltip" data-placement="right" title="View"><i class="fas fa-eye"></i></a></li>
                                <li><a href="#" data-toggle="tooltip" data-placement="right" title="Compare"><i class="fas fa-sync-alt"></i></a></li>
                                <li><a href="#" data-toggle="tooltip" data-placement="right" title="Add to Wishlist"><i class="far fa-heart"></i></a></li>
                            </ul>                               
                            <a class="cart btn btn-sm btn-primary text-light" href="addtocart.jsp?itemid=<%= rs.getString("ItemId") %>">Add to Cart</a>
                        </div>
                    </div>
                    <div class="why-text">
                        <h4 class="text-light"><%= rs.getString("ItemName") %></h4>
                        <h5 class="text-light"> Rs.<%= rs.getString("ItemPrice") %></h5>
                    </div>
                </div>
            </div>
            <%
            }
            %>
        </div>
    </div>
</div>
<!-- End Products -->

<%@ include file="../footer.jsp" %>
