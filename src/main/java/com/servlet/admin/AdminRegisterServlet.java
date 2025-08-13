package com.servlet.admin;

import com.dao.admin.AdminDAO;
import com.detail.AdminDetail;
import com.javaclass.PasswordEncrypt;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/admin/register")
public class AdminRegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String fullName = req.getParameter("fullName");
        String phone = req.getParameter("phone");
        String userName = req.getParameter("userName");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String confirmPassword = req.getParameter("confirmPassword");

        // ✅ Password match check
        if (!password.equals(confirmPassword)) {
            resp.getWriter().write("Passwords do not match.");
            return;
        }

        // ✅ Encrypt the password
        String encryptedPassword = PasswordEncrypt.hashPassword(password);

        AdminDetail admin = new AdminDetail();
        admin.setFullName(fullName);
        admin.setPhone(phone);
        admin.setUserName(userName);
        admin.setEmail(email);
        admin.setPassword(encryptedPassword);  // Save encrypted password

        AdminDAO dao = new AdminDAO();
        boolean result = dao.registerAdmin(admin);

        if (result) {
            resp.sendRedirect("adminLogin.jsp?msg=registered");
        } else {
            resp.getWriter().write("Admin not registered. Something went wrong.");
        }
    }
}
