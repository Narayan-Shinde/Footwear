<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.shop.db.DataAccess"%>
<%@page import="net.sf.jasperreports.engine.JasperCompileManager"%>
<%@page import="net.sf.jasperreports.engine.JasperReport"%>
<%@page import="net.sf.jasperreports.engine.JasperRunManager"%>
<%
DataAccess db=new DataAccess();
db.connectToServer(); //Open Connection
String rpt=request.getParameter("rpt")+".jrxml";
String fullpath=request.getRealPath("/admin/reports/"+rpt);
JasperReport rptobj=JasperCompileManager.compileReport(fullpath);

Map<String,Object> map=null;
if(session.getAttribute("pms")!=null)
{
	//Map is an interface and HashMap implements Map interface
	map=(HashMap<String,Object>)session.getAttribute("pms");
}

byte b[]=JasperRunManager.runReportToPdf(rptobj, map,db.cn);
response.setContentType("application/pdf");
response.setContentLength(b.length);
ServletOutputStream sos=response.getOutputStream();
sos.write(b); //write byte array to response
sos.flush(); //send data to browser
db.closeConnection(); //Close Connection

%>
