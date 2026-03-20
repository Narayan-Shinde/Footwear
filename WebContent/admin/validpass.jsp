<%@page import="java.sql.ResultSet"%>
<%@page import="com.shop.db.DataAccess"%>
<%@ page trimDirectiveWhitespaces="true" language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%
String pass=request.getParameter("password");
String user=session.getAttribute("user")+"";
DataAccess db=new DataAccess();
ResultSet rs=db.getRows("select * from AdminLogin where UserName=? and Password=?", user,pass);
if(rs.next())
	out.println("true");
else
	out.println("false");

%>    
