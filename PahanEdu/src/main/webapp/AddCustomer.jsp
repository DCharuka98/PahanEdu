<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add New Customer - PahanaEdu</title>
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
            padding: 0;
        }

        header {
            background-color: rgba(0, 51, 102, 0.7);
            color: white;
            padding: 20px;
            font-size: 24px;
            text-align: center;
        }

        .container {
            max-width: 500px;
            margin: 60px auto;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(8px);
            padding: 30px 40px;
            border-radius: 12px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.3);
        }

        h2 {
            text-align: center;
            color: #ffffff;
        }

        label {
            display: block;
            margin: 18px 0 6px;
            font-weight: 600;
            color: #ffffff;
        }

        input[type=text], input[type=tel] {
            width: 100%;
            padding: 10px 12px;
            border: 1.5px solid #ccc;
            border-radius: 6px;
            font-size: 16px;
            background-color: rgba(255, 255, 255, 0.1);
            color: white;
        }

        input[type=text]::placeholder, input[type=tel]::placeholder {
            color: #cccccc;
        }

        input[type=text]:focus, input[type=tel]:focus {
            border-color: #66aaff;
            outline: none;
            background-color: rgba(255, 255, 255, 0.2);
        }

        .btn-submit {
            margin-top: 30px;
            width: 100%;
            padding: 12px;
            background-color: #007bff;
            color: white;
            font-size: 18px;
            font-weight: 600;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .btn-submit:hover {
            background-color: #0056b3;
        }

        .back-link {
            display: block;
            text-align: center;
            margin-top: 20px;
            color: #b3d4fc;
            text-decoration: none;
            font-weight: 600;
        }

        .back-link:hover {
            text-decoration: underline;
        }

        footer {
            text-align: center;
            padding: 15px;
            color: #ccc;
            background: rgba(0, 0, 0, 0.4);
            margin-top: 40px;
        }
    </style>
</head>
<body>

<div class="overlay">
    <header>
        PahanaEdu - Add New Customer
    </header>

    <div class="container">
        <h2>Add New Customer</h2>
		
		<% if (request.getAttribute("error") != null) { %>
		    <p style="color: red; font-weight: bold; text-align: center;">
		        <%= request.getAttribute("error") %>
		    </p>
		<% } %>
				
        <form action="customer" method="post">
            <input type="hidden" name="action" value="add" />
                               
            <label for="name">Customer Name</label>
            <input type="text" id="name" name="name" required maxlength="100" placeholder="Enter customer name" />
            
            <label for="nic">NIC</label>
			<input type="text" id="nic" name="nic" required maxlength="20" placeholder="Enter NIC" />
            
            <label for="address">Address</label>
            <input type="text" id="address" name="address" required maxlength="200" placeholder="Enter address" />
            
            <label for="phoneNo">Phone Number</label>
            <input type="tel" id="phoneNo" name="phoneNo" required maxlength="15" placeholder="Enter phone number" pattern="[0-9\-+ ]+" title="Phone number can contain digits, spaces, plus or hyphens" />
            
            <button type="submit" class="btn-submit">Add Customer</button>
        </form>

        <a href="customer" class="back-link">← Back to Customer List</a>
    </div>

    <footer>
        &copy; 2025 PahanaEdu. All rights reserved.
    </footer>
</div>

</body>
</html>
