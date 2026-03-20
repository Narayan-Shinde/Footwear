<%@page import="com.shop.db.SMS"%>
<%@page import="com.shop.db.SendMail"%>
<%@page import="java.sql.ResultSet"%>
<%@ include file="header.jsp"%>

<%
String msg="";
String custid="", custname="", mobile="", user="", pass="", cpass="";
if(request.getParameter("btnsignup") != null) {
    custid = db.getID("CustId", "Customer");
    custname = request.getParameter("custname");
    mobile = request.getParameter("mobile");
    user = request.getParameter("username");
    pass = request.getParameter("password");
    cpass = request.getParameter("cpassword");
    try {
        db.execute("Insert into Customer values(?,?,?,?,?)", custid, custname, mobile, user, pass);
        session.setAttribute("user", user);
        session.setAttribute("custid", custid);
        response.sendRedirect("reg.jsp");
        msg = "Registration Successful";
    } catch(Exception ex){
        msg = "Error: " + ex.getMessage();
    }
}
%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .register-container {
            max-width: 600px;
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
        #password-error {
            color: red;
            font-size: 14px;
            display: none;
        }
    </style>
    <div class="container">
        <div class="register-container">
            <h2>CUSTOMER REGISTRATION</h2>
            <p class="text-center text-muted">Create your account</p>
            <form id="form1" name="form1" method="post">
                <div class="mb-3">
                    <input type="text" class="form-control" id="custname" name="custname" placeholder="Customer Name" required>
                </div>
                <div class="mb-3">
                    <input type="text" class="form-control" id="mobile" name="mobile" placeholder="Mobile No." required>
                </div>
                <div class="mb-3">
                    <input type="email" class="form-control" id="username" name="username" placeholder="Customer Email ID" required>
                </div>
                <div class="mb-3">
                    <input type="password" class="form-control" id="password" name="password" placeholder="Password" required>
                </div>
                <div class="mb-3">
                    <input type="password" class="form-control" id="cpassword" name="cpassword" placeholder="Confirm Password" required>
                    <small id="password-error">Passwords do not match</small>
                </div>
                <button class="btn btn-primary" id="submit" type="submit" name="btnsignup">Register</button>
            </form>
        </div>
    </div>
<%@ include file="footer.jsp"%>

<script>
$("#sp").html("<%=msg%>");

$(function() {
    $("#form1").validate({
        rules: {
            custname: {
                required: true,
                pattern: /^[a-zA-Z ]+$/
            },
            mobile: {
                required: true,
                pattern: /^\d{10}$/
            },
            username: {
                required: true,
                email: true,
                remote: "checkuser.jsp"
            },
            password: {
                required: true,
                minlength: 5
            },
            cpassword: {
                required: true,
                minlength: 5,
                equalTo: "#password"
            }
        },
        messages: {
            custname: {
                required: "Customer Name is required",
                pattern: "Customer Name allows only chars and spaces"
            },
            mobile: {
                required: "Mobile No is required",
                pattern: "Mobile No allows only 10 digits"
            },
            username: {
                required: "UserName is required",
                email: "Username should be a valid email",
                remote: "UserName/EmailID already exists"
            },
            password: {
                required: "Password is required",
                minlength: "Min length of Password is 5 chars"
            },
            cpassword: {
                required: "Confirm Password is required",
                minlength: "Min length of Confirm Password is 5 chars",
                equalTo: "Password Mismatch"
            }
        }
    });
});
</script>