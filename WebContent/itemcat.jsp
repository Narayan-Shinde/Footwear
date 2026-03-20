<%@page import="java.sql.ResultSet"%>
<%@include file="header.jsp" %>

<!-- Start Products  -->
    <div class="products-box">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="title-all text-center">
                        <h1>Fruits & Vegetables</h1>
                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed sit amet lacus enim.</p>
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
            	ResultSet rs=db.getRows("select * from ItemView where Categoryid=?",request.getParameter("id"));
            	while(rs.next())
            	{
				%>
                <div class="col-lg-3 col-md-6 special-grid best-seller">
                    <div class="products-single fix">
                        <div class="box-img-hover">
                            <div class="type-lb">
                                <p class="sale">Sale</p>
                            </div>
                            <img src="itemimages/<%=rs.getString(8) %>" class="img-fluid" alt="Image">
                            <div class="mask-icon">
                                <ul>
                                    <li><a href="#" data-toggle="tooltip" data-placement="right" title="View"><i class="fas fa-eye"></i></a></li>
                                    <li><a href="#" data-toggle="tooltip" data-placement="right" title="Compare"><i class="fas fa-sync-alt"></i></a></li>
                                    <li><a href="#" data-toggle="tooltip" data-placement="right" title="Add to Wishlist"><i class="far fa-heart"></i></a></li>
                                </ul>
                                <%
                                if(session.getAttribute("user")!=null)
                                {
                                %>
                                <a class="cart" href="customer/addtocart.jsp">Add to Cart</a>
                                <%
                                }
                                else
                                {
                                %>
                                <a class="cart" href="login.jsp?id=<%=rs.getString(1)%>">Add to Cart</a>
                                <%
                                }
                                %>
                            </div>
                        </div>
                        <div class="why-text">
                            <h4><%=rs.getString(2) %></h4>
                            <h5> <%=rs.getString(6) %></h5>
                        </div>
                    </div>
                </div>
                <%
            	}
                %>

            </div>
        </div>
    </div>
    <!-- End Products  -->

<%@ include file="footer.jsp" %>