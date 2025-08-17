package com.PahanaEdu.ServiceTest;

import com.PahanaEdu.model.Item;
import com.PahanaEdu.service.ItemService;
import java.util.List;         
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

class ItemServiceTest {

    private ItemService itemService;

    @BeforeEach
    void setUp() {
        itemService = new ItemService();
    }


    /* TC0001
     * @Test
    void testAddItem() {
        Item item = new Item();
        item.setName("JUnit Book");
        item.setDescription("Test book for TDD");
        item.setPrice(500);
        item.setStockQuantity(10);

        boolean added = itemService.addItem(item);
        assertTrue(added, "Item should be added successfully");
    } 
    
    TC0002
    @Test
    void testGetAllItems() {
        List<Item> items = itemService.getAllItems();
        assertNotNull(items, "Item list should not be null");
        assertFalse(items.isEmpty(), "Item list should not be empty after adding items");
    }
    
    TC0003
    @Test
    void testUpdateItem() {
        Item item = itemService.getItemById(4); 
        assertNotNull(item, "Item with ID 5 should exist");

        item.setPrice(600);
        item.setStockQuantity(12);

        boolean updated = itemService.updateItem(item);
        assertTrue(updated);

        Item updatedItem = itemService.getItemById(4);
        assertEquals(600, updatedItem.getPrice());
        assertEquals(12, updatedItem.getStockQuantity());
    }
    
    //TC0004
    @Test
    void testDeleteItem() {
        List<Item> items = itemService.getAllItems();
        assertFalse(items.isEmpty(), "There should be at least one item to delete");

        Item itemToDelete = items.get(0);  
        int idToDelete = itemToDelete.getItemId();

        boolean deleted = itemService.deleteItem(idToDelete);
        assertTrue(deleted, "Item should be deleted successfully");

        Item afterDelete = itemService.getItemById(idToDelete);
        assertNull(afterDelete, "Deleted item should not exist in the DB");
    }  
    
    //TC0005
    @Test
    void testAddItemWithEmptyName() {
        Item item = new Item();
        item.setName("");
        item.setDescription("No name item");
        item.setPrice(100);
        item.setStockQuantity(5);

        boolean added = itemService.addItem(item);
        System.out.println("Added? " + added);
        assertFalse(added, "Item with empty name should not be added");
    } 
    
    //TC0006
    @Test
    void testUpdateNonExistingItem() {
        Item fakeItem = new Item();
        fakeItem.setItemId(999); 
        fakeItem.setName("Ghost Item");
        fakeItem.setPrice(200);
        fakeItem.setStockQuantity(2);

        boolean updated = itemService.updateItem(fakeItem);
        System.out.println("Updated? " + updated);
        assertFalse(updated, "Updating non-existing item should return false");
    } 
    
    //TC0007
    @Test
    void testDeleteNonExistingItem() {
        boolean deleted = itemService.deleteItem(999);
        assertFalse(deleted, "Deleting non-existing item should return false");
    } */    
}
