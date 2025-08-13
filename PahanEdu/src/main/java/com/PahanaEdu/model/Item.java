package com.PahanaEdu.model;

public class Item {
    private int itemId;
    private String name;
    private String description;
    private double price;
    private int stockQuantity;
    private String imagePath;

    public int getItemId() {
    	return itemId; 
    	}
    public void setItemId(int itemId) { 
    	this.itemId = itemId; 
    	}

    public String getName() { 
    	return name; 
    	}
    public void setName(String name) { 
    	this.name = name; 
    	}

    public String getDescription() { 
    	return description; 
    	}
    public void setDescription(String description) { 
    	this.description = description; 
    	}

    public double getPrice() { 
    	return price; 
    	}
    public void setPrice(double price) { 
    	this.price = price; 
    	}

    public int getStockQuantity() { 
    	return stockQuantity; 
    	}
    public void setStockQuantity(int stockQuantity) { 
    	this.stockQuantity = stockQuantity; 
    	}

    public String getImagePath() { 
    	return imagePath; 
    	}
    public void setImagePath(String imagePath) { 
    	this.imagePath = imagePath; 
    	}
}
