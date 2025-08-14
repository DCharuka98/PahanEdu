package com.PahanaEdu.service;

import com.PahanaEdu.dao.ItemDAO;
import com.PahanaEdu.model.Item;

import java.util.List;

public class ItemService {
    private ItemDAO itemDAO = new ItemDAO();

    public boolean addItem(Item item) {
        return itemDAO.addItem(item);
    }

    public List<Item> getAllItems() {
        return itemDAO.getAllItems();
    }

    public List<Item> searchItems(String query) {
        return itemDAO.searchItems(query);
    }
    
    public Item getItemById(int itemId) {
        return itemDAO.getItemById(itemId);
    }
    public boolean updateItem(Item item) {
        return new ItemDAO().updateItem(item);
    }

    public boolean deleteItem(int itemId) {
        return new ItemDAO().deleteItem(itemId);
    }

}
