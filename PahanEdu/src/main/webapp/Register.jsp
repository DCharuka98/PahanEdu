<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>PahanaEdu - Register</title>
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
        .register-container {
            display: flex;
            background: rgba(20, 20, 30, 0.85);
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.8);
            overflow: hidden;
            max-width: 900px;
            height: 95%;
            width: 100%;
        }
        .register-image {
            width: 50%;
            background-color: rgba(18, 27, 40, 0.9);
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 30px;
        }
        .register-image img {
            max-width: 130%;
            height: auto;
        }
        .register-card {
            width: 50%;            
            padding: 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            color: white;
            backdrop-filter: blur(10px);
        }
        .register-card h2 {
            font-weight: 700;
            letter-spacing: 2px;
            margin-left: 15%;
            margin-bottom: 5px;
            font-size: 36px;
            text-shadow: 0 0 12px rgba(255, 255, 255, 0.7);
        }
        .register-card h1 {
            font-weight: 500;
            margin-bottom: 20px;
            margin-left: 25%;
            font-size: 28px;
            color: #b3d4fc;
        }
        .register-card input, 
        .register-card select {
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
        .register-card input::placeholder {
            color: rgba(255, 255, 255, 0.7);
        }
        .register-card option { color: black; }
        .register-card input:focus, 
        .register-card select:focus {
            outline: none;
            background: rgba(255, 255, 255, 0.35);
            color: #00264d;
            font-weight: 600;
        }
        .register-card button {
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
        .register-card button:hover { background-color: #2673cc; }
        .login-link {
            text-align: center;
            margin-top: 15px;
        }
        .login-link a {
            color: #66b3ff;
            text-decoration: none;
            font-weight: 500;
        }
        .login-link a:hover { text-decoration: underline; }

        /* Messages */
        .success-message {
            background-color: rgba(46, 204, 113, 0.9);
            color: white;
            padding: 12px;
            border-radius: 8px;
            text-align: center;
            margin-bottom: 15px;
            font-weight: 600;
        }
        .error-message {
            background-color: rgba(231, 76, 60, 0.9);
            color: white;
            padding: 12px;
            border-radius: 8px;
            text-align: center;
            margin-bottom: 15px;
            font-weight: 600;
        }
        @media (max-width: 768px) {
            .register-container {
                flex-direction: column;
                max-width: 500px;
            }
            .register-image, .register-card {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <div class="register-container">

        <div class="register-image">
            <img src="images/PahanaEduLogo.png" alt="Pahana Edu Logo">
        </div>

        <div class="register-card">
            <h2>PahanaEdu</h2>
            <h1>Create User</h1>        

            <%
                String success = request.getParameter("success");
                String error = request.getParameter("error");
                if ("1".equals(success)) {
            %>
                <div class="success-message" id="successMsg">
                    User created successfully! 
                </div>
                
            <% 
                } else if ("username_exists".equals(error)) { 
            %>
                <div class="error-message">
                    Username already exists! Please choose another.
                </div>
            <% } %>

            <form action="${pageContext.request.contextPath}/RegisterServlet" method="post">
                <input type="text" name="full_name" placeholder="Full Name" required>
                <input type="text" name="username" placeholder="Username" required>
                <input type="password" name="password" placeholder="Password" required>
                <select name="role" required>
                    <option value="">Select Role</option>                
                    <option value="staff">Staff</option>
                </select>
                <button type="submit">Register</button>
            </form>

            <div class="login-link">
                <p>Already have an account? <a href="LoginPage.jsp">Log In</a></p>
            </div>
        </div>
    </div>
</body>
</html>
