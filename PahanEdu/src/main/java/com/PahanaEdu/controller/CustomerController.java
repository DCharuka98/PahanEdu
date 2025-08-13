package com.PahanaEdu.controller;

import com.PahanaEdu.model.Customer;
import com.PahanaEdu.service.CustomerService;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/customer")
public class CustomerController extends HttpServlet {
    private CustomerService customerService = new CustomerService();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Customer> customerList = customerService.getAllCustomers();
        request.setAttribute("customers", customerList);
        request.getRequestDispatcher("CustomerList.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("add".equals(action)) {
            String nic = request.getParameter("nic");

            // Check if NIC already exists
            if (customerService.isNICExists(nic)) {
                request.setAttribute("error", "NIC already exists.");
                request.getRequestDispatcher("AddCustomer.jsp").forward(request, response);
                return;
            }

            Customer customer = new Customer();
            String generatedAccountNumber = customerService.generateNextAccountNumber();
            customer.setAccountNumber(generatedAccountNumber);
            customer.setName(request.getParameter("name"));
            customer.setAddress(request.getParameter("address"));
            customer.setPhoneNo(request.getParameter("phoneNo"));
            customer.setNic(nic);

            customerService.addCustomer(customer);
            response.sendRedirect("customer");
        }

    }
}
