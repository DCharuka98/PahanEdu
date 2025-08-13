<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Registration Success</title>
<meta http-equiv="refresh" content="3;URL=LoginPage.jsp">
<style>
    body {
        font-family: 'Montserrat', sans-serif;
        background: linear-gradient(135deg, #6a11cb, #2575fc);
        color: white;
        text-align: center;
        padding-top: 150px;
    }
    .message {
        background: rgba(0,0,0,0.3);
        padding: 20px;
        border-radius: 10px;
        display: inline-block;
    }
</style>
</head>
<body>
    <div class="message">
        <h2>${successMessage}</h2>
        <p>You will be redirected to the login page in 3 seconds...</p>
    </div>
</body>
</html>
