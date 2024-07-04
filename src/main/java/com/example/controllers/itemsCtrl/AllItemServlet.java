package com.example.controllers.itemsCtrl;

import com.example.models.category.CategoryModel;
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
import java.util.Set;
import java.util.stream.Collectors;

@WebServlet("/all-items")
public class AllItemServlet extends HttpServlet {
    private ItemsModelDAO itemsModelDAO;

    public void init() {
        itemsModelDAO = new ItemsModelDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<ItemsModel> items = null;
        List<CategoryModel> categories = null;

        try {
            items = itemsModelDAO.getAllItems();
            categories = itemsModelDAO.getAllCategories();
        } catch (SQLException e) {
            throw new ServletException("Error fetching items or categories", e);
        }

        request.setAttribute("items", items);
        request.setAttribute("categories", categories);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/all-items.jsp");
        dispatcher.forward(request, response);
    }
}
