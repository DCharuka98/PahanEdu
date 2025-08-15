package com.PahanaEdu.controller;

import com.PahanaEdu.model.User;
import com.PahanaEdu.dao.DBConnection;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/UpdateUserProfileServlet")
public class UserController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedUser") == null) {
            response.sendRedirect("LoginPage.jsp");
            return;
        }

        User user = (User) session.getAttribute("loggedUser");

        // Get and safely trim inputs
        String username = safeTrim(request.getParameter("username"));
        String password = safeTrim(request.getParameter("password"));
        String confirmPassword = safeTrim(request.getParameter("confirmPassword"));
        String fullName = safeTrim(request.getParameter("full_name"));

        // Password validation only if fields are not empty
        if (!password.isEmpty() || !confirmPassword.isEmpty()) {
            if (!password.equals(confirmPassword)) {
                session.setAttribute("errorMsg", "Passwords do not match!");
                response.sendRedirect("UserProfile.jsp");
                return;
            }
        }

        Connection conn = null;
        PreparedStatement pst = null;

        try {
            conn = DBConnection.getInstance().getConnection();

            // Build SQL dynamically
            StringBuilder sql = new StringBuilder("UPDATE users SET ");
            boolean needComma = false;

            if (!username.equals(user.getUsername())) {
                sql.append("username = ?");
                needComma = true;
            }

            if (!password.isEmpty()) {
                if (needComma) sql.append(", ");
                sql.append("password = ?");
                needComma = true;
            }

            if (!fullName.equals(user.getFullName())) {
                if (needComma) sql.append(", ");
                sql.append("full_name = ?");
            }

            sql.append(" WHERE user_id = ?");

            pst = conn.prepareStatement(sql.toString());

            // Set parameters dynamically
            int index = 1;
            if (!username.equals(user.getUsername())) {
                pst.setString(index++, username);
            }
            if (!password.isEmpty() && password.equals(confirmPassword)) {
                pst.setString(index++, password); // 🔐 Still recommend hashing in real apps
            } else if (!password.isEmpty()) {
                session.setAttribute("errorMsg", "Passwords do not match!");
                response.sendRedirect("UserProfile.jsp");
                return;
            }

            if (!fullName.equals(user.getFullName())) {
                pst.setString(index++, fullName);
            }

            pst.setInt(index, user.getUserId());

            int updated = pst.executeUpdate();

            if (updated > 0) {
                // Update session object with new values
                if (!username.equals(user.getUsername())) user.setUsername(username);
                if (!password.isEmpty()) user.setPassword(password);
                if (!fullName.equals(user.getFullName())) user.setFullName(fullName);

                session.setAttribute("loggedUser", user);
                session.setAttribute("successMsg", "Profile updated successfully!");
            } else {
                session.setAttribute("errorMsg", "No changes detected.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMsg", "An error occurred: " + e.getMessage());
        } finally {
            try { if (pst != null) pst.close(); } catch (Exception ex) {}
            try { if (conn != null) conn.close(); } catch (Exception ex) {}
        }

        response.sendRedirect("UserProfile.jsp");
    }

    // Utility method to trim safely (handles null input)
    private String safeTrim(String value) {
        return value != null ? value.trim() : "";
    }
}
