package com.example.models.exchange;

import com.example.utils.DatabaseConnection;

import java.sql.*;
import java.util.logging.Logger;

public class ExchangeModelDAO {
    private static final Logger LOGGER = Logger.getLogger(ExchangeModelDAO.class.getName());

    public void createExchange(ExchangeModel exchange) throws SQLException {
        String query = "INSERT INTO exchanges (item_id, interested_user_id, status, created_at, updated_at) VALUES (?, ?, ?, ?, ?)";
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, exchange.getItemId());
            stmt.setInt(2, exchange.getInterestedUserId());
            stmt.setString(3, exchange.getStatus());
            stmt.setTimestamp(4, exchange.getCreatedAt());
            stmt.setTimestamp(5, exchange.getUpdatedAt());

            stmt.executeUpdate();

            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    exchange.setId(generatedKeys.getInt(1));
                }
            }
        }
    }

    public void updateExchangeStatus(int exchangeId, String status) throws SQLException {
        String query = "UPDATE exchanges SET status = ? WHERE id = ?";
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, status);
            stmt.setInt(2, exchangeId);
            stmt.executeUpdate();
        }
    }
}
