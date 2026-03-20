<%@page import="nl.captcha.Captcha"%>
<%@page import="com.shop.db.SMS"%>
<%@page import="com.shop.db.SendMail"%>
<%@page import="java.sql.ResultSet"%>
<%@ include file="header.jsp"%>

<%
String msg="";

if(request.getParameter("btn")!=null)
{

	String name=request.getParameter("name");
	String mobileno=request.getParameter("mobileno");
	String email=request.getParameter("email");
	String body=request.getParameter("msg");		
	db.execute("Insert into Contact (Name,Phone,Email,Message) values(?,?,?,?)", name,mobileno,email,body);
	msg="Information submitted";
		
	
}

%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .contact-container {
            max-width: 600px;
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
        textarea {
            height: 100px;
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
    </style>
    <div class="container">
        <div class="contact-container">
            <h2 class="shop_text mb-4">CONTACT US</h2>
            <form id="form1" name="form1" method="post">
                <div class="mb-3">
                    <input type="text" class="form-control" id="name" name="name" placeholder="Customer Name" required>
                </div>
                <div class="mb-3">
                    <input type="text" class="form-control" id="mobileno" name="mobileno" placeholder="Your Mobile No." required>
                </div>
                <div class="mb-3">
                    <input type="email" class="form-control" id="email" name="email" placeholder="Your Email ID" required>
                </div>
                <div class="mb-3">
                    <textarea name="msg" id="msg" class="form-control" placeholder="Enter Your Message" required></textarea>
                </div>
                <button class="btn btn-primary" id="submit" type="submit" name="btn">Submit</button>
            </form>
        </div>
    </div>
<%@ include file="footer.jsp"%>
<script>
$("#sp").html("<%=msg%>");

$(function(){
	$("#form1").validate({
		rules:{
			name:{
				required:true,
				pattern:/^[a-zA-Z ]+$/
			},
			msg:{
				required:true				
			},
			email:{
				required:true,
				email:true				
			}
			
		},
		messages:{
			name:{
				required:"Name is required",
				pattern:"Name allows only chars and spaces"
			},
			msg:{
				required:"Message is required"
			},
			email:{
				required:"UserName is required",
				email:"Username should be a valid email"
			}
		}
	});
});
</script>