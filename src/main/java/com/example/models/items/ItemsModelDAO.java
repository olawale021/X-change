package com.example.models.items;

import com.example.utils.DatabaseConnection;
import com.example.models.category.CategoryModel;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.json.JSONArray;
import org.json.JSONException;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ItemsModelDAO {
    private static final Logger LOGGER = Logger.getLogger(ItemsModelDAO.class.getName());

    public int addItem(ItemsModel item) throws SQLException {
        String sql = "INSERT INTO items (user_id, category_id, title, description, condition, photos, created_at, updated_at, item_features) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            pstmt.setInt(1, item.getUserId());
            pstmt.setInt(2, item.getCategoryId());
            pstmt.setString(3, item.getTitle());
            pstmt.setString(4, item.getDescription());
            pstmt.setString(5, item.getCondition());
            pstmt.setString(6, new JSONArray(item.getPhotos()).toString());
            pstmt.setTimestamp(7, item.getCreatedAt());
            pstmt.setTimestamp(8, item.getUpdatedAt());
            pstmt.setString(9, item.getItemFeature());

            int affectedRows = pstmt.executeUpdate();

            if (affectedRows == 0) {
                throw new SQLException("Creating item failed, no rows affected.");
            }

            try (ResultSet generatedKeys = pstmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1);
                } else {
                    throw new SQLException("Creating item failed, no ID obtained.");
                }
            }
        }
    }

    public ItemsModel getItemById(int id) throws SQLException {
        String query = "SELECT items.*, categories.name as category_name FROM items JOIN categories ON items.category_id = categories.id WHERE items.id = ?";
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                List<String> photosList = parsePhotos(rs.getString("photos"));
                String photosJson = convertPhotosListToJson(photosList);

                return new ItemsModel(
                        rs.getInt("id"),
                        rs.getInt("user_id"),
                        rs.getInt("category_id"),
                        rs.getString("title"),
                        rs.getString("description"),
                        rs.getString("condition"),
                        photosList,
                        rs.getTimestamp("created_at"),
                        rs.getTimestamp("updated_at"),
                        rs.getString("category_name"),
                        photosJson,
                        rs.getString("item_features")
                );
            }
        }
        return null;
    }

    public List<ItemsModel> getAllItems() throws SQLException {
        List<ItemsModel> items = new ArrayList<>();
        String query = "SELECT items.*, categories.name as category_name FROM items JOIN categories ON items.category_id = categories.id";

        try (Connection connection = DatabaseConnection.getConnection();
             Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {

            while (rs.next()) {
                List<String> photosList = parsePhotos(rs.getString("photos"));
                String photosJson = convertPhotosListToJson(photosList);

                items.add(new ItemsModel(
                        rs.getInt("id"),
                        rs.getInt("user_id"),
                        rs.getInt("category_id"),
                        rs.getString("title"),
                        rs.getString("description"),
                        rs.getString("condition"),
                        photosList,
                        rs.getTimestamp("created_at"),
                        rs.getTimestamp("updated_at"),
                        rs.getString("category_name"),
                        photosJson,
                        rs.getString("item_features")
                ));
            }
        }

        return items;
    }

    public void updateItem(int itemId, ItemsModel item) throws SQLException {
        String sql = "UPDATE items SET title = ?, description = ?, category_id = ?, condition = ?, photos = ?, item_features = ? WHERE id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, item.getTitle());
            stmt.setString(2, item.getDescription());
            stmt.setInt(3, item.getCategoryId());
            stmt.setString(4, item.getCondition());
            stmt.setString(5, item.getPhotosJson());
            stmt.setString(6, item.getItemFeature());
            stmt.setInt(7, itemId);

            LOGGER.log(Level.INFO, "Executing update with parameters: {0}, {1}, {2}, {3}, {4}, {5}, {6}",
                    new Object[]{item.getTitle(), item.getDescription(), item.getCategoryId(), item.getCondition(), item.getPhotosJson(), item.getItemFeature(), itemId});

            stmt.executeUpdate();
        }
    }

    public boolean deleteItem(int itemId) throws SQLException {
        String sql = "DELETE FROM items WHERE id = ?";
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, itemId);
            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;
        }
    }

    public List<ItemsModel> getItemsByUserId(int userId) throws SQLException {
        List<ItemsModel> items = new ArrayList<>();
        String query = "SELECT items.*, categories.name as category_name FROM items JOIN categories ON items.category_id = categories.id WHERE items.user_id = ?";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                List<String> photosList = parsePhotos(rs.getString("photos"));
                String photosJson = convertPhotosListToJson(photosList);

                items.add(new ItemsModel(
                        rs.getInt("id"),
                        rs.getInt("user_id"),
                        rs.getInt("category_id"),
                        rs.getString("title"),
                        rs.getString("description"),
                        rs.getString("condition"),
                        photosList,
                        rs.getTimestamp("created_at"),
                        rs.getTimestamp("updated_at"),
                        rs.getString("category_name"),
                        photosJson,
                        rs.getString("item_features")
                ));
            }
        }
        return items;
    }

    public List<ItemsModel> getItemsByCategories(String[] categoryIds) throws SQLException {
        List<ItemsModel> items = new ArrayList<>();
        String sql = "SELECT items.*, categories.name as category_name FROM items JOIN categories ON items.category_id = categories.id WHERE category_id IN (";

        StringBuilder placeholders = new StringBuilder();
        for (int i = 0; i < categoryIds.length; i++) {
            placeholders.append("?");
            if (i < categoryIds.length - 1) {
                placeholders.append(",");
            }
        }
        sql += placeholders.toString() + ")";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            for (int i = 0; i < categoryIds.length; i++) {
                stmt.setInt(i + 1, Integer.parseInt(categoryIds[i]));
            }

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                List<String> photosList = parsePhotos(rs.getString("photos"));
                String photosJson = convertPhotosListToJson(photosList);

                items.add(new ItemsModel(
                        rs.getInt("id"),
                        rs.getInt("user_id"),
                        rs.getInt("category_id"),
                        rs.getString("title"),
                        rs.getString("description"),
                        rs.getString("condition"),
                        photosList,
                        rs.getTimestamp("created_at"),
                        rs.getTimestamp("updated_at"),
                        rs.getString("category_name"),
                        photosJson,
                        rs.getString("item_features")
                ));
            }
        }
        return items;
    }

    public List<CategoryModel> getAllCategories() throws SQLException {
        List<CategoryModel> categories = new ArrayList<>();
        String query = "SELECT * FROM categories";

        try (Connection connection = DatabaseConnection.getConnection();
             Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {

            while (rs.next()) {
                categories.add(new CategoryModel(
                        rs.getInt("id"),
                        rs.getString("name")
                ));
            }
        }

        return categories;
    }

    private List<String> parsePhotos(String photosString) {
        List<String> photosList = new ArrayList<>();
        try {
            JSONArray photosArray = new JSONArray(photosString);
            for (int i = 0; i < photosArray.length(); i++) {
                photosList.add(photosArray.getString(i));
            }
        } catch (JSONException e) {
            LOGGER.log(Level.SEVERE, "Invalid photos JSON format: " + photosString, e);
        }
        return photosList;
    }

    private String convertPhotosListToJson(List<String> photosList) {
        try {
            return new ObjectMapper().writeValueAsString(photosList);
        } catch (JsonProcessingException e) {
            LOGGER.log(Level.SEVERE, "Error converting photos list to JSON", e);
            return "[]";
        }
    }
}
