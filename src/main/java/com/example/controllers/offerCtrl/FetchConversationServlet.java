package com.example.controllers.offerCtrl;

import com.example.models.offerMessage.OfferMessageModel;
import com.example.models.offerMessage.OfferMessageModelDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/fetchConversation")
public class FetchConversationServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(FetchConversationServlet.class.getName());

    private OfferMessageModelDAO offerMessageModelDAO;

    @Override
    public void init() {
        offerMessageModelDAO = new OfferMessageModelDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String exchangeIdStr = request.getParameter("exchangeId");

        if (exchangeIdStr == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing exchange ID");
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
            List<OfferMessageModel> messages = offerMessageModelDAO.getOfferMessagesByExchangeId(exchangeId);
            request.setAttribute("messages", messages);
            request.getRequestDispatcher("/conversation.jsp").forward(request, response);
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching conversation messages", e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error fetching conversation messages");
        }
    }
}
