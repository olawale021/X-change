package com.example.controllers.exchangeCtrl;

import com.example.models.exchange.ExchangeModel;
import com.example.models.exchange.ExchangeModelDAO;
import com.example.models.items.ItemsModel;
import com.example.models.items.ItemsModelDAO;
import com.example.models.offerMessage.OfferMessageModel;
import com.example.models.offerMessage.OfferMessageModelDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.logging.Logger;

@WebServlet("/exchange")
public class ExchangeServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(ExchangeServlet.class.getName());
    private ExchangeModelDAO exchangeModelDAO;
    private OfferMessageModelDAO offerMessageModelDAO;
    private ItemsModelDAO itemsModelDAO;

    @Override
    public void init() {
        exchangeModelDAO = new ExchangeModelDAO();
        offerMessageModelDAO = new OfferMessageModelDAO();
        itemsModelDAO = new ItemsModelDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String itemIdStr = request.getParameter("itemId");
        String interestedUserIdStr = request.getParameter("interestedUserId");
        String offerMessageContent = request.getParameter("offerMessage");

        if (itemIdStr == null || interestedUserIdStr == null || offerMessageContent == null ||
                itemIdStr.isEmpty() || interestedUserIdStr.isEmpty() || offerMessageContent.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing required parameters");
            return;
        }

        try {
            int itemId = Integer.parseInt(itemIdStr);
            int interestedUserId = Integer.parseInt(interestedUserIdStr);

            // Retrieve the item to get the ownerId
            ItemsModel item = itemsModelDAO.getItemById(itemId);
            if (item == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Item not found");
                return;
            }
            int ownerId = item.getUserId();

            String status = "Pending";
            Timestamp timestamp = new Timestamp(System.currentTimeMillis());

            // Create the exchange
            ExchangeModel exchange = new ExchangeModel();
            exchange.setItemId(itemId);
            exchange.setInterestedUserId(interestedUserId);
            exchange.setStatus(status);
            exchange.setCreatedAt(timestamp);
            exchange.setUpdatedAt(timestamp);

            exchangeModelDAO.createExchange(exchange);
            sendOfferMessage(exchange.getId(), ownerId, interestedUserId, offerMessageContent);

            LOGGER.info("Offer sent successfully: " + exchange);
            response.sendRedirect(request.getContextPath() + "/item-detail?id=" + itemId);
        } catch (NumberFormatException e) {
            LOGGER.severe("Invalid number format: " + e.getMessage());
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid number format");
        } catch (SQLException e) {
            LOGGER.severe("Error sending offer: " + e.getMessage());
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error sending offer");
        }
    }

    private void sendOfferMessage(int exchangeId, int ownerId, int interestedUserId, String offerMessageContent) {
        // Log the offer details
        LOGGER.info("Sending offer message to owner: " + ownerId + " from user: " + interestedUserId + " for item: " + exchangeId);
        LOGGER.info("Offer message: " + offerMessageContent);

        // Store the offer message in the database
        try {
            OfferMessageModel offerMessage = new OfferMessageModel();
            offerMessage.setExchangeId(exchangeId);
            offerMessage.setSenderId(interestedUserId);
            offerMessage.setReceiverId(ownerId);
            offerMessage.setMessage(offerMessageContent);
            offerMessage.setCreatedAt(new Timestamp(System.currentTimeMillis()));

            offerMessageModelDAO.createOfferMessage(offerMessage);
            LOGGER.info("Offer message stored successfully in the database");
        } catch (SQLException e) {
            LOGGER.severe("Error storing offer message: " + e.getMessage());
        }
    }
}
