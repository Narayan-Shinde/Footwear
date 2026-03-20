<%@page import="java.sql.ResultSet"%>
<%@page import="com.shop.db.DataAccess"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>

<%
    DataAccess db = new DataAccess();
    String user = request.getParameter("user");
    int totalAmount = Integer.parseInt(request.getParameter("totalAmount"));

    // Insert order into 'orders' table and get the OrderId
    int orderId = db.executeSqlId("INSERT INTO orders (OrderDate, UserName, OrderAmount, OrderStatus) VALUES (NOW(), ?, ?, 'Pending')", user, totalAmount);

    // Debugging: Check if OrderId is retrieved properly
    if (orderId == 0) {
        out.println("<h3>Error: OrderId not retrieved!</h3>");
    } else {
        // Insert order items into 'orderitems' table
        ResultSet rsCart = db.getRows("SELECT * FROM cartview WHERE UserName=?", user);
        while (rsCart.next()) {
            db.executeSql("INSERT INTO orderitems (OrderId, ItemId, ItemName, ItemPrice, Qty) VALUES (?,?,?,?,?)",
                    orderId, rsCart.getString("ItemId"), rsCart.getString("ItemName"), 
                    rsCart.getInt("ItemPrice"), rsCart.getInt("Qty"));
        }

        // Clear user's cart after order is placed
        db.executeSql("DELETE FROM cart WHERE UserName=?", user);
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Payment Confirmation</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5 text-center">
        <h2>Payment Successful</h2>
        <p>Thank you, <strong><%= user %></strong>!</p>
        <p>Your order <strong>#<%= orderId %></strong> has been placed successfully.</p>
        <p>Order Amount: <strong>Rs.<%= totalAmount %></strong></p>
        <a href="itemcat.jsp" class="btn btn-primary">Back to Shop</a>
    </div>
</body>
</html>
