package com.example.models.users;

import com.example.utils.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserModelDAO {

    public void addUser(UserModel user) throws SQLException {
        String sql = "INSERT INTO users (username, password, address_street, address_city, address_country, address_zip_code) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, user.getUsername());
            statement.setString(2, user.getPassword());
            statement.setString(3, user.getAddressStreet());
            statement.setString(4, user.getAddressCity());
            statement.setString(5, user.getAddressCountry());
            statement.setString(6, user.getAddressZipCode());
            statement.executeUpdate();
        }
    }

    public UserModel getUserById(int id) throws SQLException {
        String sql = "SELECT * FROM users WHERE id = ?";
        UserModel user = null;

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, id);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                user = new UserModel(
                        resultSet.getInt("id"),
                        resultSet.getString("username"),
                        resultSet.getString("password"),
                        resultSet.getString("address_street"),
                        resultSet.getString("address_city"),
                        resultSet.getString("address_country"),
                        resultSet.getString("address_zip_code")
                );
            }
        }

        return user;
    }

    public List<UserModel> getAllUsers() throws SQLException {
        String sql = "SELECT * FROM users";
        List<UserModel> users = new ArrayList<>();

        try (Connection connection = DatabaseConnection.getConnection();
             Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(sql)) {

            while (resultSet.next()) {
                UserModel user = new UserModel(
                        resultSet.getInt("id"),
                        resultSet.getString("username"),
                        resultSet.getString("password"),
                        resultSet.getString("address_street"),
                        resultSet.getString("address_city"),
                        resultSet.getString("address_country"),
                        resultSet.getString("address_zip_code")
                );
                users.add(user);
            }
        }

        return users;
    }

    public void updateUser(UserModel user) throws SQLException {
        String sql = "UPDATE users SET username = ?, password = ?, address_street = ?, address_city = ?, address_country = ?, address_zip_code = ? WHERE id = ?";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, user.getUsername());
            statement.setString(2, user.getPassword());
            statement.setString(3, user.getAddressStreet());
            statement.setString(4, user.getAddressCity());
            statement.setString(5, user.getAddressCountry());
            statement.setString(6, user.getAddressZipCode());
            statement.setInt(7, user.getId());
            statement.executeUpdate();
        }
    }

    public void deleteUser(int id) throws SQLException {
        String sql = "DELETE FROM users WHERE id = ?";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, id);
            statement.executeUpdate();
        }
    }
}