package com.example.models.exchange;

import com.example.models.offerMessage.OfferMessageModelDAO;
import com.example.utils.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

public class ExchangeModelDAO {
    private static final Logger LOGGER = Logger.getLogger(ExchangeModelDAO.class.getName());

    private OfferMessageModelDAO offerMessageModelDAO;

    public ExchangeModelDAO() {
        this.offerMessageModelDAO = new OfferMessageModelDAO();
    }

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

    public List<ExchangeModel> getExchangesByStatus(int userId, String status) throws SQLException {
        String query = "SELECT e.*, i.title AS itemName, u1.username AS ownerName, u2.username AS interestedUserName " +
                "FROM exchanges e " +
                "JOIN items i ON e.item_id = i.id " +
                "JOIN users u1 ON i.user_id = u1.id " +
                "JOIN users u2 ON e.interested_user_id = u2.id " +
                "WHERE e.status = ? AND (i.user_id = ? OR e.interested_user_id = ?)";
        List<ExchangeModel> exchanges = new ArrayList<>();
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, status);
            stmt.setInt(2, userId);
            stmt.setInt(3, userId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                ExchangeModel exchange = new ExchangeModel();
                exchange.setId(rs.getInt("id"));
                exchange.setItemId(rs.getInt("item_id"));
                exchange.setInterestedUserId(rs.getInt("interested_user_id"));
                exchange.setStatus(rs.getString("status"));
                exchange.setItemName(rs.getString("itemName"));
                exchange.setSenderName(rs.getInt("interested_user_id") == userId ? rs.getString("interestedUserName") : rs.getString("ownerName"));
                exchange.setRecipientName(rs.getInt("interested_user_id") == userId ? rs.getString("ownerName") : rs.getString("interestedUserName"));
                exchange.setCreatedAt(rs.getTimestamp("created_at"));
                exchange.setUpdatedAt(rs.getTimestamp("updated_at"));

                // Set flags
                exchange.setSentByCurrentUser(rs.getInt("interested_user_id") == userId);
                exchange.setReceivedByCurrentUser(rs.getInt("interested_user_id") != userId);

                // Fetch and set messages
                exchange.setMessages(offerMessageModelDAO.getOfferMessagesByExchangeId(exchange.getId()));

                exchanges.add(exchange);
            }
        }
        return exchanges;
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

    public int getItemIdByExchangeId(int exchangeId) throws SQLException {
        String query = "SELECT item_id FROM exchanges WHERE id = ?";
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, exchangeId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("item_id");
            } else {
                throw new SQLException("No item found for exchange ID: " + exchangeId);
            }
        }
    }

    public int getUserIdByItemId(int itemId) throws SQLException {
        String query = "SELECT user_id FROM items WHERE id = ?";
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, itemId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("user_id");
            } else {
                throw new SQLException("No user found for item ID: " + itemId);
            }
        }
    }
}
