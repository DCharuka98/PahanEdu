<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.PahanaEdu.model.Customer" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Customer List - PahanaEdu</title>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Montserrat', sans-serif;
            background: #121b28;
            color: white;
            margin: 0;
            padding: 0;
        }

        header {
            background-color: #003366;
            padding: 20px;
            font-size: 24px;
            text-align: center;
            color: white;
        }

        .container {
            max-width: 1000px;
            margin: 40px auto;
            padding: 30px;
            background-color: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(4px);
            border-radius: 12px;
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
            border-bottom: 1px solid #555;
        }

        th {
            background-color: #003366;
            color: white;
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
        }

        .back-link:hover {
            text-decoration: underline;
        }

    </style>
</head>
<body>

<header>
    PahanaEdu - Customer List
</header>

<div class="container">
    <h2>All Customers</h2>

    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Account Number</th>
                <th>Name</th>
                <th>NIC</th>
                <th>Address</th>
                <th>Phone</th>
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
            </tr>
        <%
                }
            } else {
        %>
            <tr><td colspan="6" style="text-align:center;">No customers found.</td></tr>
        <%
            }
        %>
        </tbody>
    </table>

    <a href="addCustomer.jsp" class="back-link">← Add New Customer</a>
</div>

</body>
</html>
