<%@page import="com.shop.db.SendMail"%>
<%@page import="java.sql.ResultSet"%>
<%@ include file="../header.jsp"%>
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
<h1>Dispatched Order History</h1>
<table>
<thead>
<tr>
<th>OrderNo</th>
<th>OrderDate</th>
<th>UserName</th>
<th>OrderAmount</th>
<th>OrderStatus</th>
<th>Actions</th>
</tr>
</thead>
<%
ResultSet rs=db.getRows("select * from Orders where OrderStatus='Dispatched'");
boolean flag=false;
while(rs.next())
{	
%>
<tr>
<td><%=rs.getString(1) %></td>
<td><%=rs.getString(2) %></td>
<td><%=rs.getString(3) %></td>
<td><%=rs.getString(4) %></td>
<td><%=rs.getString(5) %></td>
<td>
<a href="showorder.jsp?id=<%=rs.getString(1)%>" class="btn btn-danger">View Order</a>
</td>
</tr>
<%
}
%>
<tr>
<%
rs=db.getRows("select sum(OrderAmount) from Orders where OrderStatus=?","Dispatched");
double sum=0;
if(rs.next())
	sum=rs.getDouble(1);
%>
<td colspan="5" align="right"><strong>Total Order Amount: <%=sum %></strong> </td>
<td></td>
</tr>
</table>
</div>
</section>
<%@ include file="../footer.jsp"%>
