<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    if (session.getAttribute("admin") == null) {
        response.sendRedirect("./adminLogin.jsp");
    } else {

        // JDBC Connection settings (fixed for MySQL 8+)
        String jdbcURL = "jdbc:mysql://localhost:3306/bookmanagementsystem?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
        String jdbcUsername = "root";
        String jdbcPassword = "Asdfg@12#"; // Your actual MySQL password

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
            ps = conn.prepareStatement("SELECT id, typeName FROM book_type");
            rs = ps.executeQuery();
%>


<!DOCTYPE html>
<html>
    <head>
        <%@include file="adminHead.jsp" %>
        <title>Add Book | Book Store Admin</title>

        <!-- Bootstrap & Icons -->
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
                from {
                    opacity: 0;
                    transform: translateY(20px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }
            h3 {
                font-weight: 600;
                font-size: 24px;
                color: #0d6efd;
            }
            .btn {
                font-size: 15px;
                padding: 8px 24px;
            }
        </style>
    </head>

    <body>
        <%@include file="adminNavbar.jsp" %>

        <div class="container mt-5 mb-5">
            <div class="row justify-content-center">
                <div class="col-xl-6 col-lg-8 col-md-10">
                    <div class="text-center mb-3">
                        <h3 class="text-white fw-bold"><i class="bi bi-bookmark-plus-fill me-2"></i>Add New Book</h3>
                        <small id="status" class="text-muted"></small>
                    </div>
                    <div class="card-form">
                        <form id="addBook" enctype="multipart/form-data" method="post" action="AdminAddBookServlet">

                            <!-- Book Name -->
                            <div class="row mb-3 align-items-center">
                                <div class="col-4">
                                    <label for="bookName" class="col-form-label">Book Name <span class="text-danger">*</span></label>
                                </div>
                                <div class="col-8">
                                    <input type="text" class="form-control" id="bookName" name="bookName" required>
                                </div>
                            </div>

                            <!-- Author Name -->
                            <div class="row mb-3 align-items-center">
                                <div class="col-4">
                                    <label for="authorName" class="col-form-label">Author Name <span class="text-danger">*</span></label>
                                </div>
                                <div class="col-8">
                                    <input type="text" class="form-control" id="authorName" name="authorName" required>
                                </div>
                            </div>

                            <!-- Price -->
                            <div class="row mb-3 align-items-center">
                                <div class="col-4">
                                    <label for="price" class="col-form-label">Price (Rs) <span class="text-danger">*</span></label>
                                </div>
                                <div class="col-8">
                                    <input type="number" class="form-control" id="price" name="price" required>
                                </div>
                            </div>

                            <!-- Total Books -->
                            <div class="row mb-3 align-items-center">
                                <div class="col-4">
                                    <label for="totalBook" class="col-form-label">Total Books <span class="text-danger">*</span></label>
                                </div>
                                <div class="col-8">
                                    <input type="number" class="form-control" id="totalBook" name="totalBook" required>
                                </div>
                            </div>

                            <!-- Book Category (Dynamic) -->
                            <div class="row mb-3 align-items-center">
                                <div class="col-4">
                                    <label for="category" class="col-form-label">Book Category <span class="text-danger">*</span></label>
                                </div>
                                <div class="col-8">
                                    <select name="category" id="category" class="form-select" required>
                                        <option value="" disabled selected>Select Category</option>
                                        <% while (rs.next()) {%>
                                        <option value="<%= rs.getInt("id")%>">
                                            <%= rs.getString("typeName")%>
                                        </option>
                                        <% } %>
                                    </select>
                                </div>
                            </div>

                            <!-- Photo -->
                            <div class="row mb-3 align-items-center">
                                <div class="col-4">
                                    <label for="photo" class="col-form-label">Upload Cover <span class="text-danger">*</span></label>
                                </div>
                                <div class="col-8">
                                    <input type="file" accept="image/*" class="form-control" id="photo" name="photo" required>
                                </div>
                            </div>

                            <!-- Submit -->
                            <div class="text-center">
                                <button type="submit" class="btn btn-primary px-4">
                                    <i class="bi bi-upload me-1"></i> Add Book
                                </button>
                            </div>

                        </form>
                    </div>
                </div>
            </div>
        </div>

        <script src="./js/adminAddBook.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>

<%
        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
        } finally {
            if (rs != null) try {
                rs.close();
            } catch (Exception e) {
            }
            if (ps != null) try {
                ps.close();
            } catch (Exception e) {
            }
            if (conn != null) try {
                conn.close();
            } catch (Exception e) {
            }
        }
    }
%>
