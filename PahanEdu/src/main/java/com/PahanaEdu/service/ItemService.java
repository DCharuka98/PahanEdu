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
}
