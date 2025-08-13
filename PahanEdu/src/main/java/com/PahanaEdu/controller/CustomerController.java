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

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String searchQuery = request.getParameter("searchQuery");

        List<Customer> customerList;

        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            customerList = customerService.searchCustomersByNameOrNIC(searchQuery.trim());
        } else {
            customerList = customerService.getAllCustomers();
        }

        request.setAttribute("customers", customerList);

        request.getRequestDispatcher("CustomerList.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("add".equals(action)) {
            String nic = request.getParameter("nic");

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

        else if ("delete".equals(action)) {
            String idParam = request.getParameter("id");
            try {
                int customerId = Integer.parseInt(idParam);

                boolean deleted = customerService.deleteCustomer(customerId);

                if (deleted) {
                    response.sendRedirect("customer");
                } else {
                    request.setAttribute("error", "Failed to delete customer.");
                    doGet(request, response);
                }
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Invalid customer ID.");
                doGet(request, response);
            }
        }

        else if ("update".equals(action)) {
            String idParam = request.getParameter("id");
            try {
                int customerId = Integer.parseInt(idParam);

                Customer customer = new Customer();
                customer.setCustomerId(customerId);
                customer.setAccountNumber(request.getParameter("accountNumber"));
                customer.setName(request.getParameter("name"));
                customer.setNic(request.getParameter("nic"));
                customer.setAddress(request.getParameter("address"));
                customer.setPhoneNo(request.getParameter("phoneNo"));

                boolean updated = customerService.updateCustomer(customer);

                if (updated) {
                    HttpSession session = request.getSession();
                    session.setAttribute("successMessage", "Customer updated successfully!");

                    response.sendRedirect("customer");
                } else {
                    request.setAttribute("error", "Failed to update customer.");
                    request.setAttribute("customer", customer);
                    request.getRequestDispatcher("UpdateCustomer.jsp").forward(request, response);
                }
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Invalid customer ID.");
                request.getRequestDispatcher("UpdateCustomer.jsp").forward(request, response);
            }
        }
    }
}
