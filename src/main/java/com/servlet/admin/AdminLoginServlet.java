package com.servlet.admin;

import com.dao.admin.AdminDAO;
import com.detail.AdminDetail;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "AdminLoginServlet", urlPatterns = {"/AdminLoginServlet"})
public class AdminLoginServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String userName = request.getParameter("name");
        String password = request.getParameter("password");

        AdminDAO dao = new AdminDAO();

        // First check login is valid
        AdminDetail loginAttempt = new AdminDetail();
        loginAttempt.setUserName(userName);
        loginAttempt.setPassword(password);

        String done = dao.adminLogin(loginAttempt);  // returns "done" if success

        if (done.equals("done")) {
            // ✅ Fetch complete admin details from DB after successful login
            AdminDetail fullAdmin = dao.getAdminByUserName(userName);
            
            if (fullAdmin != null) {
                HttpSession session = request.getSession();
                session.setAttribute("admin", fullAdmin); // ✅ store full data in session
            }
        }

        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println(done); // return result to front-end (e.g., JS or form)
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
        return "Handles admin login authentication";
    }
}
