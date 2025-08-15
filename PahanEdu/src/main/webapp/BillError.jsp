<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Bill Error</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f44336;
            color: white;
            padding: 50px;
            text-align: center;
        }
        a {
            color: #ffffff;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <h1>❌ Error Generating Bill</h1>
    <p><%= request.getParameter("error") %></p>
    <p><a href="GenerateBill.jsp">🔙 Back to Generate Bill</a></p>
</body>
</html>
