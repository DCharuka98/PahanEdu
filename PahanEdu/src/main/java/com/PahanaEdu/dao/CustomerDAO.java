package com.PahanaEdu.dao;

import com.PahanaEdu.model.Customer;
import java.sql.*;
import java.util.*;

public class CustomerDAO {

    public boolean addCustomer(Customer customer) {
    	String sql = "INSERT INTO customer (account_number, name, address, phone_no, nic) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

				ps.setString(1, customer.getAccountNumber());
				ps.setString(2, customer.getName());
				ps.setString(3, customer.getAddress());
				ps.setString(4, customer.getPhoneNo());
				ps.setString(5, customer.getNic());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }
    
    public boolean isNICExists(String nic) {
        String sql = "SELECT 1 FROM customer WHERE nic = ?";

        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, nic);
            ResultSet rs = ps.executeQuery();
            return rs.next(); // Returns true if NIC already exists

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    
    public String generateNextAccountNumber() {
        String prefix = "AC";
        int nextNumber = 1;

        String sql = "SELECT MAX(account_number) AS max_account FROM customer WHERE account_number LIKE 'AC%'";

        try (Connection conn = DBConnection.getInstance().getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            if (rs.next()) {
                String maxAccount = rs.getString("max_account");

                if (maxAccount != null && maxAccount.length() >= 8) {
                    String numberPart = maxAccount.substring(2); // Skip 'AC'
                    nextNumber = Integer.parseInt(numberPart) + 1;
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return String.format("%s%06d", prefix, nextNumber);
    }


    public Customer getCustomerById(int id) {
        String sql = "SELECT * FROM customer WHERE customer_id = ?";
        Customer customer = null;

        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                customer = new Customer();
                customer.setCustomerId(rs.getInt("customer_id"));
                customer.setAccountNumber(rs.getString("account_number"));
                customer.setName(rs.getString("name"));
                customer.setAddress(rs.getString("address"));
                customer.setPhoneNo(rs.getString("phone_no"));
                customer.setNic(rs.getString("nic"));             
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return customer;
    }

    public List<Customer> getAllCustomers() {
        List<Customer> customers = new ArrayList<>();
        String sql = "SELECT * FROM customer";

        try (Connection conn = DBConnection.getInstance().getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

        	while (rs.next()) {
        	    Customer customer = new Customer();
        	    customer.setCustomerId(rs.getInt("customer_id"));
        	    customer.setAccountNumber(rs.getString("account_number"));
        	    customer.setName(rs.getString("name"));
        	    customer.setAddress(rs.getString("address"));
        	    customer.setPhoneNo(rs.getString("phone_no"));
        	    customer.setNic(rs.getString("nic")); 
        	    customers.add(customer);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return customers;
    }
    
    public List<Customer> searchCustomersByNameOrNIC(String query) {
        List<Customer> customers = new ArrayList<>();
        String sql = "SELECT * FROM customer WHERE name LIKE ? OR TRIM(nic) LIKE ?";


        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            String likeQuery = "%" + query + "%";
            ps.setString(1, likeQuery);
            ps.setString(2, likeQuery);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Customer customer = new Customer();
                customer.setCustomerId(rs.getInt("customer_id"));
                customer.setAccountNumber(rs.getString("account_number"));
                customer.setName(rs.getString("name"));
                customer.setAddress(rs.getString("address"));
                customer.setPhoneNo(rs.getString("phone_no"));
                customer.setNic(rs.getString("nic"));
                customers.add(customer);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return customers;
    }


    public boolean updateCustomer(Customer customer) {
        String sql = "UPDATE customer SET account_number=?, name=?, address=?, phone_no=? WHERE customer_id=?";

        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, customer.getAccountNumber());
            ps.setString(2, customer.getName());
            ps.setString(3, customer.getAddress());
            ps.setString(4, customer.getPhoneNo());
            ps.setInt(5, customer.getCustomerId());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean deleteCustomer(int id) {
        String sql = "DELETE FROM customer WHERE customer_id=?";

        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }
}
