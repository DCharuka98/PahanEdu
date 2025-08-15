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

    int billId = Integer.parseInt(request.getParameter("billId"));
    Connection conn = null;
    PreparedStatement psBill = null;
    PreparedStatement psItems = null;
    ResultSet billRs = null;
    ResultSet itemsRs = null;

    String customerName = "";
    double totalAmount = 0;
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Bill Details</title>
    <link rel="icon" type="image/png" href="images/PahanaEduLogo.png">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600&display=swap" rel="stylesheet">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
	<script src="https://html2canvas.hertzen.com/dist/html2canvas.min.js"></script>	
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

        .bill-container {
            background: white !important;
            backdrop-filter: blur(8px);
            padding: 30px;
            margin: 40px auto;
            max-width: 800px;
            border-radius: 12px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.3);
            color: black !important;
        }

        table {
        	border-color: #444 !important;
            width: 100%;
            color: black !important;
            margin-top: 20px;
            border-collapse: collapse;
        }

        th, td {
            border: 1px solid #ccc;
            border-color: #444 !important;
            padding: 12px;
            text-align: center;
            color: black !important;
        }

        .download-btn {
            background: #33cc33;
            border: none;
            color: white;
            padding: 10px 18px;
            font-size: 16px;
            border-radius: 6px;
            cursor: pointer;
            margin-top: 20px;
        }

        .download-btn:hover {
            background: #28a428;
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
                <img src="images/PahanaEduLogo.png" alt="PahanaEdu Logo">
            </div>

            <div class="header-title">PahanaEdu - Bill Details</div>

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

    <div class="bill-container" id="billContent">
        <%
            try {
                conn = DBConnection.getInstance().getConnection();

                psBill = conn.prepareStatement(
                    "SELECT c.name, b.total_amount FROM bill b JOIN customer c ON b.customer_id = c.customer_id WHERE b.bill_id = ?"
                );
                psBill.setInt(1, billId);
                billRs = psBill.executeQuery();
                if (billRs.next()) {
                    customerName = billRs.getString("name");
                    totalAmount = billRs.getDouble("total_amount");
                }

                psItems = conn.prepareStatement(
                    "SELECT i.name, bi.quantity, bi.item_price FROM bill_items bi JOIN item i ON bi.item_id = i.item_id WHERE bi.bill_id = ?"
                );
                psItems.setInt(1, billId);
                itemsRs = psItems.executeQuery();
        %>

        <h2>✅ Bill Generated Successfully!</h2>
        <p><strong>Bill ID:</strong> <%= billId %></p>
        <p><strong>Customer Name:</strong> <%= customerName %></p>

        <table>
            <tr>
                <th>Item</th>
                <th>Quantity</th>
                <th>Price</th>
                <th>Line Total</th>
            </tr>
            <%
                while (itemsRs.next()) {
                    String itemName = itemsRs.getString("name");
                    int quantity = itemsRs.getInt("quantity");
                    double price = itemsRs.getDouble("item_price");
                    double lineTotal = quantity * price;
            %>
            <tr>
                <td><%= itemName %></td>
                <td><%= quantity %></td>
                <td>Rs. <%= String.format("%.2f", price) %></td>
                <td>Rs. <%= String.format("%.2f", lineTotal) %></td>
            </tr>
            <% } %>
            <tr>
                <td colspan="3" align="right"><strong>Total:</strong></td>
                <td><strong>Rs. <%= String.format("%.2f", totalAmount) %></strong></td>
            </tr>
        </table>
        <button class="download-btn" onclick="downloadPDF()">📄 Download PDF</button>
        <a href="GenerateBill.jsp" style="display:block;margin-top:20px;color:black;">Generate Another Bill</a>

        <%
            } catch (Exception e) {
            	out.println("<pre style='color:red;'>");
            	e.printStackTrace(new java.io.PrintWriter(out));
            	out.println("</pre>");

            } finally {
                if (itemsRs != null) itemsRs.close();
                if (billRs != null) billRs.close();
                if (psItems != null) psItems.close();
                if (psBill != null) psBill.close();
                if (conn != null) conn.close();
            }
        %>
    </div>

    <footer>
        &copy; 2025 PahanaEdu. All rights reserved.
    </footer>
</div>
<script>
	async function downloadPDF() {
	    const { jsPDF } = window.jspdf;
	    const doc = new jsPDF();
	
	    const content = document.getElementById("billContent");
	    const overlay = document.querySelector('.overlay');
	
	    const downloadBtn = document.querySelector('.download-btn');
	    const generateLink = document.querySelector('#billContent a');
	    downloadBtn.style.display = "none";
	    generateLink.style.display = "none";
	
	    const originalBillContainerBG = content.style.background;
	    const originalBillContainerFilter = content.style.backdropFilter;
	    const originalOverlayBG = overlay.style.backgroundColor;
	
	    content.style.background = "#ffffff"; 
	    content.style.backdropFilter = "none";
	    
	
	    await html2canvas(content, { scale: 2 }).then((canvas) => {
	        const imgData = canvas.toDataURL("image/png");
	        const imgProps = doc.getImageProperties(imgData);
	        const pdfWidth = doc.internal.pageSize.getWidth();
	        const pdfHeight = (imgProps.height * pdfWidth) / imgProps.width;
	
	        doc.addImage(imgData, "PNG", 0, 0, pdfWidth, pdfHeight);
	        doc.save("Bill_<%= billId %>.pdf");
	    });
	
	    content.style.background = originalBillContainerBG;
	    content.style.backdropFilter = originalBillContainerFilter;
	    overlay.style.backgroundColor = originalOverlayBG;
	
	    downloadBtn.style.display = "inline-block";
	    generateLink.style.display = "block";
	}

</script>
</body>
</html>
