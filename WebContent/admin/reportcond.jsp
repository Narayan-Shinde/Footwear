<%@page import="java.sql.ResultSet"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ include file="../header.jsp"%>
<%
if(request.getParameter("btn1")!=null)
{
	String sdate=request.getParameter("sdate");
	String edate=request.getParameter("edate");
	Map<String,Object> map=new HashMap<>();
	map.put("sdate", sdate);
	map.put("edate", edate);
	session.setAttribute("pms", map);
	response.sendRedirect("report.jsp?rpt=orders2");
	//select * from  onlineshopdb.orders where OrderDate between  $P{sdate}  and   $P{edate} 
}
if(request.getParameter("btn2")!=null)
{
	String month1=request.getParameter("month1");
	String year1=request.getParameter("year1");
	Map<String,Object> map=new HashMap<>();
	map.put("month1", month1);
	map.put("year1", year1);
	session.setAttribute("pms", map);
	response.sendRedirect("report.jsp?rpt=orders2a");
	//select * from  onlineshopdb.orders where month(OrderDate)=$P{month1} and Year(orderdate)=$P{year1} 
}

if(request.getParameter("btn3")!=null)
{
	String ordno=request.getParameter("ordno");	
	Map<String,Object> map=new HashMap<>();
	map.put("order", ordno);	
	session.setAttribute("pms", map);
	response.sendRedirect("report2.jsp?rpt=OrderMaster");
	//select * from  onlineshopdb.orders where month(OrderDate)=$P{month1} and Year(orderdate)=$P{year1} 
}
%>

<form name="form1" method="post">
<%
if("datewise".equals(request.getParameter("style")))
{
%>
<table class="table table-bordered">
<tr>
<td colspan="5"><h3>DateWise Orders</h3></td>
</tr>
<tr>
<td>Start Date</td>
<td><input type="date" name="sdate" class="form-control"/></td>
<td>End Date</td>
<td><input type="date" name="edate" class="form-control"/></td>
<td><input type="submit" name="btn1" class="btn btn-primary" value="Show Report"/></td>
</tr>
</table>
<%
}
if("monthwise".equals(request.getParameter("style")))
{
%>
<table class="table table-bordered">
<tr>
<td colspan="5"><h3>Monthwise Orders</h3></td>
</tr>
<tr>
<td>Select Month</td>
<td>
<select name="month1" class="form-control">
<option value="1">Jan</option>
<option value="2">Feb</option>
<option value="3">Mar</option>
<option value="4">Apr</option>
<option value="5">May</option>
<option value="6">Jun</option>
<option value="7">Jul</option>
<option value="8">Aug</option>
<option value="9">Sept</option>
<option value="10">Oct</option>
<option value="11">Nov</option>
<option value="12">Dec</option>
</select>
</td>
<td>Year</td>
<td><input type="number" name="year1" class="form-control" value="<%=LocalDate.now().getYear()%>"/></td>
<td><input type="submit" name="btn2" class="btn btn-primary" value="Show Report"/></td>
</tr>
</table>
<%
}
%>
<%
if("specificorder".equals(request.getParameter("style")))
{
%>
<table class="table table-bordered">
<tr>
<td colspan="3"><h3>Specific Order</h3></td>
</tr>
<tr>
<td>Order No</td>
<td>
<select name="ordno" class="form-control">
<%
ResultSet rs=db.getRows("select OrderId from Orders");
while(rs.next())
{
%>
<option value="<%=rs.getString(1)%>"><%=rs.getString(1)%></option>
<%
}
%>
</select>
</td>
<td><input type="submit" name="btn3" class="btn btn-primary" value="Show Report"/></td>
</tr>
</table>
<%
}
%>
</form>

<%@ include file="../footer.jsp"%>