<%@page import="java.sql.ResultSet"%>
<%@ include file="header.jsp"%>

<%
String msg="";
if(request.getParameter("btnlogin")!=null)
{
	String user=request.getParameter("username");
	String pass=request.getParameter("password");
	
	ResultSet rs=db.getRows("select * from Customer where EmailID=? and Password=?", user,pass);
	if(rs.next())
	{
		session.setAttribute("user", user);
		if(session.getAttribute("itemid")!=null)
			response.sendRedirect("/footware/customer/addtocart.jsp");
		else
			response.sendRedirect("index.jsp");
	}
	else
	{
		//out.println("<script>alert('Login failed...try again...');</script>");
		msg="Login Failed.. try again...";		
	}
}
else
{
	if(request.getParameter("id")!=null)
	{
		session.setAttribute("itemid",request.getParameter("id"));		
	}
}

%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .login-container {
            max-width: 400px;
            margin: 80px auto;
            background: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            background-color: #f8f9fa;
        }
        .shop_text {
            text-align: center;
            font-weight: bold;
            color: #333;
        }
        .form-control {
            border-radius: 5px;
            height: 45px;
        }
        .btn-primary {
            width: 100%;
            border-radius: 5px;
            padding: 10px;
            font-size: 16px;
            transition: 0.3s;
        }
        .btn-primary:hover {
            background-color: #0056b3;
        }
    </style>
    <div class="container">
        <div class="login-container">
            <h2 class="shop_text mb-4">CUSTOMER LOGIN</h2>
            <form id="form1" name="form1" method="post">
                <div class="mb-3">
                    <input type="text" class="form-control" id="username" name="username" placeholder="Customer Username" required>
                </div>
                <div class="mb-3">
                    <input type="password" class="form-control" id="password" name="password" placeholder="Customer Password" required>
                </div>
                <button class="btn btn-primary" id="submit" type="submit" name="btnlogin">Login</button>
            </form>
        </div>
    </div>
<%@ include file="footer.jsp"%>
<script>
$("#sp").html("<%=msg%>");
$(function(){
	$("#form1").validate({
		rules:{
			username:{
				required:true,
				email:true
			},
			password:{
				required:true,
				minlength:5
			}
		},
		messages:{
			username:{
				required:"UserName is required",
				email:"Username should be a valid email"
			},
			password:{
				required:"Password is required",
				minlength:"Min length of Password 5 chars"
			}
		}
	});
});
</script>