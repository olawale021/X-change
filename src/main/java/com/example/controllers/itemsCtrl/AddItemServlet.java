package com.example.controllers.itemsCtrl;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import com.example.models.items.ItemsModelDAO;
import com.example.models.items.ItemsModel;
import com.example.models.users.UserModel;
import com.example.utils.CloudinaryConfig;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;
import java.util.Map;
import java.util.logging.Logger;

@WebServlet("/additem")
@MultipartConfig
public class AddItemServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ItemsModelDAO itemsModelDAO;
    private Cloudinary cloudinary;
    private static final Logger LOGGER = Logger.getLogger(AddItemServlet.class.getName());


    public void init() {
        itemsModelDAO = new ItemsModelDAO();
        cloudinary = CloudinaryConfig.getCloudinary();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("add-item.jsp");
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserModel user = (UserModel) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = user.getId();
        LOGGER.info("User ID: " + userId);

        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String category = request.getParameter("category");
        String condition = request.getParameter("condition");
        String location = request.getParameter("location");
        String exchangePreferences = request.getParameter("exchangePreferences");
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        Part filePart = request.getPart("image");
        String imageUrl = null;

        if (filePart != null && filePart.getSize() > 0) {
            try (InputStream fileContent = filePart.getInputStream()) {
                byte[] buffer = new byte[8192];
                ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
                int bytesRead;
                while ((bytesRead = fileContent.read(buffer)) != -1) {
                    outputStream.write(buffer, 0, bytesRead);
                }
                byte[] fileBytes = outputStream.toByteArray();

                Map uploadResult = cloudinary.uploader().upload(fileBytes, ObjectUtils.emptyMap());
                imageUrl = uploadResult.get("url").toString();
            } catch (Exception e) {
                throw new ServletException("Image upload failed", e);
            }
        }

        ItemsModel newItem = new ItemsModel();
        newItem.setUserId(userId);
        newItem.setName(name);
        newItem.setDescription(description);
        newItem.setImageUrl(imageUrl);
        newItem.setCategory(category);
        newItem.setCondition(condition);
        newItem.setLocation(location);
        newItem.setExchangePreferences(exchangePreferences);
        newItem.setQuantity(quantity);

        try {
            itemsModelDAO.addItem(newItem);
            response.sendRedirect("user-dashboard.jsp");
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}