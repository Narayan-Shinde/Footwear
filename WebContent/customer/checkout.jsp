<%@page import="java.sql.ResultSet"%>
<%@page import="com.shop.db.DataAccess"%>
<%
    // Simulate checkout page without PayPal
    DataAccess db = new DataAccess();
    String user = session.getAttribute("user").toString();

    String checkoutSummary = "<h2>Checkout Summary</h2>";
    checkoutSummary += "<table class='table table-bordered'><tr><th>Item Name</th><th>Price</th><th>Quantity</th></tr>";

    ResultSet rs = db.getRows("SELECT * FROM cartview WHERE UserName=?", user);
    int totalAmount = 0;
    while (rs.next()) {
        checkoutSummary += "<tr><td>" + rs.getString("ItemName") + "</td>";
        checkoutSummary += "<td>Rs." + rs.getString("ItemPrice") + "</td>";
        checkoutSummary += "<td>" + rs.getString("Qty") + "</td></tr>";

        totalAmount += rs.getInt("ItemPrice") * rs.getInt("Qty");
    }
    checkoutSummary += "</table>";
%>


    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">

    <div class="container mt-5">
        <h2 class="text-center">Dummy Checkout Page</h2>
        <div class="card p-4 shadow">
            <%= checkoutSummary %>
            <h4>Total Amount: Rs.<%= totalAmount %></h4>
            <form action="dummy_payment.jsp" method="post">
                <input type="hidden" name="user" value="<%= user %>">
                <input type="hidden" name="totalAmount" value="<%= totalAmount %>">
                <button type="submit" class="btn btn-success w-100">Proceed to Payment</button>
            </form>
        </div>
    </div>

