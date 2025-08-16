<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.PahanaEdu.model.Customer, com.PahanaEdu.service.CustomerService, com.PahanaEdu.model.User" %>
<%
    HttpSession currentSession = request.getSession(false);
    if (currentSession == null || currentSession.getAttribute("loggedUser") == null) {
        response.sendRedirect("LoginPage.jsp");
        return;
    }

    User user = (User) currentSession.getAttribute("loggedUser");
    String username = user.getUsername();

    String idParam = request.getParameter("id");
    Customer customer = null;
    if (idParam != null) {
        try {
            int id = Integer.parseInt(idParam);
            CustomerService customerService = new CustomerService();
            customer = customerService.getCustomerById(id);
        } catch (NumberFormatException e) {}
    }
    if (customer == null) {
        response.sendRedirect("customer");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title>PahanaEdu - Update Customer</title>
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
            background: #ff6666 !important;
            color: white;
            font-weight: bold;
            border: none;
            padding: 8px 14px;
            border-radius: 6px;
            cursor: pointer;
        }

        .logout-btn:hover {
            background: #cc3333 !important;
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
            max-width: 500px;
            margin: 40px auto;
            padding: 30px 40px;
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

        form label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #b3d4fc;
        }

        form input[type="text"] {
            width: 100%;
            padding: 10px 12px;
            margin-bottom: 20px;
            border: none;
            border-radius: 6px;
            font-size: 14px;
            font-family: 'Montserrat', sans-serif;
        }

        form input[readonly] {
            background-color: #2a2a2a;
            color: #ccc;
        }

        form button[type="submit"] {
            background-color: #007bff;
            color: white;
            font-weight: 600;
            border: none;
            padding: 12px 20px;
            border-radius: 6px;
            cursor: pointer;
            font-family: 'Montserrat', sans-serif;
            font-size: 16px;
            width: 100%;
            transition: background-color 0.3s ease;
        }

        form button[type="submit"]:hover {
            background-color: #0056b3;
        }

        a.cancel-link {
            display: block;
            margin-top: 15px;
            text-align: center;
            color: #a3c4f3;
            font-weight: 600;
            text-decoration: none;
            font-size: 14px;
        }

        a.cancel-link:hover {
            text-decoration: underline;
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
                <img src="images/PahanaEduLogo.png" alt="PahanaEdu Logo" />
            </div>
            <div class="header-title">
                PahanaEdu - Update Customer
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
        <h2>Update Customer</h2>
        <form action="customer" method="post">
            <input type="hidden" name="action" value="update" />
            <input type="hidden" name="id" value="<%= customer.getCustomerId() %>" />

            <label>Account Number:</label>
            <input type="text" name="accountNumber" value="<%= customer.getAccountNumber() %>" readonly />

            <label>Name:</label>
            <input type="text" name="name" value="<%= customer.getName() %>" required />

            <label>NIC:</label>
            <input type="text" name="nic" value="<%= customer.getNic() %>" required />

            <label>Address:</label>
            <input type="text" name="address" value="<%= customer.getAddress() %>" required />

            <label>Phone Number:</label>
            <input type="text" name="phoneNo" value="<%= customer.getPhoneNo() %>" required />

            <button type="submit">Update Customer</button>
            <a href="customer" class="cancel-link">Cancel</a>
        </form>
      </div>
    

    <footer>
        &copy; 2025 PahanaEdu. All rights reserved.
    </footer>

</div>
 
</body>
</html>
