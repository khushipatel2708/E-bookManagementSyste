package com.servlet;

import authDAO.UserDAO;
import auth.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "DeleteAccountServlet", urlPatterns = {"/DeleteAccountServlet"})
public class DeleteAccountServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/plain");
        PrintWriter out = response.getWriter();

        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("userObj") != null) {
            User ud = (User) session.getAttribute("userObj");
            int id = ud.getId();

            UserDAO dao = new UserDAO();
            String result = dao.deleteAccount(id);

            if ("done".equals(result)) {
                session.invalidate(); // Logout after deletion
            }

            out.print(result); // AJAX will get this response
        } else {
            out.print("no-session");
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
        return "Handles user account deletion via AJAX";
    }
}
