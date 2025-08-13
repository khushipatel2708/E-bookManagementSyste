package com.servlet;

import com.dao.OrderDAO;
import com.database.DBConnect;
import com.detail.UserDetail;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class UserConfirmOrderServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        
        try (PrintWriter out = response.getWriter()) {
            
            UserDetail ud = (UserDetail) session.getAttribute("userL");
            
            if (ud == null) {
                out.print("error");
                return;
            }

            if (!ud.isActive()) {
                out.print("verify");
                return;
            }

            String pMethod = request.getParameter("pMethod"); // "cod" or "online"

            if (pMethod == null || pMethod.trim().isEmpty()) {
                out.print("error");
                return;
            }

            int id = ud.getId();
            OrderDAO dao = new OrderDAO(DBConnect.getConnection());

            // Confirm order and pass payment method
            String done = dao.confirmOrder(ud.getEmail(), id, pMethod);

            out.print(done); // expected "done", "verify", or "error"
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().print("error");
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
        return "Handles order confirmation with different payment methods";
    }
}
