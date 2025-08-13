package com.PahanaEdu.controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.PahanaEdu.model.User;
import com.PahanaEdu.service.UserService;

@WebServlet("/RegisterServlet")
public class RegisterController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fullName = request.getParameter("full_name");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        User user = new User(fullName, username, password, role);

        try {
            UserService userService = new UserService();

            if (userService.isUsernameTaken(username)) {
                response.sendRedirect("Register.jsp?error=username_exists");
                return;
            }

            boolean success = userService.register(user);

            if (success) {
                response.sendRedirect("LoginPage.jsp?success=1");
            } else {
                response.sendRedirect("Register.jsp?error=register_failed");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("Register.jsp?error=db");
        }
    }
}
