<%-- 
    Document   : confirmOrder
    Created on : 11-Jun-2021
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
        if(list.size()==0) {
            response.sendRedirect("./index.jsp");
        }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@include file="./component/header.jsp" %>
    <title>Confirm Order | Book Store</title>

    <!-- Bootstrap & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        body {
            background: linear-gradient(135deg, #f5f7fa, #c3cfe2);
            min-height: 100vh;
        }
        .checkout-card {
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(8px);
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            animation: fadeIn 0.6s ease-in-out;
        }
        .checkout-header {
            font-weight: 700;
            font-size: 1.6rem;
            color: #333;
            text-align: center;
        }
        .table th {
            background-color: #f8f9fa;
        }
        .btn-custom {
            background: linear-gradient(45deg, #28a745, #218838);
            color: white;
            border: none;
            transition: all 0.3s ease;
        }
        .btn-custom:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.15);
        }
        .success-card {
            background: white;
            border-radius: 20px;
            padding: 40px 30px;
            text-align: center;
            box-shadow: 0 8px 30px rgba(0,0,0,0.1);
            animation: fadeInUp 0.8s ease-in-out;
        }
        .success-icon {
            width: 90px;
            height: 90px;
            background: #28a745;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            animation: scaleUp 0.5s ease-in-out;
            margin: 0 auto;
        }
        .success-icon i {
            font-size: 40px;
            color: #fff;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: scale(0.98); }
            to { opacity: 1; transform: scale(1); }
        }
        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }
        @keyframes scaleUp {
            from { transform: scale(0.5); opacity: 0; }
            to { transform: scale(1); opacity: 1; }
        }
    </style>
</head>
<body>
    <%@include file="./component/navbar.jsp" %>
    
    <div class="container-md mt-5 mb-5">
        <div class="row">
            <div class="col-lg-6 offset-lg-3 col-md-8 offset-md-2">
                <div class="checkout-card">
                    <h3 class="checkout-header mb-4">Review Your Order</h3>
                    
                    <table class="table table-bordered align-middle text-center">
                        <thead>
                            <tr>
                                <th>Book</th>
                                <th>Qty</th>
                                <th>Price</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                OrderDAO orderDAO = new OrderDAO(DBConnect.getConnection());
                                int totalPrice = 0;
                                for(CartDetail cd : list){
                                    if(!orderDAO.checkBookAvailable(cd.getBookId())) continue;
                                    totalPrice += cd.getPrice();
                            %>
                            <tr>
                                <td><%= cd.getBookName() %></td>
                                <td><%= cd.getQuantity()%></td>
                                <td>₹<%= cd.getPrice()%></td>
                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
                    
                    <div class="mt-3">
                        <p><strong>Total Price:</strong> ₹<%= totalPrice %></p>
                        <p><strong>Delivery Charge:</strong> ₹<%= (totalPrice>=699)?0:70 %></p>
                        <p class="fw-bold fs-5">Total: ₹<%= ((totalPrice>=699)?0:70)+totalPrice %></p>
                    </div>

                    <div class="text-center mt-4">
                        <%
                            if(totalPrice==0){
                                response.sendRedirect("./index.jsp");
                            }
                            boolean checkShip = orderDAO.checkShippingAddress(udCart.getId());
                            if(checkShip) {
                        %>
                            <a href="shippingAddress.jsp" target="_blank" class="d-block mb-2">Edit Shipping Address</a>
                            <button onclick="paymentMethod()" class="btn btn-custom px-4">Choose Payment Method</button>
                        <%
                            } else {
                        %>
                            <a href="shippingAddress.jsp" target="_blank" class="d-block mb-2">Add Shipping Address</a>
                            <button class="btn btn-custom px-4" disabled>Choose Payment Method</button>
                        <% } %>
                    </div>

                    <div id="paymentMethod" style="display: none;" class="mt-4">
                        <label class="fw-bold">Payment Method</label>
                        <select class="form-control mb-3" id="pMethod">
                            <option value="cash" selected>Cash On Delivery</option>
                            <option value="online">Online Payment</option>
                        </select>
                        <div class="text-center">
                            <button onclick="confirmOrder()" class="btn btn-custom px-4">Confirm Order</button>
                        </div>
                    </div>

                    <div id="thanksForOrder" style="display: none;" class="mt-4">
                        <div class="success-card">
                            <div class="success-icon">
                                <i class="bi bi-check-lg"></i>
                            </div>
                            <h2 class="mt-3 text-success">Thanks for ordering!</h2>
                            <p>Your order has been placed successfully. We'll notify you when it's shipped.</p>
                            <a href="./index.jsp" class="btn btn-custom mt-3 px-4">
                                <i class="bi bi-house-door"></i> Continue Shopping
                            </a>
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
    <script src="./js/confirmOrder.js"></script>
    <script>
        const totalOrderPrice = <%= ((totalPrice >= 699) ? 0 : 70) + totalPrice %>;
        const userName = "<%= udCart.getName() %>";
        const userEmail = "<%= udCart.getEmail() %>";
    </script>
</body>
</html>
<%
    }
%>
