<%-- 
    Document   : orderView
    Created on : 12-Jun-2021, 9:30:53 PM
    Author     : chetan
--%>

<%@page import="com.detail.OrderCartList"%>
<%@page import="com.detail.OrderListDetail"%>
<%@page import="com.dao.OrderDAO"%>
<%
    if(session.getAttribute("userL")==null){
        response.sendRedirect("./index.jsp");
    } else {
        UserDetail ud3 = (UserDetail) session.getAttribute("userL");
        int orderId = 0;
        try {
            orderId = Integer.parseInt(request.getParameter("orderId"));
        } catch(Exception e) {
            orderId = 0;
        }
        OrderDAO orderDAO = new OrderDAO(DBConnect.getConnection());
        OrderListDetail old = orderDAO.getOrderView(ud3.getId(), orderId);
        if(old==null){
            response.sendRedirect("./index.jsp");
        }
        try {
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <%@include file="./component/header.jsp" %>
    <title>Order Details | Book Store</title>
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Open Sans', sans-serif;
        }
        .order-container {
            margin-top: 40px;
            margin-bottom: 60px;
        }
        .card-custom {
            border-radius: 16px;
            border: none;
            box-shadow: 0 6px 18px rgba(0,0,0,0.08);
            padding: 20px;
        }
        .order-header {
            border-bottom: 2px solid #e9ecef;
            padding-bottom: 15px;
            margin-bottom: 20px;
        }
        .order-header h3 {
            color: #0077b6;
            font-weight: bold;
        }
        .order-info label {
            font-weight: 600;
            color: #495057;
        }
        .order-info p {
            margin-bottom: 10px;
            color: #212529;
        }
        .table thead {
            background: #0077b6;
            color: #fff;
        }
        .table-hover tbody tr:hover {
            background: #f1f9ff;
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
    </style>
</head>
<body>
    <%@include file="./component/navbar.jsp" %>

    <div class="container order-container">
        <div class="row justify-content-center">
            <div class="col-lg-10">
                <div class="card card-custom">
                    <div class="order-header text-center">
                        <h3><i class="fas fa-receipt"></i> Order Details</h3>
                        <p class="text-muted mb-0">Review your order information and purchased items</p>
                    </div>

                    <div class="row order-info">
                        <div class="col-md-6">
                            <p><label>Order No:</label> <%= old.getOrderID() %></p>
                            <p><label>Total Price:</label> ₹ <%= old.getPrice() %>/-</p>
                            <p><label>Order Date:</label> <%= old.getDate() %></p>
                            <p><label>Payment Method:</label> <%= old.getPaymentMethod() %></p>
                            <p>
                                <label>Status:</label>
                                <%
                                    String status = old.getStatus();
                                    String badgeClass = "badge-status";
                                    if("Pending".equalsIgnoreCase(status)) {
                                        badgeClass += " badge-pending";
                                    } else if("Completed".equalsIgnoreCase(status) || "Delivered".equalsIgnoreCase(status)) {
                                        badgeClass += " badge-completed";
                                    } else {
                                        badgeClass += " badge-cancelled";
                                    }
                                %>
                                <span class="<%= badgeClass %>"><%= status %></span>
                            </p>
                        </div>
                        <div class="col-md-6">
                            <p><label>Name:</label> <%= old.getName() %></p>
                            <p><label>Phone:</label> <%= old.getPhone() %></p>
                            <p><label>Address Line 1:</label> <%= old.getAddress1() %></p>
                            <p><label>Address Line 2:</label> <%= old.getAddress2() %></p>
                            <p><label>Landmark:</label> <%= old.getLandmark() %></p>
                            <p><label>City:</label> <%= old.getCity() %></p>
                            <p><label>Pin Code:</label> <%= old.getPinCode() %></p>
                        </div>
                    </div>

                    <div class="mt-4">
                        <h5 class="text-center text-primary fw-bold mb-3"><i class="fas fa-book"></i> Purchased Books</h5>
                        <div class="table-responsive">
                            <table class="table table-hover align-middle">
                                <thead>
                                    <tr>
                                        <th>Book Name</th>
                                        <th>Author Name</th>
                                        <th>Quantity</th>
                                        <th>Price</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        for(OrderCartList ocl : old.getOcl()) {
                                    %>
                                    <tr>
                                        <td><%= ocl.getBookName() %></td>
                                        <td><%= ocl.getAuthorName() %></td>
                                        <td><%= ocl.getQuantity() %></td>
                                        <td>₹ <%= ocl.getPrice() %>/-</td>
                                    </tr>
                                    <%
                                        }
                                    %>
                                </tbody>
                            </table>
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
</body>
</html>
<%
    }
    catch(Exception e) {}
    }
%>
