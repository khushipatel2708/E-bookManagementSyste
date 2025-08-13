<%@page import="com.detail.BookDetail"%>
<%@page import="java.util.List"%>
<%@page import="com.database.DBConnect"%>
<%@page import="com.dao.admin.BookDAO"%>
<%
    if (session.getAttribute("admin") == null) {
        response.sendRedirect("./adminLogin.jsp");
    } else {
        int pageNo = 1;
        try {
            pageNo = Integer.parseInt(request.getParameter("pageNo"));
        } catch (Exception e) {
            e.printStackTrace();
        }
        BookDAO dao = new BookDAO(DBConnect.getConnection());
        List<BookDetail> list = dao.showBook(pageNo);
        int totalPage = dao.bookCount();
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="adminHead.jsp" %>
        <title>All Books | Admin Panel</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

        <style>
            body {
                background: linear-gradient(rgba(0,0,0,0.6), rgba(0,0,0,0.6)),
                    url('https://images.unsplash.com/photo-1524995997946-a1c2e315a42f?auto=format&fit=crop&w=1350&q=80') no-repeat center center fixed;
                background-size: cover;
                font-family: 'Segoe UI', sans-serif;
            }

            .table-card {
                background: rgba(255, 255, 255, 0.9);
                backdrop-filter: blur(6px);
                border-radius: 15px;
                padding: 25px;
                box-shadow: 0 10px 30px rgba(0,0,0,0.25);
                animation: fadeIn 0.6s ease-in;
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

            .thead-dark-custom {
                background-color: #343a40;
                color: #fff;
            }

            .btn-sm i {
                margin-right: 5px;
            }

            .btn:hover {
                opacity: 0.9;
            }

            .table thead th {
                vertical-align: middle;
            }
        </style>
    </head>
    <body>

        <%@include file="adminNavbar.jsp" %>

        <div class="container mt-5 mb-5">
            <div class="row justify-content-center">
                <div class="col-12 text-center mb-3">
                    <h3 class="text-white fw-bold" ><i class="bi bi-journals me-2"></i>All Books</h3>
                </div>
                <div class="col-lg-11">
                    <div class="table-card">
                        <div class="table-responsive">
                            <table class="table table-bordered table-hover align-middle">
                                <thead class="thead-dark-custom">
                                    <tr>
                                        <th>ID</th>
                                        <th>Book Name</th>
                                        <th>Author</th>
                                        <th>Price (Rs)</th>
                                        <th>Category</th>
                                        <th>Available</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        for (BookDetail bd : list) {
                                    %>
                                    <tr>
                                        <td><%= bd.getId()%></td>
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <img src="<%= request.getContextPath() %>/BookImage?img=<%= bd.getPhoto() %>" width="50" height="60" class="me-2 rounded shadow-sm" />
                                                <span><%= bd.getBookName()%></span>
                                            </div>
                                        </td>
                                        <td><%= bd.getAuthorName()%></td>
                                        <td><%= bd.getPrice()%>/-</td>
                                        <td><%= bd.getBookCategory()%></td>
                                        <td><%= bd.getAvailable()%></td>
                                        <td>
                                            <div class="d-flex">
                                                <a href="./adminEditBook.jsp?bookId=<%= bd.getId()%>" class="btn btn-sm btn-outline-primary me-2">
                                                    <i class="bi bi-pencil-square"></i>Edit
                                                </a>
                                                <button class="btn btn-sm btn-outline-danger" onclick="confirmDelete(<%= bd.getId()%>)"><i class="bi bi-trash-fill"></i>Delete</button>
    <!--                                        <a href="../AdminDeleteBookServlet?id=<%= bd.getId()%>" class="btn btn-sm btn-outline-danger" onclick="return confirm('Are you sure to delete this book?');">
                                                <i class="bi bi-trash-fill"></i>Delete
                                            </a>-->
                                            </div>
                                        </td>
                                    </tr>
                                    <%
                                        }
                                    %>
                                </tbody>
                            </table>
                        </div>

                        <!-- Pagination -->
                        <div class="d-flex justify-content-center mt-3">
                            <nav>
                                <ul class="pagination pagination-sm">
                                    <%
                                        int pageN = 0;
                                        while (totalPage > 0) {
                                            pageN++;
                                            if (pageN == pageNo) {
                                    %>
                                    <li class="page-item active">
                                        <span class="page-link"><%= pageN%></span>
                                    </li>
                                    <%
                                    } else {
                                    %>
                                    <li class="page-item">
                                        <a class="page-link" href="./adminAllBook.jsp?pageNo=<%= pageN%>"><%= pageN%></a>
                                    </li>
                                    <%
                                            }
                                            totalPage -= 10;
                                        }
                                    %>
                                </ul>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </body>
</html>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
                                                function confirmDelete(bookId) {
                                                    Swal.fire({
                                                        title: 'Are you sure?',
                                                        text: "You won't be able to revert this action!",
                                                        icon: 'warning',
                                                        showCancelButton: true,
                                                        confirmButtonColor: '#d33',
                                                        cancelButtonColor: '#3085d6',
                                                        confirmButtonText: 'Yes, delete it!',
                                                        cancelButtonText: 'Cancel'
                                                    }).then((result) => {
                                                        if (result.isConfirmed) {
                                                            // Redirect to delete servlet
                                                            window.location.href = '../AdminDeleteBookServlet?id=' + bookId;
                                                        }
                                                    });
                                                    }
</script>

<%
    }
%>
