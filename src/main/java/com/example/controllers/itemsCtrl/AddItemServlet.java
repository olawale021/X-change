package com.example.controllers.itemsCtrl;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import com.example.models.category.CategoryModel;
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
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
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
        try {
            List<CategoryModel> categories = itemsModelDAO.getAllCategories();
            request.setAttribute("categories", categories);
            RequestDispatcher dispatcher = request.getRequestDispatcher("add-item.jsp");
            dispatcher.forward(request, response);
        } catch (SQLException e) {
            LOGGER.severe("Error fetching categories: " + e.getMessage());
            throw new ServletException(e);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserModel user = (UserModel) session.getAttribute("user");

        if (user == null) {
            LOGGER.warning("User not logged in, redirecting to login page.");
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = user.getId();
        LOGGER.info("User ID: " + userId);

        String title = request.getParameter("title");
        String description = request.getParameter("description");
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        String condition = request.getParameter("condition");

        LOGGER.info("Received item details: title=" + title + ", description=" + description + ", categoryId=" + categoryId + ", condition=" + condition);

        List<String> imageUrls = new ArrayList<>();
        try {
            for (Part part : request.getParts()) {
                LOGGER.info("Processing part: " + part.getName() + ", Content type: " + part.getContentType() + ", Size: " + part.getSize());

                if (part.getName().equals("images") && part.getSize() > 0 && part.getContentType() != null && part.getContentType().startsWith("image/")) {
                    try (InputStream fileContent = part.getInputStream()) {
                        byte[] buffer = new byte[8192];
                        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
                        int bytesRead;
                        while ((bytesRead = fileContent.read(buffer)) != -1) {
                            outputStream.write(buffer, 0, bytesRead);
                        }
                        byte[] fileBytes = outputStream.toByteArray();

                        Map uploadResult = cloudinary.uploader().upload(fileBytes, ObjectUtils.emptyMap());
                        String imageUrl = uploadResult.get("url").toString();
                        imageUrls.add(imageUrl);
                        LOGGER.info("Uploaded image URL: " + imageUrl);
                    } catch (Exception e) {
                        LOGGER.severe("Image upload failed: " + e.getMessage());
                        throw new ServletException("Image upload failed", e);
                    }
                } else {
                    LOGGER.info("Skipping part: " + part.getName());
                }
            }
        } catch (IOException | ServletException e) {
            LOGGER.severe("Error processing parts: " + e.getMessage());
            throw e;
        }

        LOGGER.info("Total images uploaded: " + imageUrls.size());

        ItemsModel newItem = new ItemsModel();
        newItem.setUserId(userId);
        newItem.setTitle(title);
        newItem.setDescription(description);
        newItem.setCondition(condition);
        newItem.setCategoryId(categoryId);
        newItem.setPhotos(imageUrls);  // Set the list of image URLs
        newItem.setCreatedAt(new Timestamp(System.currentTimeMillis()));
        newItem.setUpdatedAt(new Timestamp(System.currentTimeMillis()));

        LOGGER.info("Creating new item: " + newItem);

        try {
            itemsModelDAO.addItem(newItem);
            LOGGER.info("Item successfully added with ID: " + newItem.getId());
            response.sendRedirect("user-dashboard.jsp");
        } catch (SQLException e) {
            LOGGER.severe("Error adding item: " + e.getMessage());
            throw new ServletException(e);
        }
    }
}




