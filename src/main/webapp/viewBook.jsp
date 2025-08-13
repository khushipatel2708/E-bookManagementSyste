<%-- 
    Document   : viewBook
    Created on : 09-Jun-2021, 5:20:41 PM
    Author     : chetan
--%>
<%@page import="com.detail.BookDetail"%>
<%@page import="com.database.DBConnect"%>
<%@page import="com.dao.admin.BookDAO"%>
<%
    int bookId = 0;
    try {
        bookId = Integer.parseInt(request.getParameter("bookId"));
        BookDAO dao1 = new BookDAO(DBConnect.getConnection());
        BookDetail bd = dao1.editBookDetail(bookId);
        if (bd == null) {
            response.sendRedirect("./index.jsp");
        }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <%@include file="./component/header.jsp" %>
    <title><%= bd.getBookName() %> - Book Store</title>

    <!-- Bootstrap & FontAwesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

    <style>
        body {
            background-color: #f4f6f9;
            font-family: 'Segoe UI', sans-serif;
        }
        .product-card {
            background: #fff;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 8px 30px rgba(0,0,0,0.05);
        }
        .product-img {
            width: 80%;
            max-width: 300px;
            border-radius: 10px;
            background: #f9fafc;
            padding: 15px;
            transition: transform 0.3s ease;
        }
        .product-img:hover {
            transform: scale(1.05);
        }
        .product-title {
            font-weight: 700;
            font-size: 1.7rem;
            color: #0d6efd;
        }
        .product-meta label {
            display: block;
            margin-bottom: 8px;
            font-size: 1rem;
        }
        .product-meta span {
            font-weight: 600;
            color: #333;
        }
        .product-buttons .btn {
            min-width: 150px;
            border-radius: 30px;
            font-weight: 600;
            padding: 10px 20px;
            transition: all 0.3s ease;
        }
        .product-buttons .btn-outline-primary:hover {
            background: #0d6efd;
            color: #fff;
        }
        .product-buttons .btn-outline-success:hover {
            background: #198754;
            color: #fff;
        }
        .features {
            background: #f8faff;
            border-radius: 10px;
            padding: 15px;
            margin-top: 20px;
            display: flex;
            justify-content: space-around;
            text-align: center;
        }
        .features i {
            font-size: 1.5rem;
            color: #0d6efd;
            margin-bottom: 8px;
        }
    </style>
</head>
<body>
    <%@include file="./component/navbar.jsp" %>

    <div class="container my-5">
        <div class="row justify-content-center">
            <div class="col-lg-10 product-card">
                <div class="row g-4">
                    <!-- Book Image -->
                    <div class="col-md-6 text-center align-self-center">
                        <img class="img-fluid product-img"
                             src="<%= request.getContextPath() %>/BookImage?img=<%= bd.getPhoto() %>"
                             alt="Book Image">
                    </div>

                    <!-- Book Details -->
                    <div class="col-md-6 align-self-center">
                        <h1 class="product-title"><%= bd.getBookName() %></h1>

                        <div class="product-meta mt-3">
                            <label><strong>Author/Publisher:</strong> <span><%= bd.getAuthorName() %></span></label>
                            <label><strong>MRP:</strong> <span>₹<%= bd.getPrice() %></span></label>
                            <label><strong>Stock:</strong> <span><%= bd.getAvailable() %> Books</span></label>
                            <label><strong>Category:</strong> <span><%= bd.getBookCategory() %></span></label>
                            <label><strong>Delivery Charge:</strong> <span>Free over ₹699</span></label>
                        </div>

                        <!-- Action Buttons -->
                        <div class="product-buttons mt-4">
                            <button class="btn btn-outline-primary me-3" onclick="addCart(<%= bd.getId() %>)">
                                <i class="fas fa-cart-plus"></i> Add to Cart
                            </button>
                            <button class="btn btn-outline-success" onclick="addCart2(<%= bd.getId() %>)">
                                <i class="fa fa-shopping-bag"></i> Buy Now
                            </button>
                        </div>

                        <!-- Features -->
                        <div class="features mt-4">
                            <div>
                                <i class="fas fa-wallet"></i>
                                <p>Pay on Delivery</p>
                            </div>
                            <div>
                                <i class="fas fa-undo-alt"></i>
                                <p>10 Days Replacement</p>
                            </div>
                            <div>
                                <i class="fas fa-truck"></i>
                                <p>Fast Delivery</p>
                            </div>
                            <div>
                                <i class="fas fa-mobile-alt"></i>
                                <p>No-Contact Delivery</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        $("#searchBook").attr("action","./newBook.jsp");
        $("#searchBook2").attr("action","./newBook.jsp");
    </script>
    <script src="js/addCart.js" type="text/javascript"></script>
</body>
</html>
<%
    } catch (Exception e) {}
    if (bookId == 0) {
        response.sendRedirect("./index.jsp");
    }
%>
