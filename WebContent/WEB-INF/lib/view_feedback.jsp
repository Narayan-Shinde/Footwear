<%@ page import="java.sql.*" %>
<%@ include file="view_feedback.jsp " %> <!-- Ensure this file connects to your database -->

<html>
<head>
    <title>View Feedback</title>
    <style>
        table {
            width: 80%;
            margin: auto;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid black;
            padding: 10px;
            text-align: center;
        }
        th {
            background-color: #f4f4f4;
        }
        .container {
            text-align: center;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Feedback List</h2>
        <table>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Phone</th>
                <th>Email</th>
                <th>Message</th>
                <th>Date</th>
            </tr>
            <%
                try {
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/footdb", "root", "sahil");
                    Statement stmt = con.createStatement();
                    ResultSet rs = stmt.executeQuery("SELECT * FROM Contact ORDER BY Created_At DESC");

                    while (rs.next()) {
            %>
            <tr>
                <td><%= rs.getInt("ID") %></td>
                <td><%= rs.getString("Name") %></td>
                <td><%= rs.getString("Phone") %></td>
                <td><%= rs.getString("Email") %></td>
                <td><%= rs.getString("Message") %></td>
                <td><%= rs.getTimestamp("Created_At") %></td>
            </tr>
            <%
                    }
                    con.close();
                } catch (Exception e) {
                    out.println("<tr><td colspan='6'>Error: " + e.getMessage() + "</td></tr>");
                }
            %>
        </table>
    </div>
</body>
</html>
<%@ page import="java.sql.*" %>
<%
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection db = DriverManager.getConnection("jdbc:mysql://localhost:3306/footdb", "root", "sahil");
%>
