<%@page import="java.sql.ResultSet"%>
<%@page import="com.shop.db.DataAccess"%>
<%@ page trimDirectiveWhitespaces="true" language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%
String user=request.getParameter("username");
DataAccess db=new DataAccess();
ResultSet rs=db.getRows("select * from Customer where EmailID=?", user);
if(rs.next())
	out.println("false");
else
	out.println("true");

%>    
