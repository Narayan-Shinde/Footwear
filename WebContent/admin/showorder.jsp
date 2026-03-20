<%@page import="java.sql.ResultSet"%>
<%@page import="com.shop.db.DataAccess"%>
<%
DataAccess db=new DataAccess(); 
String id=request.getParameter("id");
ResultSet rs=db.getRows("select * from Orders where OrderId=?", id);
rs.next();
%>
<link href="../css/bootstrap.min.css" rel="stylesheet"/>
<h2 align="center">Your Order</h2>
<hr>
<br>
<table class="table table-bordered">
<tr>
<td colspan="4" align="center"><h4>Order Information</h4></td>
</tr>
<tr>
<td>Order No</td><td><%=rs.getString(1) %></td>
<td>Order Date</td><td><%=rs.getString(2) %></td>
</tr>
<tr>
<td>Order Amount</td><td><%=rs.getString(4) %></td>
<td>Order Status</td><td><%=rs.getString(5) %></td>
</tr>
<tr>
<%
rs=db.getRows("select * from Customer where EmailID=?", rs.getString(3));
rs.next();
%>
<td>Customer</td><td><%=rs.getString(2)+"("+rs.getString(1)+")" %></td>
<td>Mobile No</td><td><%=rs.getString(3) %></td>
</tr>
</table>
<table class="table table-bordered">
<tr>
<td colspan="5" align="center"><h4>Order Items</h4></td>
</tr>
<tr>
<td>Item ID</td>
<td>Item Name</td>
<td>Item Price</td>
<td>Item Qty</td>
<td>Total Amount</td>
</tr>
<%
rs=db.getRows("select * from OrderItems where OrderId=?", id);
while(rs.next())
{
%>
<tr>
<td><%=rs.getString(2) %></td>
<td><%=rs.getString(3) %></td>
<td><%=rs.getString(4) %></td>
<td><%=rs.getString(5) %></td>
<td><%=rs.getString(6) %></td>
</tr>
<%
}
%>
<tr>

</table>

<button type="button" onclick="window.print();" class="btn btn-primary">Print Order</button>
<button type="button" onclick="window.location='orderlist.jsp';" class="btn btn-primary">Back to Orders History</button>

