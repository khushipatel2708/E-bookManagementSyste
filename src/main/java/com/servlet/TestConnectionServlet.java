package com.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

@WebServlet(name = "TestConnectionServlet", urlPatterns = {"/TestConnectionServlet"})
public class TestConnectionServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            String jdbcURL = "jdbc:mysql://localhost:3307/bookmanagementsystem?useSSL=false&serverTimezone=UTC";
            String username = "root";
            String password = "Yesha@123";

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection(jdbcURL, username, password);
                out.println("<h2>✅ MySQL Database Connected Successfully!</h2>");
                conn.close();
            } catch (ClassNotFoundException | SQLException e) {
                out.println("<h2>❌ MySQL Database Connection Failed:</h2>");
                out.println("<pre>" + e.getMessage() + "</pre>");
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
