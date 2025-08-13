<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.PahanaEdu.model.Customer, com.PahanaEdu.model.User" %>

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
    <title>Customer List - PahanaEdu</title>
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
            display: flex;
            flex-direction: column;
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
            font-weight: bold !important;
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
            max-width: 1000px;
            margin: 40px auto;
            padding: 30px;
            background-color: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(4px);
            border-radius: 12px;
            flex-grow: 1;
        }

        h2 {
            text-align: center;
            margin-bottom: 30px;
            color: #ffffff;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: rgba(0, 0, 0, 0.1);
        }

        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid rgba(255, 255, 255, 0.2);
            color: white;
        }

        th {
            background-color: rgba(0, 51, 102, 0.8);
        }

        tr:hover {
            background-color: rgba(255, 255, 255, 0.1);
        }

        .back-link {
            display: block;
            text-align: center;
            margin-top: 20px;
            color: #a3c4f3;
            text-decoration: none;
            font-weight: 600;
        }

        .back-link:hover {
            text-decoration: underline;
        }

        .action-buttons {
            display: flex;
            gap: 10px;
            align-items: center;
        }

        .action-btn {
            background-color: #007bff;
            color: white;
            font-weight: 600;
            border: none;
            padding: 8px 14px;
            border-radius: 6px;
            cursor: pointer;
            font-family: 'Montserrat', sans-serif;
            font-size: 14px;
            text-decoration: none;
        }

        .action-btn:hover {
            background-color: #0056b3;
        }

        .action-btn.delete {
            background-color: #ff6666;
        }

        .action-btn.delete:hover {
            background-color: #cc3333;
        }

        footer {
            text-align: center;
            padding: 15px;
            color: #ccc;
            background: rgba(0, 0, 0, 0.4);
        }

        form.search-form input[type="text"] {
            padding: 8px;
            width: 250px;
            border-radius: 6px;
            border: none;
        }

        form.search-form button {
            padding: 8px 14px;
            border-radius: 6px;
            background-color: #00509e;
            color: white;
            border: none;
            cursor: pointer;
            font-weight: 600;
        }

        form.search-form button:hover {
            background-color: #003d66;
        }
        
        form.search-form button {
		    padding: 8px 14px;
		    border-radius: 6px;
		    background-color: #00509e;
		    color: white;
		    border: none;
		    cursor: pointer;
		    font-weight: 600;
		    font-family: 'Montserrat', sans-serif;
		    font-size: 14px;
		}
		
		form.search-form button:hover {
		    background-color: #003d66;
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
                PahanaEdu - Customer List
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
            <li><a href="ManageItems.jsp">Items</a></li>
            <li><a href="UserProfile.jsp">User Profile</a></li>
            <li><a href="Help.jsp">User Guide</a></li>
        </ul>
    </nav>

    <div class="container">
        <h2>All Customers</h2>
			<form method="get" action="customer" class="search-form" style="text-align: center; margin-bottom: 20px;">
			    <input 
			        type="text" 
			        name="searchQuery" 
			        placeholder="Search by Name or NIC" 
			        value="<%= request.getParameter("searchQuery") != null ? request.getParameter("searchQuery") : "" %>" 
			    />
			    <button type="submit">Search</button>
			    <button type="button" onclick="window.location.href='customer';" style="margin-left: 10px;">Clear</button>
			</form>


        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Account Number</th>
                    <th>Name</th>
                    <th>NIC</th>
                    <th>Address</th>
                    <th>Phone</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
            <%
                List<Customer> customers = (List<Customer>) request.getAttribute("customers");
                if (customers != null && !customers.isEmpty()) {
                    for (Customer c : customers) {
            %>
                <tr>
                    <td><%= c.getCustomerId() %></td>
                    <td><%= c.getAccountNumber() %></td>
                    <td><%= c.getName() %></td>
                    <td><%= c.getNic() %></td>
                    <td><%= c.getAddress() %></td>
                    <td><%= c.getPhoneNo() %></td>
                    <td>
                        <div class="action-buttons">
                            <form action="UpdateCustomer.jsp" method="get">
                                <input type="hidden" name="id" value="<%= c.getCustomerId() %>" />
                                <button type="submit" class="action-btn">Update</button>
                            </form>
                            <form action="customer" method="post" onsubmit="return confirm('Are you sure you want to delete this customer?');">
							    <input type="hidden" name="id" value="<%= c.getCustomerId() %>" />
							    <input type="hidden" name="action" value="delete" />
							    <button type="submit" class="action-btn delete">Delete</button>
							</form>
                        </div>
                    </td>
                </tr>
            <%
                    }
                } else {
            %>
                <tr><td colspan="7" style="text-align:center;">No customers found.</td></tr>
            <%
                }
            %>
            </tbody>
        </table>
		<%
		    String successMessage = (String) session.getAttribute("successMessage");
		    if (successMessage != null) {
		%>
		    <script>alert('<%= successMessage %>');</script>
		<%
		        session.removeAttribute("successMessage");
		    }
		%>

        <a href="AddCustomer.jsp" class="back-link">➕ Add New Customer</a>
    </div>

    <footer>
        &copy; 2025 PahanaEdu. All rights reserved.
    </footer>
</div>

</body>
</html>
