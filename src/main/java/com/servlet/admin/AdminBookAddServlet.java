package com.servlet.admin;

import com.dao.admin.BookDAO;
import com.database.DBConnect;
import com.detail.BookDetail;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@WebServlet(name = "AdminBookAddServlet", urlPatterns = {"/AdminBookAddServlet"})
@MultipartConfig
public class AdminBookAddServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            if (session.getAttribute("admin") == null) {
                response.sendRedirect("admin_login.jsp"); // Or wherever your login page is
                return;
            }

            String bookName = request.getParameter("bookName").trim();
            String authorName = request.getParameter("authorName").trim();
            int price = Integer.parseInt(request.getParameter("price").trim());
            int totalBook = Integer.parseInt(request.getParameter("totalBook").trim());
            String category = request.getParameter("category").trim();

            Part part = request.getPart("photo");
            String fileName = part.getSubmittedFileName();

            BookDetail bd = new BookDetail();
            bd.setBookName(bookName);
            bd.setAuthorName(authorName);
            bd.setPrice(price);
            bd.setAvailable(totalBook);
            bd.setBookCategory(category);
            bd.setPhoto(fileName);

            // Extract file extension (for unique naming)
            StringBuilder sb = new StringBuilder();
            for (int i = fileName.length() - 1; i >= 0; i--) {
                if (fileName.charAt(i) == '.') {
                    break;
                }
                sb.insert(0, fileName.charAt(i));
            }

            BookDAO dao = new BookDAO(DBConnect.getConnection());
            String f = dao.addBook(bd, sb);

            response.setContentType("text/html;charset=UTF-8");
            try (PrintWriter out = response.getWriter()) {
                if (!f.equals("no")) {
                    InputStream is = part.getInputStream();
                    byte[] data = new byte[is.available()];
                    is.read(data);

//                    String path = getServletContext().getRealPath("/") + "img" + File.separator + "books-img";
                    String path = "C:\\bookapp\\uploads\\books-img";  // Or any permanent location

                    File dir = new File(path);
                    if (!dir.exists()) {
                        dir.mkdirs(); // create directory if not exist
                    }

                    String fullPath = path + File.separator + f;
                    try (FileOutputStream fos = new FileOutputStream(fullPath)) {
                        fos.write(data);
                    }

                    out.println("done"); // you can redirect if needed
                } else {
                    out.println("no");
                }
            }
        } catch (IOException | NumberFormatException | ServletException e) {
            e.printStackTrace();
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
        return "Handles admin book adding with image upload";
    }
}
