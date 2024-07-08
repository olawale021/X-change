package com.example.models.exchange;

import com.example.models.offerMessage.OfferMessageModel;

import java.sql.Timestamp;
import java.util.List;

public class ExchangeModel {
    private int id;
    private int itemId;
    private int interestedUserId;
    private String status;
    private String itemName;
    private String senderName;
    private String recipientName;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    private boolean isSentByCurrentUser;
    private boolean isReceivedByCurrentUser;
    private List<OfferMessageModel> messages;

    // Default constructor
    public ExchangeModel() {
    }

    // Constructor with all fields
    public ExchangeModel(int id, int itemId, int interestedUserId, String status, String itemName, String senderName, String recipientName, Timestamp createdAt, Timestamp updatedAt) {
        this.id = id;
        this.itemId = itemId;
        this.interestedUserId = interestedUserId;
        this.status = status;
        this.itemName = itemName;
        this.senderName = senderName;
        this.recipientName = recipientName;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    // Getters and setters for all fields
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getItemId() {
        return itemId;
    }

    public void setItemId(int itemId) {
        this.itemId = itemId;
    }

    public int getInterestedUserId() {
        return interestedUserId;
    }

    public void setInterestedUserId(int interestedUserId) {
        this.interestedUserId = interestedUserId;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getItemName() {
        return itemName;
    }

    public void setItemName(String itemName) {
        this.itemName = itemName;
    }

    public String getSenderName() {
        return senderName;
    }

    public void setSenderName(String senderName) {
        this.senderName = senderName;
    }

    public String getRecipientName() {
        return recipientName;
    }

    public void setRecipientName(String recipientName) {
        this.recipientName = recipientName;
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

    public boolean isSentByCurrentUser() {
        return isSentByCurrentUser;
    }

    public void setSentByCurrentUser(boolean sentByCurrentUser) {
        isSentByCurrentUser = sentByCurrentUser;
    }

    public boolean isReceivedByCurrentUser() {
        return isReceivedByCurrentUser;
    }

    public void setReceivedByCurrentUser(boolean receivedByCurrentUser) {
        isReceivedByCurrentUser = receivedByCurrentUser;
    }

    public List<OfferMessageModel> getMessages() {
        return messages;
    }

    public void setMessages(List<OfferMessageModel> messages) {
        this.messages = messages;
    }
}
