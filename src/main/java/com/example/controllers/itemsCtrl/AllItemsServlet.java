package com.example.controllers.itemsCtrl;

import com.example.models.items.ItemsModel;
import com.example.models.items.ItemsModelDAO;

import javax.servlet.RequestDispatcher;
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

@WebServlet("/")
public class AllItemsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ItemsModelDAO itemsModelDAO;
    private static final Logger LOGGER = Logger.getLogger(AllItemsServlet.class.getName());

    public void init() {
        itemsModelDAO = new ItemsModelDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            LOGGER.info("Fetching items from database.");
            List<ItemsModel> items = itemsModelDAO.getAllItems();

            if (items == null || items.isEmpty()) {
                LOGGER.info("No items found in the database.");
            } else {
                LOGGER.info("Items fetched from database: " + items.size());
            }
            request.setAttribute("items", items);
            LOGGER.info("Items set as request attribute.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("home.jsp");
            dispatcher.forward(request, response);
            LOGGER.info("Request dispatched to home.jsp.");
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching items from database", e);
            throw new ServletException(e);
        }
    }
}