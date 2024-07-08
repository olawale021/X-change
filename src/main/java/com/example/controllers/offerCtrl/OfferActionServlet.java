package com.example.controllers.offerCtrl;

import com.example.models.exchange.ExchangeModelDAO;
import com.example.models.offerMessage.OfferMessageModelDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/offerAction")
public class OfferActionServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(OfferActionServlet.class.getName());
    private OfferMessageModelDAO offerMessageModelDAO;
    private ExchangeModelDAO exchangeModelDAO;

    @Override
    public void init() {
        offerMessageModelDAO = new OfferMessageModelDAO();
        exchangeModelDAO = new ExchangeModelDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String exchangeIdStr = request.getParameter("exchangeId");
        String action = request.getParameter("action");

        if (exchangeIdStr == null || action == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing exchange ID or action");
            return;
        }

        int exchangeId;
        try {
            exchangeId = Integer.parseInt(exchangeIdStr);
        } catch (NumberFormatException e) {
            LOGGER.log(Level.WARNING, "Invalid exchange ID format: " + exchangeIdStr);
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid exchange ID format");
            return;
        }

        try {
            // Determine userId based on itemId
            int itemId = exchangeModelDAO.getItemIdByExchangeId(exchangeId);
            int userId = exchangeModelDAO.getUserIdByItemId(itemId);

            if ("accept".equals(action)) {
                exchangeModelDAO.updateExchangeStatus(exchangeId, "Accepted");
                LOGGER.info("Exchange accepted: " + exchangeId);
            } else if ("reject".equals(action)) {
                exchangeModelDAO.updateExchangeStatus(exchangeId, "Rejected");
                LOGGER.info("Exchange rejected: " + exchangeId);
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
                return;
            }
            response.sendRedirect("offers");
        } catch (SQLException e) {
            LOGGER.severe("Error processing offer action: " + e.getMessage());
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error processing offer action");
        }
    }
}
