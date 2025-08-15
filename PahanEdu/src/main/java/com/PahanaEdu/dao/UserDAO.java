package com.PahanaEdu.dao;

import java.sql.*;

import com.PahanaEdu.model.User;

public class UserDAO {

    private Connection conn;

    public UserDAO() throws SQLException {
        this.conn = DBConnection.getInstance().getConnection();
    }

    public boolean usernameExists(String username) throws SQLException {
        String sql = "SELECT COUNT(*) FROM users WHERE username = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        }
        return false;
    }

    public boolean registerUser(User user) throws SQLException {
        String sql = "INSERT INTO users (username, password, full_name, role) VALUES (?, ?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getPassword());
            stmt.setString(3, user.getFullName());
            stmt.setString(4, user.getRole());

            int rows = stmt.executeUpdate();
            return rows > 0;
        }
    }
    
    public User validateUser(String username, String password) throws SQLException {
        String sql = "SELECT * FROM users WHERE username = ? AND password = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, username);
            stmt.setString(2, password); 
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                User users = new User();
                users.setUserId(rs.getInt("user_id"));       
                users.setUsername(rs.getString("username"));
                users.setPassword(rs.getString("password")); 
                users.setFullName(rs.getString("full_name"));
                users.setRole(rs.getString("role"));
                return users;
            }
        }
        return null;
    }


}
