/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.servlet;

import com.dao.CartDAO;
import com.database.DBConnect;
import auth.User; // ✅ same class as in LoginServlet
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author chetan
 */
public class UserTotalCartServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();

        // ✅ Use the same session attribute as LoginServlet
        if (session.getAttribute("userObj") != null) {
            CartDAO dao = new CartDAO(DBConnect.getConnection());
            User u = (User) session.getAttribute("userObj");

            int total = dao.totalCart(u.getId());

            try (PrintWriter out = response.getWriter()) {
                out.println(total);
            }   
        } else {
            try (PrintWriter out = response.getWriter()) {
                out.println("login"); // optional: force login if not logged in
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
        return "Returns total cart count for logged-in user";
    }

}
