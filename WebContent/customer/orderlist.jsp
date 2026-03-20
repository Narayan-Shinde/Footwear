<%@page import="java.sql.ResultSet"%>
<%@ include file="../header.jsp"%>

<%
if(request.getParameter("did")!=null)
{
	db.execute("delete from Orders where OrderId=?",request.getParameter("did"));
	response.sendRedirect("orderlist.jsp");
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
<h1>Order History</h1>
<table>
<thead>
<tr>
<th>OrderNo</th>
<th>OrderDate</th>
<th>OrderAmount</th>
<th>OrderStatus</th>
<th>Actions</th>
</tr>
</thead>
<%
ResultSet rs=db.getRows("select * from Orders where UserName=?",session.getAttribute("user").toString());
while(rs.next())
{
%>
<tr>
<td><%=rs.getString(1) %></td>
<td><%=rs.getString(2) %></td>
<td><%=rs.getString(4) %></td>
<td><%=rs.getString(5) %></td>
<td>
<a href="showorder.jsp?id=<%=rs.getString(1)%>" class="btn btn-danger">View Order</a>
<a onclick="return confirm('Do you want to cancel order?');" href="?did=<%=rs.getString(1)%>" class="btn btn-danger">Cancel Order</a>
</td>
</tr>
<%
}
%>
<tr>
<%
rs=db.getRows("select sum(OrderAmount) from Orders where UserName=?", session.getAttribute("user").toString());
double sum=0;
if(rs.next())
	sum=rs.getDouble(1);
%>
<td colspan="4" align="right"><strong>Total Order Amount: <%=sum %></strong> </td>
<td></td>
</tr>
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