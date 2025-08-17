<%-- 
    Document   : orderList
    Created on : 12-Jun-2021, 5:53:42 PM
    Author     : chetan
--%>

<%@page import="com.detail.OrderListDetail"%>
<%@page import="java.util.List"%>
<%@page import="com.dao.OrderDAO"%>
<%
    if(session.getAttribute("userL")==null){
        response.sendRedirect("./index.jsp");
    } else {
        UserDetail udCart = (UserDetail) session.getAttribute("userL");
        OrderDAO orderDAO = new OrderDAO(DBConnect.getConnection());
        List<OrderListDetail> list = orderDAO.getOrderList(udCart.getId());
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="./component/header.jsp" %>
        <title>My Orders | Book Store</title>
        <style>
            body {
                background: #f8f9fa;
                font-family: 'Open Sans', sans-serif;
            }
            .orders-container {
                margin-top: 40px;
                margin-bottom: 60px;
            }
            .card-custom {
                border-radius: 16px;
                border: none;
                box-shadow: 0 6px 18px rgba(0,0,0,0.08);
            }
            table {
                border-radius: 12px;
                overflow: hidden;
            }
            thead {
                background: #0077b6;
                color: #fff;
            }
            thead th {
                font-weight: 600;
                text-transform: uppercase;
                font-size: 14px;
            }
            tbody tr:hover {
                background-color: #f1f9ff;
                transition: 0.2s;
            }
            .badge-status {
                padding: 6px 12px;
                border-radius: 20px;
                font-size: 13px;
                font-weight: 600;
            }
            .badge-pending { background: #ffc107; color: #000; }
            .badge-completed { background: #28a745; color: #fff; }
            .badge-cancelled { background: #dc3545; color: #fff; }
            .empty-state {
                padding: 50px 20px;
            }
            .empty-state h1 {
                font-size: 60px;
                color: #ffc107;
            }
        </style>
    </head>
    <body>
        <%@include file="./component/navbar.jsp" %>
        
        <div class="container orders-container">
            <div class="row mb-4">
                <div class="col-12 text-center">
                    <h2 class="fw-bold text-primary">
                        <i class="fas fa-shopping-bag"></i> My Orders
                    </h2>
                    <p class="text-muted">Track your purchases and order history</p>
                </div>
            </div>

            <%
                if(!list.isEmpty()) {
            %>
                <div class="card card-custom p-3">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle">
                            <thead>
                                <tr>
                                    <th>No.</th>
                                    <th>Order No</th>
                                    <th>Price</th>
                                    <th>Time</th>
                                    <th>Payment Method</th>
                                    <th>Status</th>
                                    <th>View</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    int srNo = 0;
                                    for(OrderListDetail cd : list) {
                                        srNo += 1;
                                        String status = cd.getStatus();
                                        String badgeClass = "badge-status";
                                        if("Pending".equalsIgnoreCase(status)) {
                                            badgeClass += " badge-pending";
                                        } else if("Completed".equalsIgnoreCase(status) || "Delivered".equalsIgnoreCase(status)) {
                                            badgeClass += " badge-completed";
                                        } else {
                                            badgeClass += " badge-cancelled";
                                        }
                                %>
                                    <tr>
                                        <td><%= srNo %></td>
                                        <td><%= cd.getOrderID() %></td>
                                        <td>₹ <%= cd.getPrice() %>/-</td>
                                        <td><%= cd.getDate() %></td>
                                        <td><%= cd.getPaymentMethod() %></td>
                                        <td><span class="<%= badgeClass %>"><%= status %></span></td>
                                        <td>
                                            <a class="btn btn-sm btn-outline-primary" target="_blank" href="./orderView.jsp?orderId=<%= cd.getOrderID() %>">
                                                <i class="fas fa-eye"></i> View
                                            </a>
                                        </td>
                                    </tr>
                                <%
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>
            <%
                } else {
            %>
                <div class="row">
                    <div class="col-12 text-center empty-state">
                        <h1><i class="far fa-frown"></i></h1>
                        <h3 class="fw-bold">Your Order List is Empty</h3>
                        <p class="text-muted">Browse our collection and start shopping today!</p>
                        <a href="./index.jsp" class="btn btn-primary mt-3">
                            <i class="fas fa-book-open"></i> Shop Now
                        </a>
                    </div>
                </div>
            <%
                }
            %>
        </div>
        
        <script>
            $("#searchBook").attr("action","./newBook.jsp");
            $("#searchBook2").attr("action","./newBook.jsp");
        </script>
    </body>
</html>
<%
    }
%>
