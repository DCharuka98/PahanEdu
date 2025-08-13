package com.PahanaEdu.dao;

import com.PahanaEdu.model.Bill;
import java.sql.*;
import java.util.*;

public class BillDAO {

	public static List<Bill> getLastFiveBills() {
	    List<Bill> bills = new ArrayList<>();

	    String sql = "SELECT b.bill_id, b.customer_id, c.name AS customer_name, b.bill_date, b.total_amount " +
	            "FROM bill b " +
	            "JOIN customer c ON b.customer_id = c.customer_id " +
	            "ORDER BY b.bill_date DESC LIMIT 5";

	    try (Connection conn = DBConnection.getInstance().getConnection();
	         PreparedStatement ps = conn.prepareStatement(sql);
	         ResultSet rs = ps.executeQuery()) {

	        while (rs.next()) {
	            Bill bill = new Bill();
	            bill.setBillId(rs.getInt("bill_id"));
	            bill.setCustomerId(rs.getInt("customer_id"));
	            bill.setCustomerName(rs.getString("customer_name"));
	            bill.setDate(rs.getDate("bill_date"));
	            bill.setTotalAmount(rs.getDouble("total_amount"));
	            bills.add(bill);
	        }

	        // ✅ Add log
	        System.out.println("DEBUG: Number of bills retrieved = " + bills.size());

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return bills;
	}

}
