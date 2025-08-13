<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.PahanaEdu.model.User" %>
<%@ page import="com.PahanaEdu.model.Bill"%> 

<%
    HttpSession currentSession = request.getSession(false);
    if (currentSession == null || currentSession.getAttribute("loggedUser") == null) {
        response.sendRedirect("LoginPage.jsp");
        return;
    }

    User user = (User) currentSession.getAttribute("loggedUser");
    String username = user.getUsername();

    List<Bill> bills = (List<Bill>) request.getAttribute("bills");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>PahanaEdu - Home Page</title>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600&display=swap" rel="stylesheet">
    <style>
        /* Same styling as before */
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
            padding: 0;
        }

        header {
            background-color: rgba(0, 51, 102, 0.7);
            color: white;
            padding: 20px 20px;
            font-size: 24px;
            position: relative;
        }

        .user-info {
            position: absolute;
            top: 20px;
            right: 140px;
            font-size: 16px;
            font-weight: 500;
        }

        .logout-btn {
            position: absolute;
            right: 30px;
            top: 20px;
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

        .container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 25px;
            max-width: 1000px;
            margin: 40px auto;
            padding: 20px;
        }

        .card {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(8px);
            border-radius: 12px;
            padding: 30px;
            text-align: center;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.3);
            transition: 0.3s;
        }

        .card:hover {
            background-color: rgba(255, 255, 255, 0.2);
            transform: translateY(-5px);
        }

        .card a {
            text-decoration: none;
            color: #b3d4fc;
            font-size: 18px;
            font-weight: 600;
        }

        .bill-section {
            max-width: 1000px;
            margin: 0 auto;
            padding: 20px;
        }

        .bill-section table {
            width: 100%;
            border-collapse: collapse;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(6px);
            color: white;
            border-radius: 10px;
            overflow: hidden;
        }

        .bill-section th, .bill-section td {
            padding: 12px 16px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.2);
            text-align: left;
        }

        .bill-section th {
            background-color: rgba(0, 0, 0, 0.3);
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
        PahanaEdu System - Home Page
        <div class="user-info">👤 <%= username %></div>
        <form action="LogoutServlet" method="post" style="display:inline;">
            <button type="submit" class="logout-btn">LOGOUT</button>
        </form>
    </header>

    <div class="container">
        <div class="card"><a href="AddCustomer.jsp">➕ Add New Customer</a></div>
        <div class="card"><a href="EditCustomer.jsp">✏️ Edit Customer Info</a></div>
        <div class="card"><a href="ManageItems.jsp">📦 Manage Item Info</a></div>
        <div class="card"><a href="CalculateBill.jsp">🧾 Generate Bill</a></div>
        <div class="card"><a href="Help.jsp">❓ Help / User Guide</a></div>
    </div>

    <div class="bill-section">
        <h2 class="section-title">🧾 Last 5 Generated Bills</h2>
        <table>
            <thead>
                <tr>
                    <th>Bill ID</th>
                    <th>Customer Name</th>
                    <th>Date</th>
                    <th>Total Amount</th>
                </tr>
            </thead>
            <tbody>
            <%
                if (bills != null && !bills.isEmpty()) {
                    for (Bill bill : bills) {
            %>
                <tr>
                    <td>#<%= bill.getBillId() %></td>
                    <td><%= bill.getCustomerName() %></td>
                    <td><%= bill.getDate() %></td>
                    <td>Rs. <%= String.format("%.2f", bill.getTotalAmount()) %></td>
                </tr>
            <%
                    }
                } else {
            %>
                <tr>
                    <td colspan="4" style="text-align: center;">No recent bills available.</td>
                </tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>

    <footer>
        &copy; 2025 PahanaEdu. All rights reserved.
    </footer>
</div>

</body>
</html>
