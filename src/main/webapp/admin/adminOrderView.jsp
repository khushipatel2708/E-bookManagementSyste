<%@page import="com.dao.admin.AdminOrderDAO"%>
<%@page import="com.database.DBConnect"%>
<%@page import="com.detail.OrderCartList"%>
<%@page import="com.detail.OrderListDetail"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    if (session.getAttribute("adminObj") == null) {
        response.sendRedirect("./adminLogin.jsp");
        return;
    }

    int orderId = 0;
    try {
        orderId = Integer.parseInt(request.getParameter("orderId"));
    } catch (Exception e) {
        response.sendRedirect("./adminPanel.jsp");
        return;
    }

    AdminOrderDAO orderDAO = new AdminOrderDAO(DBConnect.getConnection());
    OrderListDetail old = orderDAO.getOrderView(orderId);

    if (old == null) {
        response.sendRedirect("./adminPanel.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <%@include file="./adminHead.jsp" %>
    <title>Order View | Book Store Admin</title>

    <!-- Bootstrap & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        body {
            background: #eef2f7;
            font-family: "Segoe UI", sans-serif;
        }
        .order-card {
            background-color: #fff;
            border-radius: 15px;
            box-shadow: 0 6px 20px rgba(0,0,0,0.12);
            padding: 30px;
            margin-top: 40px;
            transition: transform 0.3s ease;
        }
        .order-card:hover {
            transform: translateY(-3px);
        }
        .section-title {
            font-size: 1.4rem;
            font-weight: 700;
            margin-bottom: 25px;
            color: #0d6efd;
            text-transform: uppercase;
            border-bottom: 2px solid #0d6efd;
            padding-bottom: 6px;
            display: inline-block;
        }
        .info-label {
            font-weight: 600;
            color: #444;
            display: inline-block;
            min-width: 140px;
        }
        .info-value {
            color: #000;
        }
        .table {
            border-radius: 10px;
            overflow: hidden;
        }
        .table thead {
            background: #0d6efd;
            color: #fff;
        }
        .table tbody tr:hover {
            background: #f1f5ff;
        }
        .btn-outline-primary {
            border-radius: 30px;
            padding: 10px 25px;
            font-weight: 600;
            transition: 0.3s;
        }
        .btn-outline-primary:hover {
            background: #0d6efd;
            color: #fff;
        }
    </style>
</head>

<body>
    <%@include file="./adminNavbar.jsp" %>

    <div class="container mt-4 mb-5">
        <div class="row justify-content-center">
            <div class="col-lg-10">
                <div class="order-card">
                    <h4 class="section-title text-center"><i class="bi bi-receipt-cutoff me-2"></i>Order Details</h4>

                    <div class="row mb-4">
                        <div class="col-md-6">
                            <p><span class="info-label">Order No:</span> <span class="info-value"><%= old.getOrderID() %></span></p>
                            <p><span class="info-label">Total Price:</span> <span class="info-value">₹<%= old.getPrice() %></span></p>
                            <p><span class="info-label">Date:</span> <span class="info-value"><%= old.getDate() %></span></p>
                            <p><span class="info-label">Payment Method:</span> <span class="info-value"><%= old.getPaymentMethod() %></span></p>
                            <p><span class="info-label">Status:</span> <span class="badge bg-primary px-3 py-2"><%= old.getStatus() %></span></p>
                        </div>
                        <div class="col-md-6">
                            <p><span class="info-label">Name:</span> <%= old.getName() %></p>
                            <p><span class="info-label">Phone:</span> <%= old.getPhone() %></p>
                            <p><span class="info-label">Address Line 1:</span> <%= old.getAddress1() %></p>
                            <p><span class="info-label">Address Line 2:</span> <%= old.getAddress2() %></p>
                            <p><span class="info-label">Landmark:</span> <%= old.getLandmark() %></p>
                            <p><span class="info-label">City:</span> <%= old.getCity() %></p>
                            <p><span class="info-label">Pin Code:</span> <%= old.getPinCode() %></p>
                        </div>
                    </div>

                    <h5 class="section-title text-center"><i class="bi bi-journal-bookmark me-2"></i>Book List</h5>

                    <div class="table-responsive">
                        <table class="table table-hover align-middle">
                            <thead>
                                <tr>
                                    <th>Book Name</th>
                                    <th>Author Name</th>
                                    <th>Quantity</th>
                                    <th>Price (₹)</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    for (OrderCartList ocl : old.getOcl()) {
                                %>
                                <tr>
                                    <td><%= ocl.getBookName() %></td>
                                    <td><%= ocl.getAuthorName() %></td>
                                    <td><%= ocl.getQuantity() %></td>
                                    <td>₹<%= ocl.getPrice() %></td>
                                </tr>
                                <%
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>

                    <div class="text-center mt-4">
                        <a href="adminOrderBook.jsp" class="btn btn-outline-primary">
                            <i class="bi bi-arrow-left"></i> Back to Orders
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap Bundle JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
