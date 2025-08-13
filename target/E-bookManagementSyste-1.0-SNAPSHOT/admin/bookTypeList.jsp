<%@page import="java.util.List"%>
<%@page import="com.dao.admin.BookTypeDAO"%>
<%@page import="com.detail.BookTypeDetail"%>
<%
    if (session.getAttribute("admin") == null) {
        response.sendRedirect("./adminLogin.jsp");
    } else {
        BookTypeDAO dao = new BookTypeDAO();
        List<BookTypeDetail> list = dao.getAllBookTypes();
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="adminHead.jsp" %>
        <title>Book Types | Admin Panel</title>
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
        </style>
    </head>
    <body>

        <%@include file="adminNavbar.jsp" %>

        <div class="container mt-5 mb-5">
            <div class="row justify-content-center">
                <div class="col-12 text-center mb-3">
                    <h3 class="text-white fw-bold"><i class="bi bi-tags-fill me-2"></i>Book Types</h3>
                </div>
                <div class="col-lg-10">
                    <div class="table-card">
                        <div class="mb-3 text-end">
                            <a href="addBookType.jsp" class="btn btn-sm btn-success">
                                <i class="bi bi-plus-circle"></i> Add New Type
                            </a>
                        </div>
                        <div class="table-responsive">
                            <table class="table table-bordered table-hover align-middle">
                                <thead class="thead-dark-custom">
                                    <tr>
                                        <th>ID</th>
                                        <th>Type Name</th>
                                        <th>Description</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% for (BookTypeDetail type : list) { %>
                                    <tr>
                                        <td><%= type.getId() %></td>
                                        <td><%= type.getTypeName() %></td>
                                        <td><%= type.getDescription() %></td>
                                        <td>
                                            <div class="d-flex">
                                                <a href="editBookType?id=<%= type.getId() %>" class="btn btn-sm btn-outline-primary me-2">
                                                    <i class="bi bi-pencil-square"></i>Edit
                                                </a>
                                                <button class="btn btn-sm btn-outline-danger" onclick="confirmDelete(<%= type.getId() %>)">
                                                    <i class="bi bi-trash-fill"></i>Delete
                                                </button>
                                            </div>
                                        </td>
                                    </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script>
            function confirmDelete(id) {
                Swal.fire({
                    title: 'Are you sure?',
                    text: "You won't be able to revert this!",
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#d33',
                    cancelButtonColor: '#3085d6',
                    confirmButtonText: 'Yes, delete it!',
                    cancelButtonText: 'Cancel'
                }).then((result) => {
                    if (result.isConfirmed) {
                        window.location.href = 'deleteBookType?id=' + id;
                    }
                });
            }
        </script>
    </body>
</html>
<%
    }
%>
