package com.PahanaEdu.controller;
import com.google.gson.Gson;


import com.PahanaEdu.model.Item;
import com.PahanaEdu.service.ItemService;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/item", "/item-search"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
    maxFileSize = 1024 * 1024 * 10,       // 10MB
    maxRequestSize = 1024 * 1024 * 50     // 50MB
)
public class ItemController extends HttpServlet {
	

	    private final ItemService itemService = new ItemService();
	    private final Gson gson = new Gson();

	    @Override
	    protected void doGet(HttpServletRequest request, HttpServletResponse response)
	            throws ServletException, IOException {

	        if ("/item-search".equals(request.getServletPath())) {
	            handleItemSearch(request, response);
	            return;
	        }

	        String itemIdParam = request.getParameter("itemId");
	        String query = request.getParameter("query");

	        if (itemIdParam != null && !itemIdParam.trim().isEmpty()) {
	            try {
	                int itemId = Integer.parseInt(itemIdParam);
	                Item item = itemService.getItemById(itemId);
	                if (item != null) {
	                    request.setAttribute("item", item);
	                    request.getRequestDispatcher("UpdateItem.jsp").forward(request, response);
	                    return;
	                }
	            } catch (NumberFormatException e) {
	                e.printStackTrace();
	            }
	            response.sendRedirect("item");
	            return;
	        }

	        List<Item> itemList = (query != null && !query.trim().isEmpty())
	                ? itemService.searchItems(query.trim())
	                : itemService.getAllItems();

	        request.setAttribute("items", itemList);
	        request.getRequestDispatcher("ItemList.jsp").forward(request, response);
	    }

	    private void handleItemSearch(HttpServletRequest request, HttpServletResponse response)
	            throws IOException {

	        String query = request.getParameter("query");
	        Item item = null;

	        if (query != null && !query.trim().isEmpty()) {
	            try {
	                int id = Integer.parseInt(query.trim());
	                item = itemService.getItemById(id);
	            } catch (NumberFormatException e) {
	                List<Item> matches = itemService.searchItems(query.trim());
	                if (!matches.isEmpty()) {
	                    item = matches.get(0);
	                }
	            }
	        }

	        if (item != null && item.getImagePath() != null && !item.getImagePath().isEmpty()) {
	            String fullImagePath = request.getContextPath() + "/" + item.getImagePath();
	            item.setImagePath(fullImagePath); // update to full web-accessible path
	        }

	        response.setContentType("application/json");
	        response.setCharacterEncoding("UTF-8");
	        response.getWriter().write(item != null ? gson.toJson(item) : "{}");
	    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("add".equals(action)) {
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            double price = Double.parseDouble(request.getParameter("price"));
            int stock = Integer.parseInt(request.getParameter("stock"));

            Part filePart = request.getPart("image");
            String fileName = new File(filePart.getSubmittedFileName()).getName();

            String uploadPath = getServletContext().getRealPath("") + File.separator + "item_images";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdir();

            String imagePath = "";
            if (fileName != null && !fileName.isEmpty()) {
                imagePath = "item_images/" + fileName;
                filePart.write(uploadPath + File.separator + fileName);
            }

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

        else if ("update".equals(action)) {
            try {
                int itemId = Integer.parseInt(request.getParameter("itemId"));
                String name = request.getParameter("name");
                String description = request.getParameter("description");
                double price = Double.parseDouble(request.getParameter("price"));
                int stock = Integer.parseInt(request.getParameter("stock"));

                Part filePart = request.getPart("image");
                String fileName = new File(filePart.getSubmittedFileName()).getName();

                String uploadPath = getServletContext().getRealPath("") + File.separator + "item_images";
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdir();

                String imagePath;

                if (fileName != null && !fileName.isEmpty()) {
                    imagePath = "item_images/" + fileName;
                    filePart.write(uploadPath + File.separator + fileName);
                } else {
                    Item existingItem = itemService.getItemById(itemId);
                    imagePath = (existingItem != null) ? existingItem.getImagePath() : "";
                }

                Item item = new Item();
                item.setItemId(itemId);
                item.setName(name);
                item.setDescription(description);
                item.setPrice(price);
                item.setStockQuantity(stock);
                item.setImagePath(imagePath);

                boolean updated = itemService.updateItem(item);

                if (updated) {
                    request.getSession().setAttribute("successMessage", "Item updated successfully!");
                    response.sendRedirect("item");
                } else {
                    request.setAttribute("error", "Failed to update item.");
                    request.setAttribute("item", item);
                    request.getRequestDispatcher("UpdateItem.jsp").forward(request, response);
                }

            } catch (NumberFormatException e) {
                request.setAttribute("error", "Invalid item ID.");
                request.getRequestDispatcher("UpdateItem.jsp").forward(request, response);
            }
        }

        else if ("delete".equals(action)) {
            String idParam = request.getParameter("itemId");
            try {
                int itemId = Integer.parseInt(idParam);

                boolean deleted = itemService.deleteItem(itemId);

                if (deleted) {
                    response.sendRedirect("item");
                } else {
                    request.setAttribute("error", "Failed to delete item.");
                    doGet(request, response);
                }
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Invalid item ID.");
                doGet(request, response);
            }
        }

        
    }
}
