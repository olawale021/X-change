package com.example.models.items;

public class ItemsModel {
    private int id;
    private int userId;
    private String name;
    private String description;
    private String imageUrl;
    private String category;
    private String condition;
    private String location;
    private String exchangePreferences;
    private int quantity;

    // Constructors
    public ItemsModel() {
    }

    public ItemsModel(int id, int userId, String name, String description, String imageUrl, String category, String condition, String location, String exchangePreferences, int quantity) {
        this.id = id;
        this.userId = userId;
        this.name = name;
        this.description = description;
        this.imageUrl = imageUrl;
        this.category = category;
        this.condition = condition;
        this.location = location;
        this.exchangePreferences = exchangePreferences;
        this.quantity = quantity;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
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

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getCondition() {
        return condition;
    }

    public void setCondition(String condition) {
        this.condition = condition;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getExchangePreferences() {
        return exchangePreferences;
    }

    public void setExchangePreferences(String exchangePreferences) {
        this.exchangePreferences = exchangePreferences;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
}
