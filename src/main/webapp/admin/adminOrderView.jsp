<%@page import="com.dao.admin.AdminOrderDAO"%>
<%@page import="com.database.DBConnect"%>
<%@page import="com.detail.OrderCartList"%>
<%@page import="com.detail.OrderListDetail"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    if (session.getAttribute("admin") == null) {
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
            background: #f8f9fa;
        }
        .order-card {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            padding: 25px;
            margin-top: 30px;
        }
        .section-title {
            font-size: 1.3rem;
            font-weight: 600;
            margin-bottom: 20px;
            color: #0d6efd;
        }
        .info-label {
            font-weight: 600;
            color: #333;
        }
        .info-value {
            margin-bottom: 10px;
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

                    <div class="row">
                        <div class="col-md-6">
                            <p><span class="info-label">Order No:</span> <%= old.getOrderID() %></p>
                            <p><span class="info-label">Total Price:</span> ₹<%= old.getPrice() %></p>
                            <p><span class="info-label">Date:</span> <%= old.getDate() %></p>
                            <p><span class="info-label">Payment Method:</span> <%= old.getPaymentMethod() %></p>
                            <p><span class="info-label">Status:</span> <%= old.getStatus() %></p>
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

                    <hr>

                    <h5 class="section-title text-center"><i class="bi bi-journal-bookmark me-2"></i>Book List</h5>

                    <div class="table-responsive">
                        <table class="table table-bordered table-striped align-middle">
                            <thead class="table-dark">
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
                                    <td><%= ocl.getPrice() %></td>
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
