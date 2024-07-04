package com.example.controllers.itemsCtrl;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import com.example.models.items.ItemsModel;
import com.example.models.items.ItemsModelDAO;
import com.example.utils.CloudinaryConfig;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import com.google.gson.Gson;

@WebServlet("/update-item")
@MultipartConfig
public class UpdateItemServlet extends HttpServlet {
    private ItemsModelDAO itemsModelDAO;
    private static final Logger LOGGER = Logger.getLogger(UpdateItemServlet.class.getName());
    private Cloudinary cloudinary;

    public void init() {
        itemsModelDAO = new ItemsModelDAO();
        cloudinary = CloudinaryConfig.getCloudinary();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int itemId = Integer.parseInt(request.getParameter("itemId"));
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        String condition = request.getParameter("condition");

        ItemsModel item = new ItemsModel();
        item.setId(itemId);
        item.setTitle(title);
        item.setDescription(description);
        item.setCategoryId(categoryId);
        item.setCondition(condition);

        List<String> photos = new ArrayList<>();
        for (Part part : request.getParts()) {
            if (part.getName().equals("newImages") && part.getSize() > 0) {
                File tempFile = File.createTempFile("upload_", part.getSubmittedFileName());
                part.write(tempFile.getAbsolutePath());

                try {
                    Map uploadResult = cloudinary.uploader().upload(tempFile, ObjectUtils.emptyMap());
                    String photoUrl = (String) uploadResult.get("secure_url");
                    photos.add(photoUrl);
                    tempFile.delete();
                } catch (Exception e) {
                    LOGGER.log(Level.SEVERE, "Image upload failed", e);
                    throw new ServletException("Image upload failed", e);
                }
            }
        }

        // Combine new photos with existing photos
        String existingPhotosJson = request.getParameter("existingPhotosJson");
        if (existingPhotosJson != null && !existingPhotosJson.isEmpty()) {
            // Remove surrounding quotes and split by comma
            String cleanedJson = existingPhotosJson.replaceAll("[\\[\\]\\s]", "");
            if (!cleanedJson.isEmpty()) {
                String[] existingPhotos = cleanedJson.split(",");
                for (String photo : existingPhotos) {
                    photos.add(photo.replace("\"", "")); // Remove any remaining quotes
                }
            }
        }

        // Remove any empty strings that might cause formatting issues
        photos.removeIf(String::isEmpty);

        // Convert list of photos to JSON
        String photosJson = new Gson().toJson(photos); // Use Gson to create a properly formatted JSON array
        item.setPhotosJson(photosJson);

        try {
            itemsModelDAO.updateItem(item.getId(), item);
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating item", e);
            throw new ServletException("Error updating item", e);
        }

        response.sendRedirect("user-items");
    }
}
