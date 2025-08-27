package com.servlet.admin;

import authDAO.UserDAO;
import auth.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/admin/updateProfile")
public class UpdateProfileServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String userName = req.getParameter("userName");
        String fullName = req.getParameter("fullName");
        String email = req.getParameter("email");
        String phone = req.getParameter("phone");

        UserDAO dao = new UserDAO();
        boolean updated = dao.updateUserProfile(userName, fullName, email, phone); // 👈 implement in UserDAO

        if (updated) {
            User updatedAdmin = dao.getUserByUsername(userName); // 👈 implement in UserDAO
            req.getSession().setAttribute("adminObj", updatedAdmin);
            resp.sendRedirect("adminProfile.jsp?msg=success");
        } else {
            resp.sendRedirect("adminProfile.jsp?msg=fail");
        }
    }
}
