<%@page import="com.shop.db.DataAccess"%>
<%
DataAccess db=new DataAccess();
%>
<!DOCTYPE html>
<html lang="en">
   <head>
      <!-- basic -->
      <meta charset="utf-8">
      <meta http-equiv="X-UA-Compatible" content="IE=edge">
      <!-- mobile metas -->
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <meta name="viewport" content="initial-scale=1, maximum-scale=1">
      <!-- site metas -->
      <title>Pullshoes</title>
      <meta name="keywords" content="">
      <meta name="description" content="">
      <meta name="author" content="">
      <!-- bootstrap css -->
      <link rel="stylesheet" href="/footware/css/bootstrap.min.css">
      <!-- style css -->
      <link rel="stylesheet" href="/footware/css/styles.css">
      <!-- Responsive-->
      <link rel="stylesheet" href="/footware/css/responsive.css">
      <!-- fevicon -->
      <link rel="icon" href="/footware/images/fevicon.png" type="image/gif" />
      <!-- Scrollbar Custom CSS -->
      <link rel="stylesheet" href="/footware/css/jquery.mCustomScrollbar.min.css">
      <!-- Tweaks for older IEs-->
      <link rel="stylesheet" href="https://netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css">
      <!-- owl stylesheets --> 
      <link rel="stylesheet" href="/footware/css/owl.carousel.min.css">
      <link rel="stylesheet" href="/footware/css/owl.theme.default.min.css">
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/fancybox/2.1.5/jquery.fancybox.min.css" media="screen">
      <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script><![endif]-->
          <style>
    label.error{ /* tag.class */
    	font-weight: bold;
    	color:red;
    }   
    .navbar-nav{
    background:black;
    } 
    </style>
      
   </head>
   <!-- body -->
   <body class="main-layout">
	<!-- header section start -->
	<div class="header_section">
		<div class="container">
			<div class="row">
				<div class="col-sm-3">
					<div class="logo"><a href="#"><img src="/footware/images/devansh.jpg"></a></div>
				</div>
				<div class="col-sm-9">
					<nav class="navbar navbar-expand-lg navbar-light bg-light">
                        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                        </button>
                   <%
                   
                   if(session.getAttribute("user")==null){
                   %>     
                    <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
                        <div class="navbar-nav">
                           <a class="nav-item nav-link" href="/footware/index.jsp">Home</a>
                          <a class="nav-item nav-link last" href="feedback.jsp">Contacts</a>
                           <a class="nav-item nav-link last" href="contact.jsp">Feedback</a>
                           <a class="nav-item nav-link" href="/footware/adminlogin.jsp">Admin</a>
                           <a class="nav-item nav-link" href="/footware/login.jsp">Customer</a>
                           <a class="nav-item nav-link" href="/footware/reg.jsp">Signup</a>
                        </div>
                    </div>
                    <%
                   }else if(session.getAttribute("user")!=null && session.getAttribute("user").toString().contains("admin")){
                    %>
                    <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
                        <div class="navbar-nav">
                           <a class="nav-item nav-link" href="/footware/admin/category.jsp">Category</a>
                           <a class="nav-item nav-link" href="/footware/admin/itemlist.jsp">Item</a>
                           <a class="nav-item nav-link" href="/footware/admin/orderlist.jsp">Order</a>
                           <a class="nav-item nav-link" href="/footware/admin/orderlist2.jsp">Order Sent</a>
                           <a class="nav-item nav-link" href="/footware/admin/reportlist.jsp">Report</a>
                           <a class="nav-item nav-link" href="/footware/admin/feedbacklist.jsp">Review</a>
                           <a class="nav-item nav-link" href="/footware/admin/customerlist.jsp">Customer</a>
                           <a class="nav-item nav-link" href="/footware/admin/cpassword.jsp">Change Pass</a>
                           <a class="nav-item nav-link" href="/footware/admin/logout.jsp">Logout</a>
                        </div>
                    </div>
                    <%
                   }else if(session.getAttribute("user")!=null && !session.getAttribute("user").toString().contains("admin")){
                    %>
                    <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
                        <div class="navbar-nav">
                        <a class="nav-item nav-link" href="/footware/customer/itemcat.jsp">Products</a>
                        	<a class="nav-item nav-link" href="/footware/customer/cart.jsp">Cart</a>
                        	<a class="nav-item nav-link" href="/footware/customer/orderlist.jsp">Order History</a>
                        	<a class="nav-item nav-link" href="/footware/customer/cpassword.jsp">ChangePassword</a>
                        	<a class="nav-item nav-link" href="/footware/customer/profile.jsp">Profile</a>                        	
                        	<a class="nav-item nav-link" href="/footware/customer/logout.jsp">Logout</a>                           
                        </div>
                    </div>
                    <%
                   }
                    %>
                    </nav>
				</div>
			</div>
		</div>



