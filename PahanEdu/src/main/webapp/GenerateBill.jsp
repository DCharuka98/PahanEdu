<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.PahanaEdu.model.User" %>
<%
    HttpSession currentSession = request.getSession(false);
    if (currentSession == null || currentSession.getAttribute("loggedUser") == null) {
        response.sendRedirect("LoginPage.jsp");
        return;
    }

    User user = (User) currentSession.getAttribute("loggedUser");
    String username = user.getUsername();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>PahanaEdu - Generate Bill</title>
    <link rel="icon" type="image/png" href="images/PahanaEduLogo.png">
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
            font-weight: 500;
            font-size: 16px;
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

        .main-content {
            width: 90%;
            max-width: 1000px;
            margin: 40px auto;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(8px);
            border-radius: 12px;
            padding: 30px;
            color: white;
        }

        .item-row, .bill-summary {
            margin-top: 20px;
        }

        input, button {
            padding: 10px;
            border-radius: 6px;
            border: none;
            font-family: 'Montserrat', sans-serif;
        }

        input[type="text"], input[type="number"] {
            width: 100%;
            background: rgba(255,255,255,0.1);
            color: white;
        }

        .btn {
            padding: 10px 15px;
            margin: 5px 0;
            border-radius: 6px;
            font-weight: bold;
            cursor: pointer;
        }

        .btn-search { background-color: #007bff; color: white; }
        .btn-add { background-color: #ffaa00; color: black; }
        .btn-remove { background-color: #cc3333; color: white; }
        .btn-submit { background-color: #28a745; color: white; width: 100%; }
        .btn-clear { background-color: #ddd; color: black; }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            color: white;
        }

        th, td {
            padding: 8px 12px;
            border-bottom: 1px solid rgba(255,255,255,0.3);
        }

        th:first-child  {
            text-align: left;
            width: 80px;
        }

        td:first-child {
            text-align: left;
            width: 80px;
            padding-left: 10px;
        }
        
        .line-total {
            text-align: right;
        }

        footer {
            text-align: center;
            padding: 15px;
            color: #ccc;
            background: rgba(0, 0, 0, 0.4);
            margin-top: 40px;
        }
        
        .error-box {
		    background-color: #ff4d4d;
		    padding: 15px;
		    border-radius: 8px;
		    margin-bottom: 20px;
		    color: white;
		    font-weight: bold;
		}


        a {
            color: #b3d4fc;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
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
                PahanaEdu - Generate Bill
            </div>

            <div class="user-controls">
                👤 <%= username %>
                <form action="LogoutServlet" method="post" style="margin-top: 5px;">
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

    <form action="bill" method="post" id="billForm" onsubmit="return validateForm();">
        <div class="main-content">        
	        <%
			    String errorMessage = (String) request.getAttribute("errorMessage");
			    if (errorMessage != null && !errorMessage.isEmpty()) {
			%>
			    <div class="error-box">
			    ⚠️ <%= errorMessage %>
			</div>
	
			<%
			    }
			%>
            <input type="hidden" id="hiddenTotalAmount" name="totalAmount" value="0.00" />

            <div>
                <h2>Search Items</h2>
                <div class="item-row" data-item-id="" id="itemSearchContainer">
                    <input type="text" id="productSearch" placeholder="Enter product name or ID" autocomplete="off">
                    <button type="button" class="btn btn-search" onclick="searchItem()">Search</button>
                </div>

                <div id="searchResult" style="display: none;">
                    <div style="display: flex; gap: 20px; align-items: center; margin-top: 10px;">
                        <img id="itemImage" src="" alt="Item Image" style="width: 80px; height: 80px; border-radius: 6px;" />
                        <div>
                            <p><strong>Item:</strong> <span id="itemName"></span></p>
                            <p><strong>Price:</strong> Rs. <span id="itemPrice"></span></p>
                        </div>
                    </div>

                    <input type="number" id="itemQty" min="1" placeholder="Quantity" style="margin-top: 10px;">
                    <div style="margin-top: 10px;">
                        <button type="button" class="btn btn-add" onclick="addItem()">➕ Add to Bill</button>
                        <button type="button" class="btn btn-clear" onclick="clearSearch()">🗑️ Clear</button>
                    </div>
                </div>
            </div>

            <div class="bill-summary">
                <h2>Bill Summary</h2>
                
                <table id="itemTable" aria-label="Bill summary table">
                    <thead>
                        <tr>
                            <th>Item ID</th>
                            <th>Item Name</th>
                            <th style="text-align: right;">Qty</th>
                            <th style="text-align: right;">Price</th>
                            <th style="text-align: right;">Total</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody id="itemTableBody"></tbody>
                </table>
                <h3>Total: Rs. <span id="totalAmount">0.00</span></h3>
                <div>
						<input type="text" id="customerNIC" name="customerNIC" placeholder="Enter Customer NIC" autocomplete="off">
						<input type="hidden" id="hiddenCustomerNIC" value="" />	      
					  <button type="button" class="btn btn-search" onclick="getCustomerName()">Get Customer Name</button>
				    <p id="customerNameDisplay" style="margin-top: 10px; font-weight: bold; color: #ffda44;"></p>
				</div>                
                
                <button type="submit" class="btn btn-submit">✅ Submit Bill</button>
            </div>
        </div>        
    </form>

    <footer>
        &copy; 2025 PahanaEdu. All rights reserved.
    </footer>
</div>

<script>
    const addedItems = new Set();

    function searchItem() {
        const query = document.getElementById("productSearch").value.trim();
        if (!query) {
            alert("Please enter an item name or ID to search.");
            return;
        }

        fetch("item-search?query=" + encodeURIComponent(query))
            .then(res => {
                if (!res.ok) throw new Error("Network response was not ok");
                return res.json();
            })
            .then(data => {
                if (data && data.itemId) {
                    document.getElementById("itemName").textContent = data.name;
                    document.getElementById("itemPrice").textContent = parseFloat(data.price).toFixed(2);
                    document.getElementById("itemImage").src = data.imagePath || "images/no-image.png";
                    document.getElementById("itemSearchContainer").dataset.itemId = data.itemId;
                    document.getElementById("searchResult").style.display = "block";
                    document.getElementById("itemQty").value = 1;
                } else {
                    alert("Item not found.");
                    clearSearch();
                }
            })
            .catch(error => {
                alert("Error searching item: " + error.message);
                clearSearch();
            });
    }

    function addItem() {
        const container = document.getElementById("itemSearchContainer");
        const itemId = container.dataset.itemId;
        const qtyInput = document.getElementById("itemQty");
        const qty = parseInt(qtyInput.value);
        const name = document.getElementById("itemName").textContent;
        const price = parseFloat(document.getElementById("itemPrice").textContent);

        if (!itemId) {
            alert("No item selected.");
            return;
        }

        if (isNaN(qty) || qty <= 0) {
            alert("Please enter a valid quantity.");
            qtyInput.focus();
            return;
        }

        if (addedItems.has(itemId)) {
            alert("This item is already added.");
            return;
        }

        const lineTotal = price * qty;

        const row = document.createElement("tr");
        row.dataset.itemId = itemId;

        const idCell = document.createElement("td");
        idCell.textContent = itemId;
        row.appendChild(idCell);

        const nameCell = document.createElement("td");
        nameCell.textContent = name;
        const itemIdHidden = document.createElement("input");
        itemIdHidden.type = "hidden";
        itemIdHidden.name = "itemId"; 
        itemIdHidden.value = itemId;
        nameCell.appendChild(itemIdHidden);
        row.appendChild(nameCell);

        const qtyCell = document.createElement("td");
        qtyCell.style.textAlign = "right";
        qtyCell.textContent = qty;
        const qtyHidden = document.createElement("input");
        qtyHidden.type = "hidden";
        qtyHidden.name = "quantity";
        qtyHidden.value = qty;
        qtyCell.appendChild(qtyHidden);
        row.appendChild(qtyCell);

        const priceCell = document.createElement("td");
        priceCell.style.textAlign = "right";
        priceCell.textContent = price.toFixed(2);
        const priceHidden = document.createElement("input");
        priceHidden.type = "hidden";
        priceHidden.name = "price"; 
        priceHidden.value = price.toFixed(2);
        priceCell.appendChild(priceHidden);
        row.appendChild(priceCell);

        const totalCell = document.createElement("td");
        totalCell.style.textAlign = "right";
        totalCell.textContent = lineTotal.toFixed(2);
        row.appendChild(totalCell);

        const removeCell = document.createElement("td");
        const removeBtn = document.createElement("button");
        removeBtn.type = "button";
        removeBtn.textContent = "Remove";
        removeBtn.className = "btn btn-remove";
        removeBtn.onclick = () => {
            row.remove();
            addedItems.delete(itemId);
            updateTotal();
        };
        removeCell.appendChild(removeBtn);
        row.appendChild(removeCell);

        document.getElementById("itemTableBody").appendChild(row);

        addedItems.add(itemId);
        updateTotal();
        clearSearch();
    }
    
    

    function updateTotal() {
        let total = 0;
        const tbody = document.getElementById("itemTableBody");
        for (const row of tbody.rows) {
            const lineTotal = parseFloat(row.cells[4].textContent);
            total += lineTotal;
        }
        document.getElementById("totalAmount").textContent = total.toFixed(2);
        document.getElementById("hiddenTotalAmount").value = total.toFixed(2);
    }

    function clearSearch() {
        document.getElementById("productSearch").value = "";
        document.getElementById("searchResult").style.display = "none";
        document.getElementById("itemSearchContainer").dataset.itemId = "";
    }
    
    function getCustomerName() {
        const nic = document.getElementById("customerNIC").value.trim();
        const display = document.getElementById("customerNameDisplay");

        if (!nic) {
            alert("Please enter a Customer NIC.");
            return;
        }

        fetch("customer?action=getByNIC&nic=" + encodeURIComponent(nic))
            .then(response => {
                if (!response.ok) throw new Error("Network response was not ok");
                return response.json();
            })
            .then(data => {
                if (data && data.name) {
                    display.textContent = "Customer Name: " + data.name;
                } else {
                    display.textContent = "Customer not found.";
                }
            })
            .catch(error => {
                display.textContent = "Error fetching customer: " + error.message;
            });
    	}
    function validateForm() {
        var rows = document.getElementById("itemTableBody").rows;
        if (rows.length === 0) {
            alert("Please add at least one item to the bill.");
            return false;
        }

        var customerNIC = document.getElementById("customerNIC").value.trim();
        if (!customerNIC) {
            alert("Please enter Customer NIC.");
            return false;
        }

        document.getElementById("hiddenCustomerNIC").value = customerNIC;

        return true;
    }
</script>
</body>
</html>
