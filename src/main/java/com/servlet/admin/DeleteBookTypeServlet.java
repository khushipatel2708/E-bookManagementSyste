package com.servlet.admin;

import com.dao.admin.BookTypeDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/admin/deleteBookType")
public class DeleteBookTypeServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int id = Integer.parseInt(req.getParameter("id"));
        BookTypeDAO dao = new BookTypeDAO();

        if (dao.deleteBookType(id)) {
            resp.sendRedirect(req.getContextPath() + "/admin/bookTypeList.jsp?msg=deleted");
        } else {
            resp.sendRedirect(req.getContextPath() + "/admin/bookTypeList.jsp?msg=error");
        }
    }
}
