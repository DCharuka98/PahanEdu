package com.PahanaEdu.controller;

import com.PahanaEdu.model.User;
import com.PahanaEdu.model.Bill;
import com.PahanaEdu.dao.BillDAO;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

import com.PahanaEdu.service.BillService;

@WebServlet("/home")
public class HomeController extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedUser") == null) {
            response.sendRedirect("LoginPage.jsp");
            return;
        }

        BillService billService = new BillService();
        List<Bill> bills = billService.getLastFiveBills();

        request.setAttribute("bills", bills);
        request.getRequestDispatcher("HomePage.jsp").forward(request, response);
    }
}
