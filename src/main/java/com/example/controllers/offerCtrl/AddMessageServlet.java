package com.example.controllers.offerCtrl;

import com.example.models.offerMessage.OfferMessageModel;
import com.example.models.offerMessage.OfferMessageModelDAO;
import com.example.models.offerMessage.OfferMessageModelDAO.ExchangeDetails;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/addMessage")
public class AddMessageServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(AddMessageServlet.class.getName());
    private OfferMessageModelDAO offerMessageModelDAO;

    @Override
    public void init() {
        offerMessageModelDAO = new OfferMessageModelDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String exchangeIdStr = request.getParameter("exchangeId");
        String senderIdStr = request.getParameter("senderId");
        String messageText = request.getParameter("message");

        if (exchangeIdStr == null || exchangeIdStr.isEmpty() ||
                senderIdStr == null || senderIdStr.isEmpty() ||
                messageText == null || messageText.isEmpty()) {
            LOGGER.log(Level.WARNING, "Missing or empty parameters");
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing or empty parameters");
            return;
        }

        int exchangeId;
        int senderId;
        try {
            exchangeId = Integer.parseInt(exchangeIdStr);
            senderId = Integer.parseInt(senderIdStr);
        } catch (NumberFormatException e) {
            LOGGER.log(Level.WARNING, "Invalid parameter format", e);
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid parameter format");
            return;
        }

        try {
            // Fetch exchange details to determine the receiver
            ExchangeDetails exchangeDetails = offerMessageModelDAO.getExchangeDetailsById(exchangeId);
            int receiverId;
            if (senderId == exchangeDetails.getInterestedUserId()) {
                receiverId = exchangeDetails.getOwnerId();
            } else if (senderId == exchangeDetails.getOwnerId()) {
                receiverId = exchangeDetails.getInterestedUserId();
            } else {
                LOGGER.log(Level.WARNING, "Sender ID does not match exchange details");
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid sender ID");
                return;
            }

            // Create the new message
            OfferMessageModel newMessage = new OfferMessageModel();
            newMessage.setExchangeId(exchangeId);
            newMessage.setSenderId(senderId);
            newMessage.setReceiverId(receiverId);
            newMessage.setMessage(messageText);
            newMessage.setCreatedAt(new Timestamp(System.currentTimeMillis()));

            // Save the new message
            offerMessageModelDAO.createOfferMessage(newMessage);
            response.sendRedirect("fetchConversation?exchangeId=" + exchangeId);
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error adding new message", e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error adding new message");
        }
    }
}
