<%
session.removeAttribute("user");
session.invalidate();
response.sendRedirect("../adminlogin.jsp");
%>
