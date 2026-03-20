<%@page import="java.sql.ResultSet"%>
<%@ include file="../header.jsp"%>

<%
String msg="";
if(request.getParameter("btnchange")!=null)
{
	String user=session.getAttribute("user")+"";
	String pass=request.getParameter("password");
	String pass1=request.getParameter("password1"); //new password
	
	db.execute("Update Customer set Password=? where EmailID=?",pass1,user);
	
	msg="Password changed successfully...";		

}

%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .password-container {
            max-width: 500px;
            margin: 50px auto;
            background: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            background-color: #f8f9fa;
        }
        h2 {
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
            background-color: #007bff;
            border: none;
        }
        .btn-primary:hover {
            background-color: #0056b3;
        }
        .error-text {
            color: red;
            font-size: 14px;
            display: none;
        }
    </style>
    <div class="container">
        <div class="password-container">
            <h2>CHANGE PASSWORD</h2>
            <p class="text-center text-muted">Update your account password</p>
            <form id="changePasswordForm" name="form1" method="post">
                <div class="mb-3">
                    <input type="password" class="form-control" id="oldPassword" name="password" placeholder="Enter Old Password" required>
                </div>
                <div class="mb-3">
                    <input type="password" class="form-control" id="newPassword" name="password1" placeholder="Enter New Password" required>
                    <small id="strengthText" class="text-muted"></small>
                </div>
                <div class="mb-3">
                    <input type="password" class="form-control" id="confirmPassword" name="password2" placeholder="Confirm New Password" required>
                    <small id="passwordError" class="error-text">Passwords do not match</small>
                </div>
                <button class="btn btn-primary" id="submit" type="submit" name="btnchange">Change Password</button>
            </form>
        </div>
    </div>
<%@ include file="../footer.jsp"%>
<script>
$("#sp").html("<%=msg%>");
$(function(){
	$("#form1").validate({
		rules:{			
			password:{
				required:true,
				minlength:5,
				remote:"validpass.jsp"
			},
			password1:{
				required:true,
				minlength:5
			},
			password2:{
				required:true,
				minlength:5,
				equalTo:"#password1"
			},
		},
		messages:{			
			password:{
				required:"Old Password is required",
				minlength:"Min length of Password 5 chars",
				remote:"Please enter valid old password"
			},
			password1:{
				required:"New Password is required",
				minlength:"Min length of Password 5 chars"
			},
			password2:{
				required:"Confirm Password is required",
				minlength:"Min length of Password 5 chars",
				equalTo:"Password mismatch"
			},
		}
	});
});
</script>