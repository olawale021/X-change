package com.example.controllers.itemsCtrl;

import com.example.models.category.CategoryModel;
import com.example.models.category.CategoryModelDAO;
import com.example.models.items.ItemsModel;
import com.example.models.items.ItemsModelDAO;

import javax.servlet.RequestDispatcher;
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

@WebServlet("/user-items")
public class UserItemsServlet extends HttpServlet {
    private ItemsModelDAO itemsModelDAO;
    private CategoryModelDAO categoryModelDAO;
    private static final Logger LOGGER = Logger.getLogger(UserItemsServlet.class.getName());

    public void init() {
        itemsModelDAO = new ItemsModelDAO();
        categoryModelDAO = new CategoryModelDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Object userIdObj = session.getAttribute("userId");
        LOGGER.log(Level.INFO, "User ID from session: {0}", userIdObj);

        if (userIdObj == null) {
            LOGGER.log(Level.WARNING, "No user ID found in session, redirecting to login.");
            response.sendRedirect("login.jsp");
            return;
        }

        int userId;
        try {
            userId = Integer.parseInt(userIdObj.toString());
        } catch (NumberFormatException e) {
            LOGGER.log(Level.WARNING, "Invalid user ID format in session, redirecting to login.");
            response.sendRedirect("login.jsp");
            return;
        }

        List<ItemsModel> items = null;
        List<CategoryModel> categories = null;
        try {
            items = itemsModelDAO.getItemsByUserId(userId);
            categories = categoryModelDAO.getAllCategories();
            LOGGER.log(Level.INFO, "Items fetched for user ID {0}: {1}", new Object[]{userId, items});
            LOGGER.log(Level.INFO, "Categories fetched: {0}", categories);

            // Add this block to log each item's photos
            if (items != null) {
                for (ItemsModel item : items) {
                    LOGGER.log(Level.INFO, "Item ID: {0}", item.getId());
                    LOGGER.log(Level.INFO, "Photos JSON: {0}", item.getPhotosJson());
                }
            }

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching items or categories", e);
            throw new ServletException(e);
        }

        if (items == null || items.isEmpty()) {
            request.setAttribute("noItems", "No items found for this user.");
            LOGGER.log(Level.INFO, "No items found for user ID {0}", userId);
        } else {
            request.setAttribute("items", items);
        }

        if (categories != null && !categories.isEmpty()) {
            request.setAttribute("categories", categories);
        } else {
            request.setAttribute("noCategories", "No categories found.");
            LOGGER.log(Level.INFO, "No categories found.");
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("user-items.jsp");
        dispatcher.forward(request, response);
    }
}
