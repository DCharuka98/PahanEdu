<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Pahana Edu - Login</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .login-box {
            background: white;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0px 0px 10px rgba(0,0,0,0.2);
            width: 300px;
        }
        input {
            width: 100%;
            padding: 10px;
            margin-top: 8px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }
        button {
            width: 100%;
            background: #28a745;
            color: white;
            padding: 10px;
            margin-top: 12px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        button:hover { background: #218838; }
        .create-user-link {
            text-align: center;
            margin-top: 15px;
        }
        .create-user-link a {
            color: #007bff;
            text-decoration: none;
        }
        .create-user-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="login-box">
        <h2>Staff Login</h2>
        <form action="LoginServlet" method="post">
            <input type="text" name="username" placeholder="Username" required>
            <input type="password" name="password" placeholder="Password" required>
            <button type="submit">Login</button>
        </form>

        <% if (request.getParameter("error") != null) { %>
            <p style="color:red;">Invalid username or password</p>
        <% } %>

        <div class="create-user-link">
            <p>Don't have an account? <a href="Register.jsp">Create one</a></p>
        </div>
    </div>
</body>
</html>
