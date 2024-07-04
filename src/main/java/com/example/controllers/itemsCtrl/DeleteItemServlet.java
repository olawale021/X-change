package com.example.controllers.itemsCtrl;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import com.example.models.items.ItemsModelDAO;
import com.example.utils.CloudinaryConfig;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

@WebServlet("/delete-item")
public class DeleteItemServlet extends HttpServlet {
    private ItemsModelDAO itemsModelDAO;
    private static final Logger LOGGER = Logger.getLogger(DeleteItemServlet.class.getName());
    private Cloudinary cloudinary;

    @Override
    public void init() {
        itemsModelDAO = new ItemsModelDAO();
        cloudinary = CloudinaryConfig.getCloudinary();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        handleRequest(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        handleRequest(request, response);
    }

    private void handleRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String itemIdParam = request.getParameter("itemId");
        if (itemIdParam == null || itemIdParam.isEmpty()) {
            // Try to get the 'id' parameter if 'itemId' is not present
            itemIdParam = request.getParameter("id");
        }

        LOGGER.info("Received itemId parameter: " + itemIdParam);

        if (itemIdParam == null || itemIdParam.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Item ID is required");
            return;
        }

        int itemId;
        try {
            itemId = Integer.parseInt(itemIdParam);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Item ID");
            return;
        }

        try {
//            String photosJson = itemsModelDAO.getItemPhotosJson(itemId);
            boolean deleted = itemsModelDAO.deleteItem(itemId);

            if (deleted) {
//                deleteImagesFromCloudinary(photosJson);
                response.sendRedirect("user-items");
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Item not found");
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error deleting item", e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while deleting the item. Please try again later.");
        }
    }

    private void deleteImagesFromCloudinary(String photosJson) {
        if (photosJson != null && !photosJson.isEmpty()) {
            List<String> photos = new Gson().fromJson(photosJson, new TypeToken<List<String>>() {}.getType());
            for (String photoUrl : photos) {
                String publicId = getCloudinaryPublicId(photoUrl);
                if (publicId != null) {
                    try {
                        Map result = cloudinary.uploader().destroy(publicId, ObjectUtils.emptyMap());
                        LOGGER.info("Deleted image from Cloudinary: " + result);
                    } catch (Exception e) {
                        LOGGER.log(Level.SEVERE, "Failed to delete image from Cloudinary: " + photoUrl, e);
                    }
                }
            }
        }
    }

    private String getCloudinaryPublicId(String photoUrl) {
        try {
            int start = photoUrl.lastIndexOf('/') + 1;
            int end = photoUrl.lastIndexOf('.');
            return photoUrl.substring(start, end);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Failed to extract Cloudinary public ID from URL: " + photoUrl, e);
            return null;
        }
    }
}
