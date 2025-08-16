<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.PahanaEdu.model.User" %>
<%
    HttpSession currentSession = request.getSession(false);
    if (currentSession == null || currentSession.getAttribute("loggedUser") == null) {
        response.sendRedirect("LoginPage.jsp");
        return;
    }

    User user = (User) currentSession.getAttribute("loggedUser");
    String username = user.getUsername();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>PahanaEdu - User Guide</title>
    <link rel="icon" type="image/png" href="images/PahanaEduLogo.png">
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

        .container {
            max-width: 900px;
            margin: 40px auto;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.5);
            color: white;
        }

        h2, h3 {
            color: #b3d4fc;
        }

        ul {
            line-height: 1.7;
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
                PahanaEdu - User Guide
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
            <li><a href="GenerateBill.jsp">Generate Bill</a></li>
            <li><a href="customer">Customer</a></li>
            <li><a href="item">Items</a></li>
            <li><a href="UserProfile.jsp">User Profile</a></li>
            <li><a href="Help.jsp">User Guide</a></li>
        </ul>
    </nav>

    <div class="container">
        <h2>Welcome to the PahanaEdu User Guide</h2>
        <p>This guide explains all the key functions of the PahanaEdu system for easy navigation and operation.</p>

        <h3>🔐 Login & Logout</h3>
        <ul>
            <li>Use your valid credentials to log in from the main login page.</li>
            <li>Click <strong>LOGOUT</strong> at any time to safely exit the system.</li>
        </ul>

        <h3>👤 User Profile</h3>
        <ul>
            <li>Access your profile via the <strong>User Profile</strong> tab.</li>
            <li>Update your full name, username, and optionally change your password.</li>
            <li>Leave password fields blank if no password change is needed.</li>
        </ul>

        <h3>📋 Customer Management</h3>
        <ul>
            <li>Navigate to <strong>Customer</strong> to view all customers.</li>
            <li>Search for customers by Name or NIC using the search box.</li>
            <li>Add new customers by clicking <strong>Add New Customer</strong>.</li>
            <li>Update customer details via the <strong>Update</strong> button.</li>
            <li>Delete a customer using the <strong>Delete</strong> button with confirmation.</li>
        </ul>

        <h3>📦 Item Management</h3>
        <ul>
            <li>Click <strong>Items</strong> in the navigation menu.</li>
            <li>Add new items with the item form, edit existing items, or delete items from the list.</li>
        </ul>

        <h3>🧾 Generate Bill</h3>
        <ul>
            <li>Go to <strong>Generate Bill</strong> from the top menu.</li>
            <li>Search items by product name or ID, then click <strong>Search</strong>.</li>
            <li>Enter the quantity and click <strong>➕ Add to Bill</strong>.</li>
            <li>The <strong>Bill Summary</strong> table displays all added items with line totals and overall total.</li>
            <li>Enter the <strong>Customer NIC</strong> and click <strong>Get Customer Name</strong> to fetch details.</li>
            <li>You can <strong>Remove</strong> items before submitting.</li>
            <li>Click <strong>✅ Submit Bill</strong> to save the bill in the system.</li>
        </ul>
        
        <h3>🧾 Bill History</h3>
		<ul>
		    <li>Access <strong>Bill History</strong> to see all previously generated bills.</li>
		    <li>Use the search box to find bills by Customer Name, NIC, or Total Amount.</li>
		    <li>Click <strong>Search</strong> to filter the results.</li>
		    <li>Click <strong>Clear</strong> to reset the search and show all bills.</li>
		    <li>Click <strong>View</strong> next to a bill to see full details of that bill on the <strong>Bill Details</strong> page.</li>
		    <li>The table displays each bill’s ID, customer name, NIC, total amount, and date.</li>
		</ul>        

        <h3>💡 Tips</h3>
        <ul>
            <li>Always verify item quantities and customer NIC before submitting a bill.</li>
            <li>Use the search features in Customer and Item pages to quickly locate records.</li>
            <li>Refer to this guide whenever you are unsure about system operations.</li>
        </ul>

        <h3>🆘 Support</h3>
        <ul>
            <li>For technical issues, contact the system administrator.</li>
            <li>This <strong>User Guide</strong> can always be accessed from the <strong>User Guide</strong> tab.</li>
        </ul>
    </div>

    <footer>
        &copy; 2025 PahanaEdu. All rights reserved.
    </footer>

</div>
</body>
</html>
