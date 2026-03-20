<%@page import="javazoom.upload.UploadBean"%>
<%@page import="javazoom.upload.UploadFile"%>
<%@page import="java.util.Hashtable"%>
<%@page import="javazoom.upload.MultipartFormDataRequest"%>
<%@page import="java.sql.ResultSet"%>
<%@ include file="../header.jsp"%>

<%
String id="",name="",desc="",catid="",price="",qty="",fname="",status="",msg="",btntext="Save";
//Check whether request is multipart request or not
if(MultipartFormDataRequest.isMultipartFormData(request))
{
	//Convert request object to multipartrequest object
	MultipartFormDataRequest mreq=new MultipartFormDataRequest(request);
	if(mreq.getParameter("btnsave")!=null)
	{
		id=mreq.getParameter("id");
		name=mreq.getParameter("name");
		desc=mreq.getParameter("desc");
		catid=mreq.getParameter("catid");
		price=mreq.getParameter("price");
		qty=mreq.getParameter("qty");
		status=mreq.getParameter("status");
		String opr=mreq.getParameter("btnsave");
		if(opr.equals("Save"))
		{
			//Upload file/Save as file on server			
			Hashtable ht=mreq.getFiles();
			UploadFile uf=(UploadFile) ht.get("photo"); //Object get(Object key)
			fname=uf.getFileName();
			
			
			UploadBean obj=new UploadBean();
			obj.setFolderstore(request.getRealPath("/itemimages/")); //returns phyiscal path of folder
			obj.store(mreq, "photo"); //Save as /Upload file
			//It reads file parameter data from mrequest and save that file at uploads folder
			db.execute("Insert into Item (ItemName,ItemDescription,CategoryId,ItemPrice,ItemQty,ItemImage,Status) values(?,?,?,?,?,?,?)", name,desc,catid,price,qty,fname,status);	
			msg="Item Record is Saved Successfully...";
			out.println("<script>alert('"+msg+"')</script>");
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
				obj.setFolderstore(request.getRealPath("/itemimages/")); //returns phyiscal path of folder
				obj.store(mreq, "photo"); //Save as /Upload file
				db.execute("Update Item set ItemName=?,ItemDescription=?,CategoryId=?,ItemPrice=?,ItemQty=?,ItemImage=?,Status=? where ItemId=?", name,desc,catid,price,qty,fname,status,id);
			}
			else
			{
				db.execute("Update Item set ItemName=?,ItemDescription=?,CategoryId=?,ItemPrice=?,ItemQty=?,Status=? where ItemId=?", name,desc,catid,price,qty,status,id);
			}	
			msg="Item Record is Updated Successfully...";
			out.println("<script>alert('"+msg+"')</script>");
		}
	}
}
else
{
	if(request.getParameter("eid")!=null)
	{
		id=request.getParameter("eid");
		ResultSet rs=db.getRows("select * from Item where ItemId=?",id);
		if(rs.next())
		{
			name=rs.getString(2);
			desc=rs.getString(3);
			catid=rs.getString(4);
			price=rs.getString(5);
			qty=rs.getString(6);
			fname=rs.getString(7);
			status=rs.getString(8);
			btntext="Update";
		}
	}
}
%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .item-container {
            max-width: 700px;
            margin: 30px auto;
            background: #fff;
            padding: 30px;
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
        textarea {
            height: 80px;
            resize: none;
        }
        .btn {
            border-radius: 5px;
            padding: 10px;
            font-size: 16px;
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
    <div class="container">
        <div class="item-container">
            <h1>Items Entry</h1>
            <form id="form1" name="form1" method="post" enctype="multipart/form-data">
                <input type="hidden" name="id" value="<%=id%>"/>

                <div class="mb-3">
                    <label class="form-label">Item Name</label>
                    <input type="text" name="name" class="form-control" required value="<%=name%>">
                </div>

                <div class="mb-3">
                    <label class="form-label">Item Description</label>
                    <textarea name="desc" class="form-control" required><%=desc%></textarea>
                </div>

                <div class="mb-3">
                    <label class="form-label">Category</label>
                    <select name="catid" class="form-control" required>
                        <option value="">-- Select Category --</option>
                        <%
                        ResultSet rs = db.getRows("SELECT * FROM category");
                        while (rs.next()) {
                        %>
                        <option <%=catid.equals(rs.getString(1)) ? "selected" : "" %> value="<%=rs.getString(1) %>"><%=rs.getString(2) %></option>
                        <%
                        }
                        %>
                    </select>
                </div>

                <div class="mb-3">
                    <label class="form-label">Item Price</label>
                    <input type="number" step="0.01" name="price" class="form-control" required value="<%=price%>">
                </div>

                <div class="mb-3">
                    <label class="form-label">Item Quantity</label>
                    <input type="number" name="qty" class="form-control" required value="<%=qty%>">
                </div>

                <div class="mb-3">
                    <label class="form-label">Item Image</label>
                    <input type="file" id="photo" name="photo" class="form-control" accept="image/*">
                    <img id="imgPreview" src="../itemimages/<%=fname%>" class="image-preview" alt="Item Image">
                </div>

                <div class="mb-3">
                    <label class="form-label">Status</label>
                    <select name="status" class="form-control" required>
                        <option value="">-- Select Status --</option>
                        <option <%=status.equals("available") ? "selected" : "" %> value="available">Available</option>
                        <option <%=status.equals("not available") ? "selected" : "" %> value="not available">Not Available</option>
                    </select>
                </div>

                <div class="mb-3">
                    <input type="submit" name="btnsave" class="btn btn-primary" value="<%=btntext%>">
                    <a href="item.jsp" class="btn btn-secondary">Clear</a>
                    <a href="itemlist.jsp" class="btn btn-secondary">Item List</a>
                </div>
            </form>
        </div>
    </div>
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
	
	
});

$(function(){
	$("#form1").validate({
		rules:{
			name:{
				required:true,
				pattern:/^[a-zA-Z ]+$/
			},
			desc:{
				required:true
			},
			catid:{
				required:true
			},
			price:{
				required:true,
				pattern:/^\d+(\.\d+)?$/
			},
			qty:{
				required:true,
				digits:true
			},
			status:{
				required:true
			}
		},
		messages:{
			name:{
				required:"Item Name is required",
				pattern:"Item Name allows only chars and spaces"
			},
			desc:{
				required:"Description is required",
				pattern:"Mobile No allows only 10 digits",
			},
			catid:{
				required:"Please select category"
			},
			price:{
				required:"Price is required",
				pattern:"Price must be numeric"
			},
			qty:{
				required:"Qty is Required",
				pattern:"Qty must be numeric"
			},
			status:{
				required:"Please select status.."
			}
		}
	});
});

</script>