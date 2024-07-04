package com.example.controllers.offerCtrl;

import com.example.models.offerMessage.OfferMessageModel;
import com.example.models.offerMessage.OfferMessageModelDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/offers")
public class OfferServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(OfferServlet.class.getName());
    private OfferMessageModelDAO offerMessageModelDAO;

    @Override
    public void init() {
        offerMessageModelDAO = new OfferMessageModelDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            LOGGER.log(Level.WARNING, "No user ID found in session, redirecting to login.");
            response.sendRedirect("login.jsp");
            return;
        }

        int loggedUserId;
        try {
            loggedUserId = (int) session.getAttribute("userId");
        } catch (NumberFormatException e) {
            LOGGER.log(Level.WARNING, "Invalid user ID format in session, redirecting to login.");
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            List<OfferMessageModel> pendingOffers = offerMessageModelDAO.getOffersByStatusAndUserId(loggedUserId, "Pending");
            List<OfferMessageModel> acceptedOffers = offerMessageModelDAO.getOffersByStatusAndUserId(loggedUserId, "Accepted");
            List<OfferMessageModel> rejectedOffers = offerMessageModelDAO.getOffersByStatusAndUserId(loggedUserId, "Rejected");

            request.setAttribute("pendingOffers", pendingOffers);
            request.setAttribute("acceptedOffers", acceptedOffers);
            request.setAttribute("rejectedOffers", rejectedOffers);

            LOGGER.info("Pending Offers: " + pendingOffers);
            LOGGER.info("Accepted Offers: " + acceptedOffers);
            LOGGER.info("Rejected Offers: " + rejectedOffers);

            request.getRequestDispatcher("/offers.jsp").forward(request, response);
        } catch (SQLException e) {
            LOGGER.severe("Error retrieving offers: " + e.getMessage());
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error retrieving offers");
        }
    }
}
