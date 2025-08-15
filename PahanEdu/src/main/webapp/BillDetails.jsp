<%@ page import="java.sql.*, com.PahanaEdu.dao.DBConnection" %>
<%@ page import="com.PahanaEdu.model.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    HttpSession currentSession = request.getSession(false);
    if (currentSession == null || currentSession.getAttribute("loggedUser") == null) {
        response.sendRedirect("LoginPage.jsp");
        return;
    }

    User user = (User) currentSession.getAttribute("loggedUser");
    String username = user.getUsername();

    String billIdParam = request.getParameter("billId");
    int billId = 0;
    if (billIdParam != null) {
        try {
            billId = Integer.parseInt(billIdParam);
        } catch (NumberFormatException e) {
            billId = 0;
        }
    }

    Connection conn = null;
    PreparedStatement psBill = null;
    PreparedStatement psItems = null;
    ResultSet rsBill = null;
    ResultSet rsItems = null;

    String customerName = "";
    String nic = "";
    double totalAmount = 0;
    java.sql.Date billDate = null;
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Bill Details</title>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Montserrat', sans-serif;
            background: url('images/backgroundImage.jpg') no-repeat center center fixed;
            background-size: cover;
            margin: 0;
            padding: 0;
            color: white;
        }

        .overlay {
            background-color: rgba(18, 27, 40, 0.85);
            min-height: 100vh;
        }

        header {
            background-color: rgba(0, 51, 102, 0.7);
            color: white;
        }

        .header-container {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 10px 30px;
        }

        .logo img {
            height: 80px;
            width: auto;
        }

        .header-title {
            text-align: center;
            font-size: 28px;
            font-weight: bold;
            flex-grow: 1;
        }

        .user-controls {
            display: flex;
            flex-direction: column;
            align-items: flex-end;
        }

        .user-info {
            font-size: 16px;
            font-weight: 500;
            margin-bottom: 5px;
        }

        .logout-btn {
            background: #ff6666;
            color: white;
            font-weight: bold;
            border: none;
            padding: 8px 14px;
            border-radius: 6px;
            cursor: pointer;
        }

        .logout-btn:hover {
            background: #cc3333;
        }

        .navbar {
            margin-top: 10px;
            border-radius: 8px;
            background-color: rgba(0, 51, 102, 0.7);
        }

        .navbar ul {
            list-style-type: none;
            padding: 10px 0;
            margin: 0;
            display: flex;
            justify-content: center;
            gap: 40px;
        }

        .navbar li {
            display: inline;
        }

        .navbar a {
            color: #b3d4fc;
            text-decoration: none;
            font-weight: 600;
            font-size: 16px;
            padding: 8px 12px;
            border-radius: 6px;
            transition: background-color 0.3s;
        }

        .navbar a:hover {
            background-color: rgba(255, 255, 255, 0.2);
        }
        h2 {
            margin-top: 20px;
            margin-left: 20px;
        }
        table {
            width: 95%;  
            margin-left: 35px;          
            margin-top: 20px;
            background: white;
            color: black;
            border-collapse: collapse;
        }
        th, td {
        
            border: 1px solid #ccc;
            padding: 10px;
            text-align: center;
        }
        tr:hover {
            background: #f2f2f2;
        }
        .bill-info p {
		    margin-left: 35px;
		}
        .btn-back {
            background: #33ccff;
            padding: 8px 14px;
            border-radius: 6px;
            color: white;
            text-decoration: none;
            display: inline-block;
            margin-top: 20px;
            margin-left: 20px;
        }
        footer {
            text-align: center;
            padding: 15px;
            color: #ccc;
            background: rgba(0, 0, 0, 0.4);
        }
    </style>
</head>
<body>
<div class="overlay">
   <header>
        <div class="header-container">
            <div class="logo">
                <img src="images/PahanaEduLogo.png" alt="PahanaEdu Logo">
            </div>

            <div class="header-title">
                PahanaEdu - Home Page
            </div>

            <div class="user-controls">
                <div class="user-info">👤 <%= username %></div>
                <form action="LogoutServlet" method="post">
                    <button type="submit" class="logout-btn">LOGOUT</button>
                </form>
            </div>
        </div>

    </header>

    <nav class="navbar">
        <ul>
            <li><a href="home">Home</a></li>
            <li><a href="customer">Customer</a></li>
            <li><a href="item">Items</a></li>
            <li><a href="UserProfile.jsp">User Profile</a></li>
            <li><a href="Help.jsp">User Guide</a></li>
        </ul>
    </nav>

<%
    try {
        if (billId > 0) {
            conn = DBConnection.getInstance().getConnection();

            // Fetch bill + customer info
            String sqlBill = "SELECT b.bill_id, b.total_amount, b.bill_date, c.name, c.nic " +
                             "FROM bill b JOIN customer c ON b.customer_id = c.customer_id " +
                             "WHERE b.bill_id = ?";
            psBill = conn.prepareStatement(sqlBill);
            psBill.setInt(1, billId);
            rsBill = psBill.executeQuery();
            if (rsBill.next()) {
                customerName = rsBill.getString("name");
                nic = rsBill.getString("nic");
                totalAmount = rsBill.getDouble("total_amount");
                billDate = rsBill.getDate("bill_date");
            }

            // Fetch bill items
            String sqlItems = "SELECT i.name, bi.quantity, bi.item_price " +
                              "FROM bill_items bi JOIN item i ON bi.item_id = i.item_id " +
                              "WHERE bi.bill_id = ?";
            psItems = conn.prepareStatement(sqlItems);
            psItems.setInt(1, billId);
            rsItems = psItems.executeQuery();
        }
    } catch (Exception e) {
        out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
    }
%>

    <div class="bill-info">
    <h2>Bill Information</h2>
    <p><strong>Bill ID:</strong> <%= billId %></p>
    <p><strong>Customer Name:</strong> <%= customerName %></p>
    <p><strong>NIC:</strong> <%= nic %></p>
    <p><strong>Date:</strong> <%= billDate %></p>
    <p><strong>Total Amount (Rs.):</strong> <%= String.format("%.2f", totalAmount) %></p>
</div>


    <h2>Bill Items</h2>
    <table>
        <tr>
            <th>Item Name</th>
            <th>Quantity</th>
            <th>Item Price (Rs.)</th>
            <th>Subtotal (Rs.)</th>
        </tr>
        <%
            double grandTotal = 0;
            if (rsItems != null) {
                while (rsItems.next()) {
                    double price = rsItems.getDouble("item_price");
                    int qty = rsItems.getInt("quantity");
                    double subtotal = price * qty;
                    grandTotal += subtotal;
        %>
        <tr>
            <td><%= rsItems.getString("name") %></td>
            <td><%= qty %></td>
            <td><%= String.format("%.2f", price) %></td>
            <td><%= String.format("%.2f", subtotal) %></td>
        </tr>
        <%
                }
            }
        %>
        <tr>
            <th colspan="3">Grand Total</th>
            <th><%= String.format("%.2f", grandTotal) %></th>
        </tr>
    </table>

    <a href="BillHistory.jsp" class="btn-back">⬅ Back to Bill History</a>

<%
    if (rsBill != null) rsBill.close();
    if (rsItems != null) rsItems.close();
    if (psBill != null) psBill.close();
    if (psItems != null) psItems.close();
    if (conn != null) conn.close();
%>

 <footer>
        &copy; 2025 PahanaEdu. All rights reserved.
    </footer>
</div>
</body>
</html>
