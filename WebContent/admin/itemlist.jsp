<%@page import="java.sql.ResultSet"%>
<%@ include file="../header.jsp"%>

<%
String msg="";
if(request.getParameter("did")!=null)
{
	String id=request.getParameter("did");
	db.execute("delete from Item where ItemId=?",id);
	msg="Item Category is removed from List";
	out.println("<script>alert('"+msg+"');</script>");
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
<h1>Items List</h1>
<a href="/footware/admin/item.jsp" class="btn btn-primary">Add New Item</a>
<table id="table1">
<thead>
<tr>
<th>Item ID</th>
<th>Item Name</th>
<th>Item Description</th>
<th>CategoryId</th>
<th>itemPrice</th>
<th>itemQty</th>
<th>itemImage</th>
<th>Status</th>
<th>Action</th>
</tr>
</thead>
<tbody>
<%
ResultSet rs=db.getRows("select * from ItemView");
while(rs.next())
{
%>
<tr>
<td><%=rs.getString("ItemId") %></td>
<td><%=rs.getString(2) %></td>
<td><%=rs.getString(3) %></td>
<td><%=rs.getString(4) %></td>
<td><%=rs.getString(5) %></td>
<td><%=rs.getString(6) %></td>
<td><img src="../itemimages/<%=rs.getString(8) %>" width="60" height="60" alt="NA" class="rounded-circle"/></td>
<td><%=rs.getString(8) %></td>
<td>
<a href="item.jsp?eid=<%=rs.getString(1) %>" class="btn btn-info">Edit</a>
<a onclick="return confirm('Do you want to remove item?');" href="?did=<%=rs.getString(1) %>" class="btn btn-danger">Delete</a>
</td>
</tr>
<%
}
%>
</tbody>
</table>

</div>
</section>
<%@ include file="../footer.jsp"%>
<script>
$(function(){ //ready
	
	$("#table1").DataTable();
});
</script>