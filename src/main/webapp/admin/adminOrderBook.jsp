<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.dao.admin.AdminOrderDAO"%>
<%@page import="java.util.List"%>
<%@page import="com.database.DBConnect"%>
<%@page import="com.detail.OrderListDetail"%>

<%
    if (session.getAttribute("admin") == null) {
        response.sendRedirect("./adminLogin.jsp");
        return; // important to stop further processing
    }

    AdminOrderDAO orderDAO = new AdminOrderDAO(DBConnect.getConnection());
    List<OrderListDetail> list = orderDAO.getOrderList();
%>

<!DOCTYPE html>
<html>
<head>
    <%@include file="adminHead.jsp" %>
    <title>Order List | Book Store Admin</title>
    
    <!-- Bootstrap & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body>

<%@include file="adminNavbar.jsp" %>

<div class="container-fluid mt-4 mb-5">
    <div class="row mb-3">
        <div class="col-12 text-center">
            <h3 class="text-primary"><i class="bi bi-cart-check me-2"></i>Order List</h3>
        </div>
    </div>

    <%
        if (!list.isEmpty()) {
    %>
    <div class="row">
        <div class="col-12 table-responsive">
            <table class="table table-bordered table-hover table-striped">
                <thead class="table-dark">
                    <tr>
                        <th>No.</th>
                        <th>Order No</th>
                        <th>Price</th>
                        <th>Time</th>
                        <th>Payment Method</th>
                        <th>Status</th>
                        <th>View</th>
                        <th>Delivered</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    int srNo = 1;
                    for (OrderListDetail cd : list) {
                %>
                    <tr>
                        <td><%= srNo++ %></td>
                        <td><%= cd.getOrderID() %></td>
                        <td><%= cd.getPrice() %>/-</td>
                        <td><%= cd.getDate() %></td>
                        <td><%= cd.getPaymentMethod() %></td>
                        <td><%= cd.getStatus() %></td>
                        <td>
                            <a class="btn btn-primary btn-sm" target="_blank" href="./adminOrderView.jsp?orderId=<%= cd.getOrderID() %>">
                                <i class="bi bi-eye"></i> View
                            </a>
                        </td>
                        <td>
                            <button class="btn btn-success btn-sm" onclick="deliveredOrder(<%= cd.getOrderID() %>)">
                                Delivered
                            </button>
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
        <div class="col-12 text-center text-warning">
            <h1><i class="bi bi-emoji-frown"></i></h1>
            <h4>No orders found.</h4>
        </div>
    </div>
    <%
        }
    %>
</div>

<!-- AJAX Script for delivered -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    function deliveredOrder(orderId) {
        $.ajax({
            url: "../DeliveredOrderServlet?orderId=" + orderId,
            method: "get",
            success: function (data) {
                if (data.trim() === "done") {
                    location.reload();
                } else {
                    alert("Something went wrong!");
                }
            },
            error: function () {
                alert("Something went wrong!");
            }
        });
    }
</script>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
