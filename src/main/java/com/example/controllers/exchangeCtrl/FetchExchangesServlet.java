package com.example.controllers.exchangeCtrl;

import com.example.models.exchange.ExchangeModel;
import com.example.models.exchange.ExchangeModelDAO;
import com.example.models.offerMessage.OfferMessageModelDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/fetchExchanges")
public class FetchExchangesServlet extends HttpServlet {
    private ExchangeModelDAO exchangeModelDAO;
    private OfferMessageModelDAO offerMessageModelDAO;

    @Override
    public void init() {
        exchangeModelDAO = new ExchangeModelDAO();
        offerMessageModelDAO = new OfferMessageModelDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int userId = (int) request.getSession().getAttribute("userId"); // Ensure userId is stored in the session
        try {
            List<ExchangeModel> pendingExchanges = exchangeModelDAO.getExchangesByStatus(userId, "Pending");
            List<ExchangeModel> acceptedExchanges = exchangeModelDAO.getExchangesByStatus(userId, "Accepted");
            List<ExchangeModel> rejectedExchanges = exchangeModelDAO.getExchangesByStatus(userId, "Rejected");

            for (ExchangeModel exchange : pendingExchanges) {
                exchange.setMessages(offerMessageModelDAO.getOfferMessagesByExchangeId(exchange.getId()));
            }
            for (ExchangeModel exchange : acceptedExchanges) {
                exchange.setMessages(offerMessageModelDAO.getOfferMessagesByExchangeId(exchange.getId()));
            }
            for (ExchangeModel exchange : rejectedExchanges) {
                exchange.setMessages(offerMessageModelDAO.getOfferMessagesByExchangeId(exchange.getId()));
            }

            request.setAttribute("pendingExchanges", pendingExchanges);
            request.setAttribute("acceptedExchanges", acceptedExchanges);
            request.setAttribute("rejectedExchanges", rejectedExchanges);
            request.getRequestDispatcher("/user_exchanges.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error fetching exchanges");
        }
    }
}
