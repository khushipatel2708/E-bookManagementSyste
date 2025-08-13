package com.servlet.admin;

import com.dao.admin.BookTypeDAO;
import com.detail.BookTypeDetail;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/admin/addBookType")
public class AddBookTypeServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String typeName = req.getParameter("typeName");
        String description = req.getParameter("description");

        BookTypeDetail type = new BookTypeDetail();
        type.setTypeName(typeName);
        type.setDescription(description);

        BookTypeDAO dao = new BookTypeDAO();
        if (dao.addBookType(type)) {
            resp.sendRedirect(req.getContextPath() + "/admin/bookTypeList.jsp?msg=added");
        } else {
            resp.sendRedirect(req.getContextPath() + "/admin/bookTypeList.jsp?msg=error");
        }
    }
}
