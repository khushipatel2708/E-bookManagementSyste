package com.servlet;

import com.dao.CartDAO;
import com.database.DBConnect;
import auth.User;   // use the same User class as LoginServlet
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class UserDeleteCartServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        
        // ✅ Use "userObj" instead of "userL"
        if (session.getAttribute("userObj") != null) {
            User u = (User) session.getAttribute("userObj");

            int bookId = Integer.parseInt(request.getParameter("bookId"));
            CartDAO dao = new CartDAO(DBConnect.getConnection());

            String result = dao.deleteCart(bookId, u.getId());

            response.setContentType("text/plain");
            try (PrintWriter out = response.getWriter()) {
                out.print(result);  // will be "done" or "no"
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
}
