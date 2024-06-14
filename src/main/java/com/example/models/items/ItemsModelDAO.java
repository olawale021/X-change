package com.example.models.items;

import com.example.utils.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;



public class ItemsModelDAO {

    private static final Logger LOGGER = Logger.getLogger(ItemsModelDAO.class.getName());

    public void addItem(ItemsModel item) throws SQLException {
        String sql = "INSERT INTO items (user_id, name, description, image_url, category, condition, location, exchange_preferences, quantity) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, item.getUserId());
            statement.setString(2, item.getName());
            statement.setString(3, item.getDescription());
            statement.setString(4, item.getImageUrl());
            statement.setString(5, item.getCategory());
            statement.setString(6, item.getCondition());
            statement.setString(7, item.getLocation());
            statement.setString(8, item.getExchangePreferences());
            statement.setInt(9, item.getQuantity());
            statement.executeUpdate();
        }
    }

    public ItemsModel getItemById(int id) throws SQLException {
        String sql = "SELECT * FROM items WHERE id = ?";
        ItemsModel item = null;

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, id);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                item = new ItemsModel(
                        resultSet.getInt("id"),
                        resultSet.getInt("user_id"),
                        resultSet.getString("name"),
                        resultSet.getString("description"),
                        resultSet.getString("image_url"),
                        resultSet.getString("category"),
                        resultSet.getString("condition"),
                        resultSet.getString("location"),
                        resultSet.getString("exchange_preferences"),
                        resultSet.getInt("quantity")
                );
            }
        }

        return item;
    }

    public List<ItemsModel> getAllItems() throws SQLException {
        String sql = "SELECT * FROM items";
        List<ItemsModel> items = new ArrayList<>();

        try (Connection connection = DatabaseConnection.getConnection();
             Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(sql)) {

            while (resultSet.next()) {
                ItemsModel item = new ItemsModel(
                        resultSet.getInt("id"),
                        resultSet.getInt("user_id"),
                        resultSet.getString("name"),
                        resultSet.getString("description"),
                        resultSet.getString("image_url"),
                        resultSet.getString("category"),
                        resultSet.getString("condition"),
                        resultSet.getString("location"),
                        resultSet.getString("exchange_preferences"),
                        resultSet.getInt("quantity")
                );
                items.add(item);
                LOGGER.info("Item fetched: " + item.getName());
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching items from database", e);
            throw e;
        }

        LOGGER.info("Total items fetched: " + items.size());
        return items;
    }

    public void updateItem(ItemsModel item) throws SQLException {
        String sql = "UPDATE items SET user_id = ?, name = ?, description = ?, image_url = ?, category = ?, condition = ?, location = ?, exchange_preferences = ?, quantity = ? WHERE id = ?";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, item.getUserId());
            statement.setString(2, item.getName());
            statement.setString(3, item.getDescription());
            statement.setString(4, item.getImageUrl());
            statement.setString(5, item.getCategory());
            statement.setString(6, item.getCondition());
            statement.setString(7, item.getLocation());
            statement.setString(8, item.getExchangePreferences());
            statement.setInt(9, item.getQuantity());
            statement.setInt(10, item.getId());
            statement.executeUpdate();
        }
    }

    public void deleteItem(int id) throws SQLException {
        String sql = "DELETE FROM items WHERE id = ?";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, id);
            statement.executeUpdate();
        }
    }
}