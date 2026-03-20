<%@page import="javazoom.upload.UploadBean"%>
<%@page import="javazoom.upload.UploadFile"%>
<%@page import="java.util.Hashtable"%>
<%@page import="javazoom.upload.MultipartFormDataRequest"%>
<%@page import="com.shop.db.SendMail"%>
<%@page import="java.sql.ResultSet"%>
<%@ include file="../header.jsp"%>

<%
String msg="";
String custid="",custname="",mobile="",user="";
String address="",gender="",bdate="",photo="";
if(MultipartFormDataRequest.isMultipartFormData(request))
{
	MultipartFormDataRequest mreq=new MultipartFormDataRequest(request);
	if(mreq.getParameter("btnsignup")!=null)
	{
		custid=mreq.getParameter("custid");
		custname=mreq.getParameter("custname");
		address=mreq.getParameter("custaddress");
		bdate=mreq.getParameter("bdate");
		gender=mreq.getParameter("gender");
		mobile=mreq.getParameter("mobile");
		user=mreq.getParameter("username");
		
		try
		{
			db.execute("Update Customer set CustName=?,MobileNo=? where CustId=?",custname,mobile,custid);
			ResultSet rs=db.getRows("select * from CustProfile where CustId=?", custid);
			if(rs.next())
			{
				Hashtable ht=mreq.getFiles();
				UploadFile uf=(UploadFile) ht.get("photo"); //Object get(Object key)
				photo=uf.getFileName();
				if(photo!=null)
				{							
					UploadBean obj=new UploadBean();
					obj.setFolderstore(request.getRealPath("/custimages/")); //returns phyiscal path of folder
					obj.store(mreq, "photo"); //Save as /Upload file
					db.execute("Update CustProfile set CustAddress=?,Gender=?,BirthDate=?,Photo=? where CustId=?",address,gender,bdate,photo,custid);
				}
				else
				{
					db.execute("Update CustProfile set CustAddress=?,Gender=?,BirthDate=? where CustId=?",address,gender,bdate,custid);
				}
				
			}
			else
			{
				//Upload file/Save as file on server			
				Hashtable ht=mreq.getFiles();
				UploadFile uf=(UploadFile) ht.get("photo"); //Object get(Object key)
				photo=uf.getFileName();
				
				
				UploadBean obj=new UploadBean();
				obj.setFolderstore(request.getRealPath("/custimages/")); //returns phyiscal path of folder
				obj.store(mreq, "photo"); //Save as /Upload file
				db.execute("Insert into CustProfile values(?,?,?,?,?)",custid,address,gender,bdate,photo);
			}
			msg="Profile Updated";
		}
		catch(Exception ex)
		{
			msg="Error: "+ex.getMessage();		
			
		}
	
}
}
else
{
	ResultSet rs=db.getRows("select * from Customer where EmailID=?", session.getAttribute("user")+"");
	if(rs.next())
	{
		custid=rs.getString(1);
		custname=rs.getString(2);
		mobile=rs.getString(3);
		user=rs.getString(4);
		rs=db.getRows("select * from CustProfile where CustId=?", custid);
		if(rs.next())
		{
			address=rs.getString(2);
			gender=rs.getString(3);
			bdate=rs.getString(4);
			photo=rs.getString(5);
			
		}
			
	}
	
}

%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .profile-container {
            max-width: 600px;
            margin: 50px auto;
            background: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            background-color: #f8f9fa;
        }
        }
        h2 {
            text-align: center;
            font-weight: bold;
            color: #333;
        }
        .form-control, .form-select {
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
        .profile-pic {
            display: block;
            width: 100px;
            height: 100px;
            border-radius: 50%;
            margin: 10px auto;
            object-fit: cover;
            border: 2px solid #ddd;
        }
        .file-label {
            font-size: 14px;
            color: #6c757d;
        }
    </style>
    <div class="container">
        <div class="profile-container">
            <h2>Update Profile</h2>
            <p class="text-center text-muted">Modify your personal details</p>
            <form id="updateProfileForm" name="form1" method="post" enctype="multipart/form-data">
                <input type="hidden" name="custid" value="<%=custid %>"/>

                <!-- Profile Image Preview -->
                <div class="text-center">
                    <img src="../custimages/<%=photo%>" id="profilePreview" class="profile-pic" alt="Profile Picture">
                </div>

                <div class="mb-3">
                    <label class="form-label">Customer Name</label>
                    <input type="text" class="form-control" id="custname" name="custname" required value="<%=custname%>">
                </div>

                <div class="mb-3">
                    <label class="form-label">Address</label>
                    <textarea class="form-control" id="custaddress" name="custaddress" required><%=address%></textarea>
                </div>

                <div class="mb-3">
                    <label class="form-label">Birthdate</label>
                    <input type="date" class="form-control" id="bdate" name="bdate" required value="<%=bdate%>">
                </div>

                <div class="mb-3">
                    <label class="form-label">Gender</label>
                    <select name="gender" class="form-select" required>
                        <option value="">-- Select Gender --</option>
                        <option <%=gender.equals("Male")?"selected":"" %> value="Male">Male</option>
                        <option <%=gender.equals("Female")?"selected":"" %> value="Female">Female</option>
                    </select>
                </div>

                <div class="mb-3">
                    <label class="form-label">Mobile No</label>
                    <input type="text" class="form-control" id="mobile" name="mobile" required value="<%=mobile%>">
                </div>

                <div class="mb-3">
                    <label class="form-label">Email ID</label>
                    <input type="text" class="form-control" id="username" name="username" required value="<%=user%>" readonly>
                </div>

                <div class="mb-3">
                    <label class="form-label file-label">Upload Profile Picture</label>
                    <input type="file" class="form-control" id="photo" name="photo" accept="image/*">
                </div>

                <button class="btn btn-primary" type="submit" name="btnsignup">Update Profile</button>
            </form>
        </div>
    </div>
<%@ include file="../footer.jsp"%>
<script>
$("#sp").html("<%=msg%>");

$(function(){
	$("#form1").validate({
		rules:{
			custname:{
				required:true,
				pattern:/^[a-zA-Z ]+$/
			},
			mobile:{
				required:true,
				pattern:/^\d{10}$/
			},
			username:{
				required:true,
				email:true				
			},
			password:{
				required:true,
				minlength:5
			},
			cpassword:{
				required:true,
				minlength:5,
				equalTo:"#password"
			}
		},
		messages:{
			custname:{
				required:"Customer Name is required",
				pattern:"Customer Name allows only chars and spaces"
			},
			mobile:{
				required:"Mobile No is required",
				pattern:"Mobile No allows only 10 digits",
			},
			username:{
				required:"UserName is required",
				email:"Username should be a valid email"
			},
			password:{
				required:"Password is required",
				minlength:"Min length of Password 5 chars"
			},
			cpassword:{
				required:"Confirm Password is Required",
				minlength:"Min length of Confirm Password 5 chars",
				equalTo:"Password Mismatch"
			}
		}
	});
});
</script>