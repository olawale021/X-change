package com.example.models.items;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class ItemsModel {
    private int id;
    private int userId;
    private int categoryId;
    private String title;
    private String description;
    private String condition;
    private List<String> photos;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    private String categoryName;
    private String photosJson;

    // Default constructor with list initialization
    public ItemsModel() {
        this.photos = new ArrayList<>();
    }

    // Parameterized constructor with list initialization
    public ItemsModel(int id, int userId, int categoryId, String title, String description, String condition, List<String> photos, Timestamp createdAt, Timestamp updatedAt, String categoryName, String photosJson) {
        this.id = id;
        this.userId = userId;
        this.categoryId = categoryId;
        this.title = title;
        this.description = description;
        this.condition = condition;
        this.photos = photos != null ? photos : new ArrayList<>();
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.categoryName = categoryName;
        this.photosJson = photosJson;
    }

    // Getters and Setters
    // ... (all the getters and setters)

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

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCondition() {
        return condition;
    }

    public void setCondition(String condition) {
        this.condition = condition;
    }

    public List<String> getPhotos() {
        return photos;
    }

    public String getFirstPhotoUrl() {
        if (photos != null && !photos.isEmpty()) {
            return photos.get(0);
        }
        return null;
    }

    public void setPhotos(List<String> photos) {
        this.photos = photos != null ? photos : new ArrayList<>();
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public String getPhotosJson() {
        return photosJson;
    }

    public void setPhotosJson(String photosJson) {
        this.photosJson = photosJson;
    }
}
