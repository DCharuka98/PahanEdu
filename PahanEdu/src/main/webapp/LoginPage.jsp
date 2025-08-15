<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>PahanaEdu - Login</title>
    <link rel="icon" type="image/png" href="images/PahanaEduLogo.png">    
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;700&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Montserrat', sans-serif;
            background: url('images/backgroundImage.jpg') no-repeat center center fixed;
            background-size: cover;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .login-container {
            display: flex;
            background: rgba(20, 20, 30, 0.85);
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.8);
            overflow: hidden;
            max-width: 900px;
            width: 100%;
        }
        
        .login-image {
            width: 50%;
            background-color: rgba(18, 27, 40, 0.9);
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 30px;
        }

        .login-image img {
            max-width: 130%;
            height: auto;
            
        }

		.login-card {
            width: 50%;
            padding: 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            color: white;
            backdrop-filter: blur(10px);
        }

        .login-card h2 {
            font-weight: 700;
            letter-spacing: 2px;
            margin-left: 15%;
            margin-bottom: 5px;
            font-size: 36px;
            text-shadow: 0 0 12px rgba(255, 255, 255, 0.7);
        }

        .login-card h1 {
            font-weight: 500;
            margin-bottom: 20px;
            margin-left: 35%;
            font-size: 30px;
            color: #b3d4fc;
        }

        .login-card input {
            width: 100%;
            padding: 15px;
            margin: 14px 0;
             margin-left: -4%;
            border-radius: 12px;
            border: none;
            font-size: 17px;
            background: rgba(255, 255, 255, 0.15);
            color: white;
        }

        .login-card input::placeholder {
            color: rgba(255, 255, 255, 0.7);
        }

        .login-card input:focus {
            outline: none;
            background: rgba(255, 255, 255, 0.35);
            color: #00264d;
            font-weight: 600;
        }

        .login-card button {
            width: 100%;
            padding: 16px;
            margin-top: 25px;
            border: none;
            border-radius: 14px;
            background: #3399ff;
            color: white;
            font-size: 20px;
            font-weight: 700;
            cursor: pointer;
        }

        .login-card button:hover {
            background-color: #2673cc;
        }

        .create-user-link {
            text-align: center;
            margin-top: 15px;
        }

        .create-user-link a {
            color: #66b3ff;
            text-decoration: none;
            font-weight: 500;
        }

        .create-user-link a:hover {
            text-decoration: underline;
        }

        .error-message {
            color: #ff4d4d;
            margin-top: 10px;
            font-weight: 500;
        }

        @media (max-width: 768px) {
            .login-container {
                flex-direction: column;
                max-width: 500px;
            }
            .login-image, .login-card {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <div class="login-container">
       
        <div class="login-image">
            <img src="images/PahanaEduLogo.png" alt="Pahana Edu Logo">
        </div>

        <div class="login-card">
            <h2>PahanaEdu</h2>
            <h1>LOGIN</h1>

            <form action="${pageContext.request.contextPath}/LoginServlet" method="post">
                <input type="text" name="username" placeholder="Username" required>
                <input type="password" name="password" placeholder="Password" required>
                <button type="submit">LOGIN</button>
            </form>

            <% if (request.getParameter("error") != null) { %>
                <p class="error-message">Invalid username or password</p>
            <% } %>

            <div class="create-user-link">
                <p>Don't have an account? <a href="Register.jsp">Create one</a></p>
            </div>
        </div>
    </div>
</body>
</html>
