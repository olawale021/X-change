package com.example.servlet;

import com.example.utils.WekaModelLoader;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/classify")
public class ClassificationServlet extends HttpServlet {

    private WekaModelLoader wekaModelLoader;

    @Override
    public void init() throws ServletException {
        super.init();
        try {
            wekaModelLoader = new WekaModelLoader("/Users/olawale/Desktop/javacs/X-change/src/main/resources/NaiveBayes.model");
        } catch (Exception e) {
            throw new ServletException("Error initializing Weka model", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("form.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String brand = request.getParameter("brand");
        String model = request.getParameter("model");
        String type = request.getParameter("type");
        String colour = request.getParameter("colour");
        String ram = request.getParameter("ram");
        String size = request.getParameter("size");

        try {
            String predictedCategory = wekaModelLoader.predictCategory(brand, model, type, colour, ram, size);
            request.setAttribute("predictedCategory", predictedCategory);
        } catch (Exception e) {
            throw new ServletException("Error predicting category", e);
        }

        request.getRequestDispatcher("form.jsp").forward(request, response);
    }
}
