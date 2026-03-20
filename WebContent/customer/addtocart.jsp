<%@page import="com.shop.db.DataAccess"%>
<%
DataAccess db=new DataAccess();
if(session.getAttribute("itemid")!=null)
{
	String itemid=session.getAttribute("itemid").toString();
	String user=session.getAttribute("user").toString();
	
	db.execute("Insert into Cart (ItemId,Qty,UserName) values(?,?,?)",itemid,"1",user);
	response.sendRedirect("cart.jsp");

}
else if(request.getParameter("itemid")!=null)
{
	String itemid=request.getParameter("itemid");
	String user=session.getAttribute("user").toString();
	
	db.execute("Insert into Cart (ItemId,Qty,UserName) values(?,?,?)",itemid,"1",user);
	response.sendRedirect("cart.jsp");

}
%>