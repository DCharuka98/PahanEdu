<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.PahanaEdu.model.Item, com.PahanaEdu.model.User" %>

<%
    if (session == null || session.getAttribute("loggedUser") == null) {
        response.sendRedirect("LoginPage.jsp");
        return;
    }

    User user = (User) session.getAttribute("loggedUser");
    String username = user.getUsername();
    
    Item item = (Item) request.getAttribute("item");
    if (item == null) {
        response.sendRedirect("item");
        return;
    }
%>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>PahanaEdu - Update Item</title>    
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
            background-color: rgba(0, 0, 0, 0.85);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        header {
            background-color: #003366;
            padding: 10px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo img {
            height: 60px;
        }

        .header-title {
            font-size: 26px;
            font-weight: bold;
            color: #fff;
        }

        .user-controls {
            text-align: right;
        }

        .user-info {
            font-size: 16px;
            margin-bottom: 5px;
        }

        .logout-btn {
            background-color: #ff4d4d;
            color: white;
            padding: 6px 12px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-weight: bold;
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
            color: #fff;
            text-decoration: none;
            font-weight: 600;
            font-size: 16px;
        }

        .container {
            max-width: 800px;
            margin: 40px auto;
            background-color: rgba(255, 255, 255, 0.05);
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.5);
        }

        h2 {
            text-align: center;
            margin-bottom: 30px;
        }

        form {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        label {
            font-weight: bold;
            color: #ccc;
        }

        input[type="text"],
        input[type="number"],
        textarea,
        input[type="file"] {
            padding: 10px;
            border-radius: 6px;
            border: none;
            font-size: 14px;
            width: 100%;
            box-sizing: border-box;
        }

        textarea {
            resize: vertical;
        }

        .btn {
            font-weight: bold;
            border: none;
            border-radius: 6px;
            text-align: center;
            text-decoration: none;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            padding: 12px;
        }

        .btn-update {
            background-color: #00cc66;
            color: white;
        }

        .btn-update:hover {
            background-color: #00994d;
        }

        .btn-cancel {
            background-color: #999;
            color: white;
        }

        .btn-cancel:hover {
            background-color: #777;
        }

        footer {
            text-align: center;
            padding: 15px;
            color: #ccc;
            background: rgba(0, 0, 0, 0.6);
            margin-top: auto;
        }
    </style>
</head>
<body>

<div class="overlay">
    <header>
        <div class="logo">
            <img src="images/PahanaEduLogo.png" alt="Logo">
        </div>

        <div class="header-title">Update Item</div>

        <div class="user-controls">
            <div class="user-info">👤 <%= username %></div>
            <form action="LogoutServlet" method="post">
                <button class="logout-btn">LOGOUT</button>
            </form>
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
        <h2>Update Item Details</h2>
        <form action="item" method="post" enctype="multipart/form-data">
		    <input type="hidden" name="action" value="update">
		    <input type="hidden" name="itemId" value="<%= item.getItemId() %>">
		
		    <label for="name">Item Name</label>
		    <input type="text" id="name" name="name" value="<%= item.getName() %>" required>
		
		    <label for="description">Description</label>
		    <textarea id="description" name="description" rows="4" required><%= item.getDescription() %></textarea>
		
		    <label for="price">Price (LKR)</label>
		    <input type="number" id="price" name="price" step="0.01" value="<%= item.getPrice() %>" required>
		
		    <label for="stock">Stock Quantity</label>
		    <input type="number" id="stock" name="stock" value="<%= item.getStockQuantity() %>" required>
		
		    <label for="image">Update Image (optional)</label>
		    <input type="file" id="image" name="image">
		
		    <div style="display: flex; gap: 20px; justify-content: center; margin-top: 20px;">
		        <button type="submit" class="btn btn-update">Update Item</button>
		        <a href="item" class="btn btn-cancel">Cancel</a>
		    </div>
		</form>
    </div>

    <footer>
        &copy; 2025 PahanaEdu. All rights reserved.
    </footer>
</div>

</body>
</html>
