package com.example.models.category;

import com.example.utils.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CategoryModelDAO {

    public List<CategoryModel> getAllCategories() throws SQLException {
        List<CategoryModel> categories = new ArrayList<>();
        String sql = "SELECT id, name FROM categories";
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                CategoryModel category = new CategoryModel();
                category.setId(resultSet.getInt("id"));
                category.setName(resultSet.getString("name"));
                categories.add(category);
            }
        }
        return categories;
    }
}
