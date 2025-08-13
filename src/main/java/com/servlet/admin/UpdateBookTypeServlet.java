package com.servlet.admin;

import com.dao.admin.BookTypeDAO;
import com.detail.BookTypeDetail;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/admin/updateBookType")
public class UpdateBookTypeServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int id = Integer.parseInt(req.getParameter("id"));
        String typeName = req.getParameter("typeName");
        String description = req.getParameter("description");

        BookTypeDetail type = new BookTypeDetail();
        type.setId(id);
        type.setTypeName(typeName);
        type.setDescription(description);

        BookTypeDAO dao = new BookTypeDAO();
        if (dao.updateBookType(type)) {
            resp.sendRedirect(req.getContextPath() + "/admin/bookTypeList.jsp?msg=updated");
        } else {
            resp.sendRedirect(req.getContextPath() + "/admin/bookTypeList.jsp?msg=error");
        }
    }
}
