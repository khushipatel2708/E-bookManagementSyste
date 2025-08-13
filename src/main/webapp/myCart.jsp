<%-- 
    Document   : myCart
    Created on : 11-Jun-2021, 5:08:45 PM
    Author     : chetan
--%>

<%@page import="com.dao.OrderDAO"%>
<%@page import="com.detail.CartDetail"%>
<%@page import="java.util.List"%>
<%
    if(session.getAttribute("userL")==null){
        response.sendRedirect("./index.jsp");
    } else {
        UserDetail udCart = (UserDetail) session.getAttribute("userL");
        CartDAO cartDAO2 = new CartDAO(DBConnect.getConnection());
        List<CartDetail> list = cartDAO2.getCart(udCart.getId());
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@include file="./component/header.jsp" %>
    <title>My Cart | Book Store</title>

    <!-- Bootstrap & Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

    <style>
        body {
            background-color: #f4f6f9;
            font-family: 'Segoe UI', sans-serif;
        }
        .cart-container {
            background: #fff;
            border-radius: 15px;
            box-shadow: 0 4px 25px rgba(0,0,0,0.05);
            padding: 20px;
        }
        .table th {
            background-color: #0d6efd;
            color: white;
        }
        .table tbody tr:hover {
            background-color: #f9fbff;
        }
        .total-section {
            background: #f8f9fa;
            padding: 15px;
            border-radius: 10px;
        }
        .total-section label {
            font-size: 1.1rem;
            font-weight: 600;
        }
        .empty-cart {
            background: #fff;
            border-radius: 15px;
            padding: 40px;
            box-shadow: 0 4px 25px rgba(0,0,0,0.05);
        }
        .empty-cart img {
            width: 180px;
            opacity: 0.8;
        }
        .btn-custom {
            border-radius: 30px;
            padding: 8px 18px;
            font-weight: 600;
        }
        .btn-danger {
            background-color: #dc3545;
            border: none;
        }
    </style>
</head>
<body>
    <%@include file="./component/navbar.jsp" %>

    <div class="container my-5">
        <div class="row mb-4">
            <div class="col text-center">
                <h2 class="fw-bold text-primary"><i class="fas fa-shopping-cart"></i> My Cart</h2>
                <small class="text-muted">You can buy only one quantity of a book at a time.</small>
            </div>
        </div>

        <%
            if(!list.isEmpty()) {
        %>
        <div class="cart-container">
            <div class="table-responsive">
                <table class="table align-middle text-center">
                    <thead>
                        <tr>
                            <th>No.</th>
                            <th class="text-start">Book Name</th>
                            <th>Price (₹)</th>
                            <th>Quantity</th>
                            <th>Total Price (₹)</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                    <%
                        int srNo = 0;
                        int totalBookPrice = 0;
                        boolean checkBookAvailableOrNot = false;
                        boolean checkBookAvailable = false;
                        OrderDAO orderDAO = new OrderDAO(DBConnect.getConnection());
                        for(CartDetail cd : list) {
                            int totalPrice = 0;
                            if(orderDAO.checkBookAvailable(cd.getBookId())){
                                checkBookAvailableOrNot = false;
                                totalPrice = cd.getPrice()*cd.getQuantity();
                                totalBookPrice += totalPrice;
                            } else {
                                checkBookAvailableOrNot = true;
                                checkBookAvailable = true;
                            }
                            srNo += 1;
                    %>
                        <tr>
                            <td><%= srNo %></td>
                            <td class="text-start">
                                <img src="<%= request.getContextPath() %>/BookImage?img=<%= cd.getPhoto() %>"
                                     class="img-fluid rounded me-2" width="60" alt="Book">
                                <a href="./viewBook.jsp?bookId=<%= cd.getBookId() %>" 
                                   class="fw-semibold text-decoration-none text-dark" target="_blank">
                                   <%= cd.getBookName() %>
                                </a>
                            </td>
                            <td><%= cd.getPrice() %></td>
                            <td>
                                <% 
                                    if(!checkBookAvailableOrNot){
                                        out.println(cd.getQuantity());
                                    } else {
                                        out.println("0");
                                    }
                                %>
                            </td>
                            <td><%= totalPrice %></td>
                            <td>
                                <button class="btn btn-danger btn-sm btn-custom" onclick="deleteCartBook(<%= cd.getBookId() %>)">
                                    <i class="fas fa-trash-alt"></i> Remove
                                </button>
                            </td>
                        </tr>
                    <%
                        }
                    %>
                    </tbody>
                </table>
            </div>

            <% if(checkBookAvailable) { %>
            <div class="text-center text-danger fw-semibold my-2">
                <i class="fas fa-exclamation-triangle"></i> Some books are not available
            </div>
            <% } %>

            <!-- Totals -->
            <div class="total-section mt-4">
                <div class="row">
                    <div class="col-md-6">
                        <label>Total Book Price:</label> ₹<%= totalBookPrice %>
                    </div>
                    <div class="col-md-6">
                        <label>Delivery Charge:</label> ₹<%= (totalBookPrice>=699)?0:70 %>
                    </div>
                </div>
            </div>

            <!-- Proceed Button -->
            <div class="text-center mt-4">
                <% if(totalBookPrice!=0) { %>
                    <button class="btn btn-success btn-lg btn-custom" onclick="location.href='./confirmOrder.jsp'">
                        <i class="fas fa-check-circle"></i> Proceed to Confirm
                    </button>
                <% } else { %>
                    <button class="btn btn-success btn-lg btn-custom" disabled>
                        <i class="fas fa-check-circle"></i> Proceed to Confirm
                    </button>
                <% } %>
            </div>
        </div>

        <%
            } else {
        %>
        <!-- Empty Cart -->
        <div class="empty-cart text-center">
            <img src="https://cdn-icons-png.flaticon.com/512/2038/2038854.png" alt="Empty Cart">
            <h3 class="mt-3 text-warning fw-bold"><i class="far fa-frown"></i> Your cart is empty</h3>
            <p class="text-muted">Looks like you haven't added anything yet.</p>
            <a href="./index.jsp" class="btn btn-primary btn-custom mt-3">
                <i class="fas fa-arrow-left"></i> Continue Shopping
            </a>
        </div>
        <% } %>
    </div>

    <script>
        $("#searchBook").attr("action","./newBook.jsp");
        $("#searchBook2").attr("action","./newBook.jsp");
    </script>
    <script src="js/myCart.js" type="text/javascript"></script>
</body>
</html>
<%
    }
%>
