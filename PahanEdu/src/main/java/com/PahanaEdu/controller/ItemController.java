package com.PahanaEdu.controller;

import com.PahanaEdu.model.Item;
import com.PahanaEdu.service.ItemService;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.util.List;

@WebServlet("/item")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
                 maxFileSize = 1024 * 1024 * 10,       // 10MB
                 maxRequestSize = 1024 * 1024 * 50)    // 50MB
public class ItemController extends HttpServlet {

    private ItemService itemService = new ItemService();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String query = request.getParameter("query");
        String category = request.getParameter("category");

        List<Item> itemList;

        if ((query != null && !query.trim().isEmpty()) || (category != null && !category.trim().isEmpty())) {
        	itemList = itemService.searchItems(query);
        } else {
            itemList = itemService.getAllItems();
        }

        request.setAttribute("items", itemList);
        request.getRequestDispatcher("ItemList.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String description = request.getParameter("description");
        double price = Double.parseDouble(request.getParameter("price"));
        int stock = Integer.parseInt(request.getParameter("stock"));

        Part filePart = request.getPart("image");
        String fileName = new File(filePart.getSubmittedFileName()).getName();

        String uploadPath = getServletContext().getRealPath("") + File.separator + "item_images";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdir();

        String imagePath = "item_images/" + fileName;
        filePart.write(uploadPath + File.separator + fileName);

        Item item = new Item();
        item.setName(name);
        item.setDescription(description);
        item.setPrice(price);
        item.setStockQuantity(stock);
        item.setImagePath(imagePath);

        boolean success = itemService.addItem(item);
        if (success) {
            request.getSession().setAttribute("successMessage", "Item added successfully!");
            response.sendRedirect("item");
        } else {
            request.setAttribute("error", "Failed to add item.");
            request.getRequestDispatcher("AddItem.jsp").forward(request, response);
        }
    }
}
