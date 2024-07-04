package com.example.models.offerMessage;

import java.sql.Timestamp;

public class OfferMessageModel {
    private int id;
    private int exchangeId;
    private int senderId;
    private int receiverId;
    private String message;
    private Timestamp createdAt;
    private String senderName;
    private String itemName;
    private String recipientName;
    private String status;
    private boolean isSentOffer;

    // Default constructor
    public OfferMessageModel() {
    }


    // Constructor with all fields
    public OfferMessageModel(int id, int exchangeId, int senderId, int receiverId, String message,
                             String senderName, String itemName, String recipientName,
                             String status, Boolean isSentOffer, Timestamp createdAt) {
        this.id = id;
        this.exchangeId = exchangeId;
        this.senderId = senderId;
        this.receiverId = receiverId;
        this.message = message;
        this.createdAt = createdAt;
        this.senderName = senderName;
        this.itemName = itemName;
        this.recipientName = recipientName;
        this.status = status;
        this.isSentOffer = isSentOffer;
    }

    // Getters and setters for all fields
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getExchangeId() {
        return exchangeId;
    }

    public void setExchangeId(int exchangeId) {
        this.exchangeId = exchangeId;
    }

    public int getSenderId() {
        return senderId;
    }

    public void setSenderId(int senderId) {
        this.senderId = senderId;
    }

    public int getReceiverId() {
        return receiverId;
    }

    public void setReceiverId(int receiverId) {
        this.receiverId = receiverId;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
    public String getSenderName() {
        return senderName;
    }

    public void setSenderName(String senderName) {
        this.senderName = senderName;
    }

    public String getItemName() {
        return itemName;
    }

    public void setItemName(String itemName) {
        this.itemName = itemName;
    }

    public String getRecipientName() {
        return recipientName;
    }

    public void setRecipientName(String recipientName) {
        this.recipientName = recipientName;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public boolean getIsSentOffer() {
        return isSentOffer;
    }

    public void setIsSentOffer(boolean sentOffer) {
        isSentOffer = sentOffer;
    }
}
