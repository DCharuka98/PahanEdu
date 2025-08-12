package com.PahanaEdu.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.PahanaEdu.dao.DBConnection;

@WebServlet("/RegisterServlet") 
public class RegisterController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {


        String fullName = request.getParameter("full_name");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        try {
            Connection conn = DBConnection.getInstance().getConnection();

           
            String sql = "INSERT INTO user (username, password, full_name, role) VALUES (?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            stmt.setString(2, password); 
            stmt.setString(3, fullName);
            stmt.setString(4, role);

           
            int rows = stmt.executeUpdate();
            stmt.close();

            if (rows > 0) {
                response.sendRedirect("LoginPage.jsp");
            } else {
                response.getWriter().println("User registration failed.");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Database Error: " + e.getMessage());
        }
    }
}
