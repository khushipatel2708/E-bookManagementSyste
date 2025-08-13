package com.servlet.admin;

import com.dao.admin.BookDAO;
import com.database.DBConnect;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;

@WebServlet(name = "AdminDeleteBookServlet", urlPatterns = {"/AdminDeleteBookServlet"})
public class AdminDeleteBookServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("admin") != null) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));

                // Optionally get photo name to delete image (if you want)
                String photo = request.getParameter("photo"); // passed via query param from JSP?

                BookDAO dao = new BookDAO(DBConnect.getConnection());
                dao.deleteBook(id);

                // Optionally delete the image file from server
                if (photo != null && !photo.trim().equals("")) {
                    String path = getServletContext().getRealPath("/") + "img" + File.separator + "books-img" + File.separator + photo;
                    File file = new File(path);
                    if (file.exists()) {
                        file.delete(); // remove image
                    }
                }

                response.sendRedirect("./admin/adminAllBook.jsp");

            } catch (NumberFormatException e) {
                e.printStackTrace();
                response.sendRedirect("./admin/adminAllBook.jsp?error=invalid_id");
            }
        } else {
            response.sendRedirect("admin_login.jsp"); // or your login page
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
        return "Handles deletion of a book and optional image removal";
    }
}
