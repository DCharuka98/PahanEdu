package com.PahanaEdu.dao;

import com.PahanaEdu.model.Bill;
import com.PahanaEdu.model.BillItem;

import java.sql.*;
import java.util.List;

public class BillDAO {

	public int insertBill(Connection conn, Bill bill) throws SQLException {
	    String sql = "INSERT INTO bill (customer_id, bill_date, total_amount) VALUES (?, ?, ?)";
	    try (PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
	        stmt.setInt(1, bill.getCustomerId());
	        stmt.setDate(2, bill.getDate());
	        stmt.setDouble(3, bill.getTotalAmount());
	        stmt.executeUpdate();

	        ResultSet rs = stmt.getGeneratedKeys();
	        if (rs.next()) {
	            return rs.getInt(1);
	        } else {
	            throw new SQLException("Bill ID generation failed.");
	        }
	    }
	}

	public void insertBillItems(Connection conn, int billId, List<BillItem> items) throws Exception {
	    String sql = "INSERT INTO Bill_Items (bill_id, item_id, quantity, item_price) VALUES (?, ?, ?, ?)";
	    String updateStock = "UPDATE item SET stock_quantity = stock_quantity - ? WHERE item_id = ? AND stock_quantity >= ?";
	    
	    try (PreparedStatement stmt = conn.prepareStatement(sql);
	         PreparedStatement stockStmt = conn.prepareStatement(updateStock)) {
	        
	        for (BillItem item : items) {
	            stmt.setInt(1, billId);
	            stmt.setInt(2, item.getItemId());
	            stmt.setInt(3, item.getQuantity());
	            stmt.setDouble(4, item.getItemPrice());
	            stmt.addBatch();

	            stockStmt.setInt(1, item.getQuantity());
	            stockStmt.setInt(2, item.getItemId());
	            stockStmt.setInt(3, item.getQuantity());
	            stockStmt.addBatch();
	        }

	        stmt.executeBatch();
	        int[] stockUpdates = stockStmt.executeBatch();

	        for (int result : stockUpdates) {
	            if (result == 0) {
	                throw new SQLException("Insufficient stock for one of the items.");
	            }
	        }
	    }
	}

}
