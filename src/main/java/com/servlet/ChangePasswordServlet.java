package com.servlet;

import com.dao.UserDAO;
import com.detail.UserDetail;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "ChangePasswordServlet", urlPatterns = {"/ChangePasswordServlet"})
public class ChangePasswordServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        if (session.getAttribute("userL") != null) {
            UserDetail ud = (UserDetail) session.getAttribute("userL");
            int id = ud.getId();

            String oPassword = request.getParameter("oPassword").trim();
            String nPassword = request.getParameter("nPassword").trim();

            UserDAO dao = new UserDAO();
            String done = dao.changePassword(id, oPassword, nPassword);

            response.setContentType("text/html;charset=UTF-8");
            try (PrintWriter out = response.getWriter()) {
                out.println(done); // e.g., "done" or "wrong"
            }
        } else {
            response.sendRedirect("userLogin.jsp"); // optional: redirect if user not logged in
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
        return "Handles user password change";
    }
}
