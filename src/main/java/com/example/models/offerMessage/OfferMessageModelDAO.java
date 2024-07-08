package com.example.models.offerMessage;

import com.example.utils.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class OfferMessageModelDAO {
    private static final Logger LOGGER = Logger.getLogger(OfferMessageModelDAO.class.getName());

    // Method to create a new offer message
    public void createOfferMessage(OfferMessageModel offerMessage) throws SQLException {
        String query = "INSERT INTO offer_messages (exchange_id, sender_id, receiver_id, message, created_at) VALUES (?, ?, ?, ?, ?)";
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, offerMessage.getExchangeId());
            stmt.setInt(2, offerMessage.getSenderId());
            stmt.setInt(3, offerMessage.getReceiverId());
            stmt.setString(4, offerMessage.getMessage());
            stmt.setTimestamp(5, offerMessage.getCreatedAt());

            stmt.executeUpdate();

            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    offerMessage.setId(generatedKeys.getInt(1));
                }
            }
        }
    }


    public List<OfferMessageModel> getPendingOffers(int userId) throws SQLException {
        String query = "SELECT DISTINCT om.*, " +
                "sender.username AS senderName, " +
                "receiver.username AS recipientName, " +
                "i.title AS itemName, e.status " +
                "FROM offer_messages om " +
                "JOIN users sender ON om.sender_id = sender.id " +
                "JOIN users receiver ON om.receiver_id = receiver.id " +
                "JOIN exchanges e ON om.exchange_id = e.id " +
                "JOIN items i ON e.item_id = i.id " +
                "WHERE e.status = 'Pending' AND (om.sender_id = ? OR om.receiver_id = ?)";
        List<OfferMessageModel> pendingOffers = new ArrayList<>();
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, userId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                OfferMessageModel offer = new OfferMessageModel();
                offer.setId(rs.getInt("id"));
                offer.setExchangeId(rs.getInt("exchange_id"));
                offer.setSenderId(rs.getInt("sender_id"));
                offer.setReceiverId(rs.getInt("receiver_id"));
                offer.setMessage(rs.getString("message"));
                offer.setCreatedAt(rs.getTimestamp("created_at"));
                offer.setSenderName(rs.getString("senderName"));
                offer.setRecipientName(rs.getString("recipientName"));
                offer.setItemName(rs.getString("itemName"));
                offer.setStatus(rs.getString("status"));
                offer.setIsSentOffer(rs.getInt("sender_id") == userId);
                pendingOffers.add(offer);
            }
        }
        return pendingOffers;
    }


    public List<OfferMessageModel> getReceivedOffersByUserId(int userId) throws SQLException {
        String query = "SELECT om.*, u.username as senderName, i.title as itemName " +
                "FROM offer_messages om " +
                "JOIN users u ON om.sender_id = u.id " +
                "JOIN exchanges e ON om.exchange_id = e.id " +
                "JOIN items i ON e.item_id = i.id " +
                "WHERE om.receiver_id = ?";
        List<OfferMessageModel> offers = new ArrayList<>();
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                OfferMessageModel offer = new OfferMessageModel();
                offer.setId(rs.getInt("id"));
                offer.setExchangeId(rs.getInt("exchange_id"));
                offer.setSenderId(rs.getInt("sender_id"));
                offer.setReceiverId(rs.getInt("receiver_id"));
                offer.setMessage(rs.getString("message"));
                offer.setCreatedAt(rs.getTimestamp("created_at"));
                offer.setSenderName(rs.getString("senderName"));
                offer.setItemName(rs.getString("itemName"));
                offers.add(offer);
            }
        }
        return offers;
    }
    public int getExchangeIdByOfferId(int offerId) throws SQLException {
        String query = "SELECT exchange_id FROM offer_messages WHERE id = ?";
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, offerId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("exchange_id");
            } else {
                throw new SQLException("No exchange found for offer ID: " + offerId);
            }
        }
    }

    public List<OfferMessageModel> getSentOffersByUserIdAndStatus(int userId, String status) throws SQLException {
        String query = "SELECT om.*, e.status AS exchangeStatus, u.username AS recipientName, i.title AS itemName " +
                "FROM offer_messages om " +
                "JOIN exchanges e ON om.exchange_id = e.id " +
                "JOIN users u ON om.receiver_id = u.id " +
                "JOIN items i ON e.item_id = i.id " +
                "WHERE om.sender_id = ? AND e.status = ?";
        List<OfferMessageModel> offers = new ArrayList<>();
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, userId);
            stmt.setString(2, status);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                OfferMessageModel offer = new OfferMessageModel();
                offer.setId(rs.getInt("id"));
                offer.setExchangeId(rs.getInt("exchange_id"));
                offer.setSenderId(rs.getInt("sender_id"));
                offer.setReceiverId(rs.getInt("receiver_id"));
                offer.setMessage(rs.getString("message"));
                offer.setCreatedAt(rs.getTimestamp("created_at"));
                offer.setRecipientName(rs.getString("recipientName"));
                offer.setItemName(rs.getString("itemName"));
                offers.add(offer);
            }
        }
        return offers;
    }

    public List<OfferMessageModel> getReceivedOffersByUserIdAndStatus(int userId, String status) throws SQLException {
        String query = "SELECT om.*, e.status AS exchangeStatus, u.username AS senderName, i.title AS itemName " +
                "FROM offer_messages om " +
                "JOIN exchanges e ON om.exchange_id = e.id " +
                "JOIN users u ON om.sender_id = u.id " +
                "JOIN items i ON e.item_id = i.id " +
                "WHERE om.receiver_id = ? AND e.status = ?";
        List<OfferMessageModel> offers = new ArrayList<>();
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, userId);
            stmt.setString(2, status);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                OfferMessageModel offer = new OfferMessageModel();
                offer.setId(rs.getInt("id"));
                offer.setExchangeId(rs.getInt("exchange_id"));
                offer.setSenderId(rs.getInt("sender_id"));
                offer.setReceiverId(rs.getInt("receiver_id"));
                offer.setMessage(rs.getString("message"));
                offer.setCreatedAt(rs.getTimestamp("created_at"));
                offer.setSenderName(rs.getString("senderName"));
                offer.setItemName(rs.getString("itemName"));
                offers.add(offer);
            }
        }
        return offers;
    }

    public List<OfferMessageModel> getOffersByStatusAndUserId(int userId, String status) throws SQLException {
        String query = "SELECT om.*, e.status AS exchangeStatus, " +
                "u1.username AS senderName, u2.username AS recipientName, i.title AS itemName, " +
                "CASE WHEN om.sender_id = ? THEN TRUE ELSE FALSE END AS isSentOffer " +
                "FROM offer_messages om " +
                "JOIN exchanges e ON om.exchange_id = e.id " +
                "JOIN users u1 ON om.sender_id = u1.id " +
                "JOIN users u2 ON om.receiver_id = u2.id " +
                "JOIN items i ON e.item_id = i.id " +
                "WHERE e.status = ? AND (om.sender_id = ? OR om.receiver_id = ?)";
        List<OfferMessageModel> offers = new ArrayList<>();
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, userId);
            stmt.setString(2, status);
            stmt.setInt(3, userId);
            stmt.setInt(4, userId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                OfferMessageModel offer = new OfferMessageModel();
                offer.setId(rs.getInt("id"));
                offer.setExchangeId(rs.getInt("exchange_id"));
                offer.setSenderId(rs.getInt("sender_id"));
                offer.setReceiverId(rs.getInt("receiver_id"));
                offer.setMessage(rs.getString("message"));
                offer.setCreatedAt(rs.getTimestamp("created_at"));
                offer.setSenderName(rs.getString("senderName"));
                offer.setRecipientName(rs.getString("recipientName"));
                offer.setItemName(rs.getString("itemName"));
                offer.setStatus(rs.getString("exchangeStatus"));
                offer.setIsSentOffer(rs.getBoolean("isSentOffer"));
                offers.add(offer);
                LOGGER.info("Retrieved offer: " + offer);
            }
        }
        return offers;
    }
    public ExchangeDetails getExchangeDetailsById(int exchangeId) throws SQLException {
        String query = "SELECT e.interested_user_id, i.user_id AS owner_id " +
                "FROM exchanges e " +
                "JOIN items i ON e.item_id = i.id " +
                "WHERE e.id = ?";
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, exchangeId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new ExchangeDetails(rs.getInt("interested_user_id"), rs.getInt("owner_id"));
                } else {
                    throw new SQLException("No exchange found with ID: " + exchangeId);
                }
            }
        }
    }

    public List<OfferMessageModel> getOfferMessagesByExchangeId(int exchangeId) throws SQLException {
        String query = "SELECT om.*, " +
                "sender.username AS senderName, " +
                "receiver.username AS recipientName, " +
                "i.title AS itemName " +
                "FROM offer_messages om " +
                "JOIN users sender ON om.sender_id = sender.id " +
                "JOIN users receiver ON om.receiver_id = receiver.id " +
                "JOIN exchanges e ON om.exchange_id = e.id " +
                "JOIN items i ON e.item_id = i.id " +
                "WHERE om.exchange_id = ?";

        List<OfferMessageModel> offerMessages = new ArrayList<>();
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, exchangeId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                OfferMessageModel offerMessage = new OfferMessageModel();
                offerMessage.setId(rs.getInt("id"));
                offerMessage.setExchangeId(rs.getInt("exchange_id"));
                offerMessage.setSenderId(rs.getInt("sender_id"));
                offerMessage.setReceiverId(rs.getInt("receiver_id"));
                offerMessage.setMessage(rs.getString("message"));
                offerMessage.setCreatedAt(rs.getTimestamp("created_at"));
                offerMessage.setSenderName(rs.getString("senderName"));
                offerMessage.setRecipientName(rs.getString("recipientName"));
                offerMessage.setItemName(rs.getString("itemName"));
                offerMessages.add(offerMessage);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "SQL error while fetching messages by exchange ID", e);
            throw e;
        }
        return offerMessages;
    }

    public static class ExchangeDetails {
        private final int interestedUserId;
        private final int ownerId;

        public ExchangeDetails(int interestedUserId, int ownerId) {
            this.interestedUserId = interestedUserId;
            this.ownerId = ownerId;
        }

        public int getInterestedUserId() {
            return interestedUserId;
        }

        public int getOwnerId() {
            return ownerId;
        }
    }
}
