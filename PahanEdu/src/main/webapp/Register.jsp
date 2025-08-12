<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Registration</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .register-box {
            background: white;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0px 0px 10px rgba(0,0,0,0.2);
            width: 350px;
        }
        input, select {
            width: 100%;
            padding: 10px;
            margin-top: 8px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }
        button {
            width: 100%;
            background: #007bff;
            color: white;
            padding: 10px;
            margin-top: 12px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        button:hover { background: #0056b3; }
    </style>
</head>
<body>
    <div class="register-box">
        <h2>Create User</h2>        
        <form action="${pageContext.request.contextPath}/RegisterServlet" method="post">
		    <input type="text" name="full_name" placeholder="Full Name" required>
		    <input type="text" name="username" placeholder="Username" required>
		    <input type="password" name="password" placeholder="Password" required>
		    <select name="role" required>
		        <option value="">Select Role</option>                
		        <option value="staff">Staff</option>
		        <option value="admin">Admin</option>
		    </select>
		    <button type="submit">Register</button>
		</form>
	
		<a href="LoginPage.jsp" style="display: block; text-align: center; margin-top: 8px; background: #6c757d; color: white; padding: 10px; border-radius: 5px; text-decoration: none;">
		    Log In
		</a>

    </div>
</body>
</html>
