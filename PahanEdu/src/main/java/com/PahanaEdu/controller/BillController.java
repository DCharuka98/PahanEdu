package com.PahanaEdu.controller;

import com.PahanaEdu.dao.BillDAO;
import com.PahanaEdu.dao.DBConnection;
import com.PahanaEdu.model.Bill;
import com.PahanaEdu.model.BillItem;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;

@WebServlet("/bill")
public class BillController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("GenerateBill.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String customerNIC = request.getParameter("customerNIC");
        String[] itemIds = request.getParameterValues("itemId");
        String[] quantities = request.getParameterValues("quantity");
        String[] prices = request.getParameterValues("price");

        if (itemIds == null || itemIds.length == 0) {
            request.setAttribute("errorMessage", "No items were added to the bill.");
            request.getRequestDispatcher("GenerateBill.jsp").forward(request, response);
            return;
        }

        try (Connection conn = DBConnection.getInstance().getConnection()) {
            conn.setAutoCommit(false);

            int customerId = getCustomerIdByNIC(conn, customerNIC);
            if (customerId == -1) {
                conn.rollback();
                request.setAttribute("errorMessage", "Customer not found with NIC: " + customerNIC);
                request.getRequestDispatcher("GenerateBill.jsp").forward(request, response);
                return;
            }

            List<BillItem> itemList = new ArrayList<>();
            double totalAmount = 0;

            for (int i = 0; i < itemIds.length; i++) {
                try {
                    if (itemIds[i] == null || itemIds[i].trim().isEmpty()) continue;
                    if (quantities[i] == null || quantities[i].trim().isEmpty()) continue;
                    if (prices[i] == null || prices[i].trim().isEmpty()) continue;

                    int itemId = Integer.parseInt(itemIds[i]);
                    int qty = Integer.parseInt(quantities[i]);
                    double price = Double.parseDouble(prices[i]);

                    if (qty <= 0) continue;

                    BillItem item = new BillItem();
                    item.setItemId(itemId);
                    item.setQuantity(qty);
                    item.setItemPrice(price);

                    itemList.add(item);
                    totalAmount += qty * price;

                } catch (NumberFormatException e) {
                    continue;
                }
            }

            if (itemList.isEmpty()) {
                conn.rollback();
                request.setAttribute("errorMessage", "No valid items were added to the bill.");
                request.getRequestDispatcher("GenerateBill.jsp").forward(request, response);
                return;
            }

            Bill bill = new Bill();
            bill.setCustomerId(customerId);
            bill.setDate(new java.sql.Date(System.currentTimeMillis()));
            bill.setTotalAmount(totalAmount);
            bill.setItems(itemList);

            BillDAO dao = new BillDAO();
            int billId = dao.insertBill(conn, bill);
            dao.insertBillItems(conn, billId, itemList);

            conn.commit();

            response.sendRedirect("BillSuccess.jsp?billId=" + billId);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An unexpected error occurred: " + e.getMessage());
            request.getRequestDispatcher("GenerateBill.jsp").forward(request, response);
        }

    }
    
    private int getCustomerIdByNIC(Connection conn, String nic) throws Exception {
        String sql = "SELECT customer_id FROM customer WHERE nic = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, nic);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("customer_id");
                }
            }
        }
        return -1; 
    }

}
