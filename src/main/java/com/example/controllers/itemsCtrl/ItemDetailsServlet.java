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

@WebServlet("/item-detail")
public class ItemDetailsServlet extends HttpServlet {
    private ItemsModelDAO itemsModelDAO;

    public void init() {
        itemsModelDAO = new ItemsModelDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String itemId = request.getParameter("id");
        System.out.println("Item ID: " + itemId);
        if (itemId == null || itemId.isEmpty()) {
            response.sendRedirect("all-items");
            return;
        }

        ItemsModel item = null;
        try {
            item = itemsModelDAO.getItemById(Integer.parseInt(itemId));
        } catch (SQLException e) {
            throw new ServletException(e);
        }

        if (item == null) {
            response.sendRedirect("all-items");
            return;
        }

        request.setAttribute("item", item);
        RequestDispatcher dispatcher = request.getRequestDispatcher("item-detail.jsp");
        dispatcher.forward(request, response);
    }
}
