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
    <title>PahanaEdu - Home Page</title>
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

      
        .container {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
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

    <div class="container">
	    <div class="card"><a href="AddCustomer.jsp">➕ Add Customer</a></div>
	    <div class="card"><a href="customer">👥 View Customer</a></div>
	    <div class="card"><a href="AddItem.jsp">➕ Add Item</a></div>
	    <div class="card"><a href="item">📦 View Item</a></div>
	    <div class="card"><a href="GenerateBill.jsp">🧾 Generate Bill</a></div>
	    <div class="card"><a href="BillHistory.jsp">📜 View Bill History</a></div>
	    <div class="card"><a href="UserProfile.jsp">👤 User Profile</a></div>
	    <div class="card"><a href="Help.jsp">❓ User Guide</a></div>
	</div>

    <footer>
        &copy; 2025 PahanaEdu. All rights reserved.
    </footer>
</div>

</body>
</html>
