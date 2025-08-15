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

    String searchQuery = request.getParameter("search");
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Bill History</title>
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
        .search-box {
            margin: 20px auto;
            max-width: 500px;
            display: flex;
            gap: 10px;
        }
        .search-box input {
            flex: 1;
            padding: 8px;
            border-radius: 6px;
            border: none;
        }
        .search-box button {
            padding: 8px 14px;
            border: none;
            font-weight: bold;
            border-radius: 6px;
            cursor: pointer;
        }
        .btn-search {
            background: #33ccff;
            color: white;
        }
        .btn-clear {
            background: #ff6666;
            color: white;
        }
        table {
            width: 100%;
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
        a.view-btn {
            background: #33cc33;
            color: white;
            padding: 5px 10px;
            border-radius: 6px;
            text-decoration: none;
        }
        footer {
            background: rgba(0, 0, 0, 0.4);
            text-align: center;
            padding: 10px;
            margin-top: 22%;
            color: white;
            position: relative;
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
    <!-- SEARCH FORM -->
    <form class="search-box" method="get" action="BillHistory.jsp">
        <input type="text" name="search" placeholder="Search by Name, NIC or Amount" value="<%= searchQuery != null ? searchQuery : "" %>">
        <button class="btn-search" type="submit">Search</button>
        <button class="btn-clear" type="button" onclick="window.location='BillHistory.jsp'">Clear</button>
    </form>

    <!-- TABLE -->
    <table>
        <tr>
            <th>Bill ID</th>
            <th>Customer Name</th>
            <th>NIC</th>
            <th>Total Amount (Rs.)</th>
            <th>Date</th>
            <th>Action</th>
        </tr>
        <%
            try {
                conn = DBConnection.getInstance().getConnection();
                String sql = "SELECT b.bill_id, c.name, c.nic, b.total_amount, b.bill_date " +
                             "FROM bill b JOIN customer c ON b.customer_id = c.customer_id ";

                if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                    sql += "WHERE c.name LIKE ? OR c.nic LIKE ? OR b.total_amount = ?";
                    ps = conn.prepareStatement(sql);
                    ps.setString(1, "%" + searchQuery + "%");
                    ps.setString(2, "%" + searchQuery + "%");
                    try {
                        double amount = Double.parseDouble(searchQuery);
                        ps.setDouble(3, amount);
                    } catch (NumberFormatException e) {
                        ps.setDouble(3, -1); // won't match if not a number
                    }
                } else {
                    ps = conn.prepareStatement(sql);
                }

                rs = ps.executeQuery();
                boolean hasResults = false;
                while (rs.next()) {
                    hasResults = true;
        %>
        <tr>
            <td><%= rs.getInt("bill_id") %></td>
            <td><%= rs.getString("name") %></td>
            <td><%= rs.getString("nic") %></td>
            <td><%= String.format("%.2f", rs.getDouble("total_amount")) %></td>
            <td><%= rs.getDate("bill_date") %></td>
            <td>
                <a class="view-btn" href="BillDetails.jsp?billId=<%= rs.getInt("bill_id") %>">View</a>
            </td>
        </tr>
        <%
                }
                if (!hasResults) {
                    out.println("<tr><td colspan='6' style='color:red;'>No results found.</td></tr>");
                }
            } catch (Exception e) {
                out.println("<tr><td colspan='6' style='color:red;'>Error: " + e.getMessage() + "</td></tr>");
            } finally {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            }
        %>
    </table>

    <!-- FOOTER -->
    <footer>
        &copy; 2025 PahanaEdu Bookshop. All Rights Reserved.
    </footer>
</div>
</body>
</html>
