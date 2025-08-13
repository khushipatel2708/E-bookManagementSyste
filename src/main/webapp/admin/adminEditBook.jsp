<%@page import="java.sql.*" %>
<%@page import="com.detail.BookDetail"%>
<%@page import="com.dao.admin.BookDAO"%>
<%@page import="com.database.DBConnect"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("admin") == null) {
        response.sendRedirect("./adminLogin.jsp");
    } else {
        int bookId = 0;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            bookId = Integer.parseInt(request.getParameter("bookId"));
            BookDAO dao = new BookDAO(DBConnect.getConnection());
            BookDetail bd = dao.editBookDetail(bookId);

            if (bd == null) {
                response.sendRedirect("./adminPanel.jsp");
                return;
            }

            // Fetch categories for dropdown
            String jdbcURL = "jdbc:mysql://localhost:3306/bookmanagementsystem?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
            String jdbcUsername = "root";
            String jdbcPassword = "Asdfg@12#";

            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
            ps = conn.prepareStatement("SELECT id, typeName FROM book_type ORDER BY typeName");
            rs = ps.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
    <%@include file="adminHead.jsp" %>
    <title>Edit Book | Book Store Admin</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        body {
            background: linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.6)),
                url('https://wallpapercave.com/wp/wp9167352.jpg') no-repeat center center fixed;
            background-size: cover;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .card-form {
            background-color: rgba(255, 255, 255, 0.95);
            border-radius: 12px;
            box-shadow: 0 6px 16px rgba(0, 0, 0, 0.25);
            padding: 20px;
            margin-top: 30px;
            animation: fadeIn 0.8s ease-in-out;
            max-width: 500px;
            margin-left: auto;
            margin-right: auto;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        h3 { font-weight: 600; font-size: 24px; color: #0d6efd; }
        .btn { font-size: 15px; padding: 8px 24px; }
    </style>
</head>

<body>
<%@include file="adminNavbar.jsp" %>

<div class="container mt-5 mb-5">
    <div class="row justify-content-center">
        <div class="col-xl-6 col-lg-8 col-md-10">
            <div class="text-center mb-3">
                <h3 class="text-white fw-bold"><i class="bi bi-pencil-square me-2"></i>Edit Book</h3>
                <small id="status" style="display:none;"></small>
            </div>
            <div class="card-form">
                <form id="editBook" method="post" action="AdminEditBookServlet">
                    <input type="hidden" name="bookId" value="<%= bd.getId() %>"/>

                    <!-- Book Name -->
                    <div class="row mb-3 align-items-center">
                        <div class="col-4">
                            <label for="bookName" class="col-form-label">Book Name <span class="text-danger">*</span></label>
                        </div>
                        <div class="col-8">
                            <input type="text" class="form-control" id="bookName" name="bookName"
                                   value="<%= bd.getBookName() %>" required>
                        </div>
                    </div>

                    <!-- Author Name -->
                    <div class="row mb-3 align-items-center">
                        <div class="col-4">
                            <label for="authorName" class="col-form-label">Author Name <span class="text-danger">*</span></label>
                        </div>
                        <div class="col-8">
                            <input type="text" class="form-control" id="authorName" name="authorName"
                                   value="<%= bd.getAuthorName() %>" required>
                        </div>
                    </div>

                    <!-- Price -->
                    <div class="row mb-3 align-items-center">
                        <div class="col-4">
                            <label for="price" class="col-form-label">Price (Rs) <span class="text-danger">*</span></label>
                        </div>
                        <div class="col-8">
                            <input type="number" class="form-control" id="price" name="price"
                                   value="<%= bd.getPrice() %>" required>
                        </div>
                    </div>

                    <!-- Total Books -->
                    <div class="row mb-3 align-items-center">
                        <div class="col-4">
                            <label for="totalBook" class="col-form-label">Total Books <span class="text-danger">*</span></label>
                        </div>
                        <div class="col-8">
                            <input type="number" class="form-control" id="totalBook" name="totalBook"
                                   value="<%= bd.getAvailable() %>" required>
                        </div>
                    </div>

                    <!-- Dynamic Category -->
                    <div class="row mb-3 align-items-center">
                        <div class="col-4">
                            <label for="category" class="col-form-label">Book Category <span class="text-danger">*</span></label>
                        </div>
                        <div class="col-8">
                            <select name="category" id="category" class="form-select" required>
                                <option value="" disabled>Select Category</option>
                                <%
                                    while (rs.next()) {
                                        int catId = rs.getInt("id");
                                        String catName = rs.getString("typeName");
                                        boolean selected = String.valueOf(catId).equals(bd.getBookCategory());
                                %>
                                <option value="<%= catId %>" <%= selected ? "selected" : "" %>><%= catName %></option>
                                <% } %>
                            </select>
                        </div>
                    </div>

                    <div class="text-center">
                        <button type="submit" class="btn btn-primary px-4">
                            <i class="bi bi-check-circle me-1"></i> Update Book
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="./js/adminEditBook.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
<%
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("./adminPanel.jsp");
        } finally {
            if (rs != null) try { rs.close(); } catch (Exception ignore) {}
            if (ps != null) try { ps.close(); } catch (Exception ignore) {}
            if (conn != null) try { conn.close(); } catch (Exception ignore) {}
        }
    }
%>
