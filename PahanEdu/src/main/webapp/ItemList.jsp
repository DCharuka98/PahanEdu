<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.PahanaEdu.model.Item, com.PahanaEdu.model.User" %>

<%
    HttpSession currentSession = request.getSession(false);
    if (currentSession == null || currentSession.getAttribute("loggedUser") == null) {
        response.sendRedirect("LoginPage.jsp");
        return;
    }

    User user = (User) currentSession.getAttribute("loggedUser");
    String username = user.getUsername();

    List<Item> items = (List<Item>) request.getAttribute("items");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>PahanaEdu - Item List</title>
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
            background-color: rgba(0, 0, 0, 0.8);
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

        .controls {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 20px;
            margin: 30px auto 10px;
            flex-wrap: wrap;
        }

        .controls input[type="text"],
        .controls select {
            padding: 10px 14px;
            border-radius: 6px;
            border: none;
            font-size: 14px;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        
        .btn {
		    
		    font-weight: bold;
		    border: none;
		    border-radius: 6px;
		    text-align: center;
		    text-decoration: none;
		    display: inline-block;
		    font-size: 14px;
		    cursor: pointer;
		    min-width: 100px;
		    transition: background-color 0.3s ease;
		}
		
		/* Search button - red */
		.btn-search {
		    background-color: #ff4d4d;
		    color: white;
		    padding: 10px 20px;
		}
		
		.btn-search:hover {
		    background-color: #e04343;
		}
		
		/* Clear button - blue */
		.btn-clear {
		    background-color: #3399ff;
		    color: white;
		    padding: 9px 5px;
		}
		
		.btn-clear:hover {
		    background-color: #2a85db;
		}
		        

        h2 {
            text-align: center;
            font-size: 28px;
            margin-bottom: 20px;
        }

        .card-grid {
		    display: grid;
		    grid-template-columns: repeat(5, 1fr); /* Force exactly 5 columns */
		    gap: 30px;
		}

        .item-card {
            background-color: rgba(255, 255, 255, 0.08);
            border-radius: 12px;
            padding: 15px;
            text-align: center;
            transition: transform 0.3s;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.5);
        }

        .item-card:hover {
            transform: translateY(-6px);
        }

        .item-card img {
            width: 100%;
            height: 240px;
            object-fit: cover;
            border-radius: 8px;
            margin-bottom: 10px;
        }

        .item-card h3 {
            font-size: 18px;
            color: #fff;
            margin: 10px 0 6px;
        }

        .price {
            color: #66ccff;
            font-weight: bold;
            margin-bottom: 6px;
        }

        .desc {
            font-size: 14px;
            color: #ccc;
            margin-bottom: 8px;
            height: 40px;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .stock {
            font-size: 13px;
            color: #aaa;
        }

        .no-image {
            background-color: #444;
            height: 240px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #ccc;
            border-radius: 8px;
        }

        footer {
            text-align: center;
            padding: 15px;
            color: #ccc;
            background: rgba(0, 0, 0, 0.6);
            margin-top: 40px;
        }
    </style>
</head>
<body>

<div class="overlay">
    <!-- Header -->
    <header>
        <div class="logo">
            <img src="images/PahanaEduLogo.png" alt="Logo">
        </div>

        <div class="header-title">PahanaEdu - Item List</div>

        <div class="user-controls">
            <div class="user-info">👤 <%= username %></div>
            <form action="LogoutServlet" method="post">
                <button class="logout-btn">LOGOUT</button>
            </form>
        </div>
    </header>

    <!-- Navbar -->
    <nav class="navbar">
        <ul>
            <li><a href="home">Home</a></li>
            <li><a href="customer">Customer</a></li>
            <li><a href="ManageItems.jsp">Items</a></li>
            <li><a href="UserProfile.jsp">User Profile</a></li>
            <li><a href="Help.jsp">User Guide</a></li>
        </ul>
    </nav>

    <!-- Search & Filter -->
	<form action="item" method="get" class="controls">
	    <input type="text" name="query" placeholder="Search items..." value="<%= request.getParameter("query") != null ? request.getParameter("query") : "" %>">
	    <button type="submit" class="btn btn-search">Search</button>
		<a href="item" class="btn btn-clear">Clear</a>
	</form>


    <!-- Item Grid -->
    <div class="container">
        <h2>ITEM LIST</h2>

        <% if (items != null && !items.isEmpty()) { %>
            <div class="card-grid">
                <% for (Item item : items) { %>
                    <div class="item-card">
                        <% if (item.getImagePath() != null && !item.getImagePath().isEmpty()) { %>
                            <img src="<%= item.getImagePath() %>" alt="Book Cover">
                        <% } else { %>
                            <div class="no-image">No Image</div>
                        <% } %>

                        <h3><%= item.getName() %></h3>
                        <div class="price">LKR <%= String.format("%.2f", item.getPrice()) %></div>
                        <div class="desc"><%= item.getDescription() %></div>
                        <div class="stock">In Stock: <%= item.getStockQuantity() %></div>
                    </div>
                <% } %>
            </div>
        <% } else { %>
            <p style="text-align: center; color: #ccc;">No items found.</p>
        <% } %>
    </div>

    <!-- Footer -->
    <footer>
        &copy; 2025 PahanaEdu. All rights reserved.
    </footer>
</div>

</body>
</html>
