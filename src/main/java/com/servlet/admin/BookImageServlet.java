package com.servlet.common;

import java.io.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/BookImage")
public class BookImageServlet extends HttpServlet {

    private final String path = "C:\\bookapp\\uploads\\books-img";
 // SAME as used in AdminBookAddServlet

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fileName = request.getParameter("img");
        if (fileName == null || fileName.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing image name.");
            return;
        }

        File imageFile = new File(path, fileName);
        if (!imageFile.exists()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Image not found.");
            return;
        }

        response.setContentType(getServletContext().getMimeType(fileName));
        try (FileInputStream fis = new FileInputStream(imageFile);
             OutputStream os = response.getOutputStream()) {

            byte[] buffer = new byte[4096];
            int length;
            while ((length = fis.read(buffer)) > 0) {
                os.write(buffer, 0, length);
            }
        }
    }
}
