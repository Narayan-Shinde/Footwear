<%@page import="javazoom.upload.UploadBean"%>
<%@page import="javazoom.upload.UploadFile"%>
<%@page import="java.util.Hashtable"%>
<%@page import="javazoom.upload.MultipartFormDataRequest"%>
<%@page import="java.sql.ResultSet"%>
<%@ include file="../header.jsp"%>

<%
String id="",name="",msg="",btntext="Save",fname="";
//Check whether request is multipart request or not
if(MultipartFormDataRequest.isMultipartFormData(request))
{
	//Convert request object to multipartrequest object
	MultipartFormDataRequest mreq=new MultipartFormDataRequest(request);
	if(mreq.getParameter("btnsave")!=null)
	{
		id=mreq.getParameter("id");
		name=mreq.getParameter("name");
		if(mreq.getParameter("btnsave").equals("Save"))
		{
			//Upload file/Save as file on server			
			Hashtable ht=mreq.getFiles();
			UploadFile uf=(UploadFile) ht.get("photo"); //Object get(Object key)
			fname=uf.getFileName();
			
			
			UploadBean obj=new UploadBean();
			obj.setFolderstore(request.getRealPath("/catimages/")); //returns phyiscal path of folder
			obj.store(mreq, "photo"); //Save as /Upload file
			db.execute("Insert into Category (CategoryName,CategoryImage) values(?,?)",name,fname);
			msg="Category is saved in List";
			out.println("<script>alert('"+msg+"');</script>");
		}
		else
		{
			//Upload file/Save as file on server			
			Hashtable ht=mreq.getFiles();
			UploadFile uf=(UploadFile) ht.get("photo"); //Object get(Object key)
			fname=uf.getFileName();
			if(fname!=null)
			{
				//if file is not empty then upload file
				UploadBean obj=new UploadBean();
				obj.setFolderstore(request.getRealPath("/catimages/")); //returns phyiscal path of folder
				obj.store(mreq, "photo"); //Save as /Upload file
				db.execute("Update Category set CategoryName=?,CategoryImage=? where CategoryId=?",name,fname,id);
			}
			else
			{
				db.execute("Update Category set CategoryName=? where CategoryId=?",name,id);
			}
			msg="Category is updated in List";
			out.println("<script>alert('"+msg+"');</script>");
		}
		name="";id="";btntext="Save";fname="";
	}
}
else
{
	if(request.getParameter("eid")!=null)
	{
		id=request.getParameter("eid");
		ResultSet rs=db.getRows("select * from Category where CategoryId=?",id);
		if(rs.next())
		{
			name=rs.getString(2);
			fname=rs.getString(3);
			btntext="Update";
		}
	}
	else if(request.getParameter("did")!=null)
	{
		String id2=request.getParameter("did");
		db.execute("delete from Category where CategoryId=?",id2);
		msg="Item Category is removed from List";
		out.println("<script>alert('"+msg+"');</script>");
	}
}
%>
<style>
section {
            margin: 0;
            font-family: Arial, sans-serif;
            background: linear-gradient(to right, #ff7e5f, #feb47b);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 120vh;
        }
        .moneyorder {
            background: rgba(255, 255, 255, 0.9);
            padding: 10px;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.2);
            width: 100%;
            max-width: 1400px;
            color:black;
        }
        h1 {
            text-align: center;
            color: #333;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 10px;
            text-align: center;
            border: 1px solid black;
            border-radius: 10px;
        }
        th {
            background-color: #007bff;
            color: #fff;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        tr:hover {
            background-color: #ddd;
        }
        .category-container {
            max-width: 500px;
            margin: 10px auto;
            background: #fff;
            padding: 10px;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            background-color: #f8f9fa;
        }
        h1 {
            text-align: center;
            font-weight: bold;
            color: #333;
        }
        .form-control {
            border-radius: 5px;
            height: 45px;
        }
        .btn {
            border-radius: 5px;
            padding: 10px;
            font-size: 16px;
            width: 48%;
        }
        .btn-primary {
            background-color: #007bff;
            border: none;
        }
        .btn-primary:hover {
            background-color: #0056b3;
        }
        .btn-secondary {
            background-color: #6c757d;
            border: none;
        }
        .btn-secondary:hover {
            background-color: #545b62;
        }
        .image-preview {
            display: block;
            width: 80px;
            height: 80px;
            border-radius: 10px;
            margin-top: 10px;
            object-fit: cover;
            border: 2px solid #ddd;
        }
    </style>
<section>
    <div class="container">
        <div class="category-container">
            <h1>Category</h1>
            <form id="form1" name="form1" method="post" enctype="multipart/form-data">
                <input type="hidden" name="id" value="<%=id%>"/>

                <div class="mb-3">
                    <label class="form-label">Category Name</label>
                    <input type="text" name="name" class="form-control" required value="<%=name%>">
                </div>

                <div class="mb-3">
                    <label class="form-label">Category Image</label>
                    <input type="file" id="photo" name="photo" class="form-control" accept="image/*">
                    <img id="imgPreview" src="../catimages/<%=fname%>" class="image-preview" alt="Category Image">
                </div>

                <div class="d-flex justify-content-between">
                    <input type="submit" name="btnsave" class="btn btn-primary" value="<%=btntext%>">
                    <a href="category.jsp" class="btn btn-secondary">Clear</a>
                </div>
            </form>
        </div>
    </div>
<div class="moneyorder">
<h1>Cateogry List</h1>
<table id="table1">
<thead>
<tr>
<th>Category ID</th>
<th>Category Name</th>
<th>Category Image</th>
<th>Actions</th>
</tr>
</thead>
<tbody>
<%
ResultSet rs=db.getRows("select * from Category");
while(rs.next())
{
%>
<tr>
<td><%=rs.getString(1) %></td>
<td><%=rs.getString(2) %></td>
<td><img src="../catimages/<%=rs.getString(3) %>" width="60" height="60" alt="NA" class="rounded-circle"/></td>
<td>
<a href="?eid=<%=rs.getString(1) %>" class="btn btn-info">Edit</a>
<a href="?did=<%=rs.getString(1) %>" class="btn btn-danger">Delete</a>
</td>
</tr>
<%
}
%>
</tbody>
</table>

</div>
</div>
</section>
<%@ include file="../footer.jsp"%>
<script>
$(function(){ //ready
	
	$("#photo").change(function(){
		//this ==> refers to current object==> file object
		if (this.files && this.files[0]) {
		    var reader = new FileReader(); //Create an object of FileReader class
		    
		    reader.onload = function(e) {
		      $('#imgid').attr("src", e.target.result); //returns selected file binary data
		    };
		    
		    reader.readAsDataURL(this.files[0]);
		    //On file read complete, reader generates onload event
		  }
	});
	
	$("#table1").DataTable();
	//word chars ==> \w means a to z, A to Z, 0 to 9, _ ,.
	$("#form1").validate({
		rules:{
			name:{
				required:true,
				pattern:/^\w+$/  
			}
		},
		messages:{
			name:{
				required:"Category Name is required",
				pattern:"Category Name allows only chars and spaces"
			}
		}
	});
});
</script>