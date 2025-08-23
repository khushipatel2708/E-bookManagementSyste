package com.servlet;

import com.dao.ShippingDAO;
import com.database.DBConnect;
import com.detail.ShippingDetail;
import auth.User; // use same model as JSP

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class ShippingAddressServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("userObj"); // ✅ same attribute as JSP

        if (user != null) {
            int userId = user.getId();

            String name = request.getParameter("name");
            String phone = request.getParameter("phone");
            String address1 = request.getParameter("add1");
            String address2 = request.getParameter("add2");
            String landmark = request.getParameter("lMark");
            String city = request.getParameter("city");
            String pinCode = request.getParameter("pin");

            ShippingDetail sd = new ShippingDetail();
            sd.setName(name);
            sd.setPhone(phone);
            sd.setAddress1(address1);
            sd.setAddress2(address2);
            sd.setLandmark(landmark);
            sd.setCity(city);
            sd.setPinCode(pinCode);
            sd.setUserId(userId);

            ShippingDAO dao = new ShippingDAO(DBConnect.getConnection());
            String result = dao.insertAddress(sd);

            response.setContentType("text/plain");
            try (PrintWriter out = response.getWriter()) {
                out.print(result); // "done" or "no" → handled by AJAX
            }

        } else {
            response.sendRedirect("./index.jsp");
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
