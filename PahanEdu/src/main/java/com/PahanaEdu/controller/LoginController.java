package com.PahanaEdu.controller;

import com.PahanaEdu.dao.UserDAO;
import com.PahanaEdu.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/LoginServlet")
public class LoginController extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            UserDAO userDAO = new UserDAO();
            User users = userDAO.validateUser(username, password);

            if (users != null) {
                HttpSession session = request.getSession();
                session.setAttribute("loggedUser", users);
                response.sendRedirect("HomePage.jsp");
            } else {
                response.sendRedirect("LoginPage.jsp?error=1");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("LoginPage.jsp?error=1");
        }
    }
}
