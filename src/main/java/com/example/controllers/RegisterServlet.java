package com.example.controllers;

import com.example.models.users.UserModel;
import com.example.models.users.UserModelDAO;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserModelDAO userModelDAO;

    public void init() {
        userModelDAO = new UserModelDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("Register.jsp");
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String addressStreet = request.getParameter("addressStreet");
        String addressCity = request.getParameter("addressCity");
        String addressCountry = request.getParameter("addressCountry");
        String addressZipCode = request.getParameter("addressZipCode");

        UserModel newUser = new UserModel();
        newUser.setUsername(username);
        newUser.setPassword(password);
        newUser.setAddressStreet(addressStreet);
        newUser.setAddressCity(addressCity);
        newUser.setAddressCountry(addressCountry);
        newUser.setAddressZipCode(addressZipCode);

        try {
            userModelDAO.addUser(newUser);
        } catch (SQLException e) {
            throw new ServletException(e);
        }

        // Redirect to success page
        response.sendRedirect("Index.jsp");
    }
}
