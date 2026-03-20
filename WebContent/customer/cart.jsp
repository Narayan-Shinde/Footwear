<%@page import="java.sql.ResultSet"%>
<%@ include file="../header.jsp"%>

<%
if(request.getParameter("did")!=null)
{
	db.execute("delete from Cart where CartId=?",request.getParameter("did"));
	response.sendRedirect("cart.jsp");
}
if(request.getParameter("cartid")!=null)
{
	String cid=request.getParameter("cartid");
	String q=request.getParameter("q");
	db.execute("Update Cart set Qty=? where CartId=?",q,cid);
	response.sendRedirect("cart.jsp");
}
%>
<style>
section {
            margin: 0;
            font-family: Arial, sans-serif;
            background: linear-gradient(to right, #ff7e5f, #feb47b);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
        }
        .moneyorder {
            background: rgba(255, 255, 255, 0.9);
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.2);
            width: 100%;
            max-width: 1200px;
            color:black;
        }
        h1 {
            text-align: center;
            color: #333;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 10px;
            text-align: center;
            border: 1px solid black;
            border-radius: 10px;
        }
        th {
            background-color: #007bff;
            color: #fff;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        tr:hover {
            background-color: #ddd;
        }
</style>
<section>
<div class="moneyorder">
<h1>Shopping Cart</h1>
<table class="table table-bordered">
<thead>
<tr>
<th>ItemImage</th>
<th>ItemID</th>
<th>ItemName</th>
<th>Category</th>
<th>Item Price</th>
<th>Qty</th>
<th>Total</th>
<th>Actions</th>
</tr>
</thead>
<%
ResultSet rs=db.getRows("select * from CartView where UserName=?",session.getAttribute("user").toString());
int i=1;
boolean flag=false;
while(rs.next())
{
	flag=true;
%>
<tr>
<td><img src="../itemimages/<%=rs.getString(7) %>" width="60" height="60" alt="NA" class="rounded-circle"/></td>
<td><%=rs.getString(2) %></td>
<td><%=rs.getString(3) %></td>
<td><%=rs.getString(4) %></td>
<td><%=rs.getString(5) %></td>
<td><input type="text" value="<%=rs.getString(6) %>" id="q<%=i%>"/></td>
<td><%=rs.getDouble(5)*rs.getInt(6) %></td>
<td>
<a href="#" onclick="return updateQty(<%=rs.getString(1) %>,<%=i%>);" class="btn btn-info">Update</a>
<a onclick="return confirm('Do you want to remove from cart?');" href="?did=<%=rs.getString(1)%>" class="btn btn-danger">Delete</a>
</td>
</tr>
<%
i++;
}
if(!flag)
{
%>
<tr>
<td colspan="8" align="center"><strong>---- Cart is Empty ----</strong> </td>
</tr>
<%
}
else
{
%>
<tr>
<%
rs=db.getRows("select sum(itemprice*qty) from CartView where UserName=?", session.getAttribute("user").toString());
double sum=0;
if(rs.next())
	sum=rs.getDouble(1);
%>
<td colspan="7" align="right"><strong>Total Amount: <%=sum %></strong> </td>
<td><a href="checkout.jsp" class="btn btn-success">Checkout</a></td>
</tr>
<%
}
%>
</table>
</div>
</section>
<%@ include file="../footer.jsp"%>
<script>
function updateQty(cartid,i){
	var txt=document.getElementById("q"+i);
	var qty=txt.value;
	window.location="cart.jsp?cartid="+cartid+"&q="+qty;
	return false;
}

</script>