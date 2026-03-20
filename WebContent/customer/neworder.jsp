<%@page import="java.sql.ResultSet"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDate"%>
<%@page import="com.shop.db.DataAccess"%>
<%
DataAccess db=new DataAccess();
String user=request.getParameter("u");
session.setAttribute("user",user);
//Now we can create new order/bill for user => after payment

//Create new order
//Get Order Amount
ResultSet rs=db.getRows("select sum(ItemPrice*Qty) from CartView Where UserName=?", user);
double amt=0;
if(rs.next())
{
	amt=rs.getDouble(1);
}

int ordid=db.executeId("Insert into Orders (OrderDate,UserName,OrderAmount,OrderStatus) values(?,?,?,?)",LocalDate.now().format(DateTimeFormatter.ISO_DATE),user,amt+"","Paid");

//Store cart items in order items
rs=db.getRows("select * from CartView where UserName=?", user);
while(rs.next())
{
	db.execute("Insert into OrderItems values(?,?,?,?,?,?)", ordid+"",rs.getString("ItemId"),rs.getString("ItemName"),rs.getString("ItemPrice"),rs.getString("Qty"),(rs.getDouble("ItemPrice")*rs.getInt("Qty"))+"");
	db.execute("Update Item set ItemQty=ItemQty-? where ItemId=?",rs.getString("Qty"),rs.getString("ItemId"));
}

//Once order created, delete user items from cart
db.execute("delete from Cart where userName=?", user);
response.sendRedirect("showorder.jsp?id="+ordid);
%>