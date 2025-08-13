package com.servlet.admin;

import com.dao.admin.AdminDAO;
import com.detail.AdminDetail;
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

        AdminDAO dao = new AdminDAO();
        boolean updated = dao.updateAdminProfile(userName, fullName, email, phone);

        if (updated) {
            AdminDetail updatedAdmin = dao.getAdminByUserName(userName);
            req.getSession().setAttribute("admin", updatedAdmin);
            resp.sendRedirect("adminProfile.jsp?msg=success");
        } else {
            resp.getWriter().write("Profile update failed.");
        }
    }
}
