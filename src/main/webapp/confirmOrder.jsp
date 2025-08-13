<%-- 
    Document   : confirmOrder
    Created on : 11-Jun-2021, 10:16:55 PM
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

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        /* Success Card Styling */
        .success-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(8px);
            border-radius: 20px;
            box-shadow: 0 8px 40px rgba(0,0,0,0.15);
            padding: 40px 30px;
            text-align: center;
            max-width: 600px;
            width: 100%;
            animation: fadeInUp 0.8s ease-in-out;
            margin: auto;
        }
        .success-icon {
            width: 90px;
            height: 90px;
            border-radius: 50%;
            background: #28a745;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto;
            animation: scaleUp 0.5s ease-in-out;
        }
        .success-icon i {
            font-size: 40px;
            color: #fff;
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
    
    <div class="container-md mt-4 mb-5">
        <div class="row mb-3">
            <div class="col-12 text-center">
                <h3>My Cart Details</h3>
                <small style="display: none;" id="status"></small>
            </div>
        </div>
        <div class="row">
            <div class="col-xl-6 offset-xl-3 col-lg-6 offset-lg-3 col-md-8 offset-md-2 col-sm-8 offset-sm-2 col-12">
                <div style="border-radius: 15px; border-color: #555555 !important;" class="cart border p-4">
                    <div id="tableInfo">
                        <table style="width: 100% ">
                            <thead class="font-weight-bold">
                                <tr>
                                    <td>Name</td>
                                    <td>Quantity</td>
                                    <td>Price</td>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    OrderDAO orderDAO = new OrderDAO(DBConnect.getConnection());
                                    int totalPrice = 0;
                                    for(CartDetail cd : list){
                                        if(!orderDAO.checkBookAvailable(cd.getBookId())) {
                                            continue;
                                        }
                                        totalPrice += cd.getPrice();
                                %>
                                <tr style="border-top: 1px solid grey;">
                                    <td style="padding-top: 3px;"><small><%= cd.getBookName() %></small></td>
                                    <td style="padding-top: 3px;"><small><%= cd.getQuantity()%></small></td>
                                    <td style="padding-top: 3px;"><small><%= cd.getPrice()%></small></td>
                                </tr>
                                <%
                                    }
                                %>
                            </tbody>
                        </table>
                        <hr/>
                        <small><span class="font-weight-bold">Total Price -</span> <%= totalPrice %>/-</small> <br/>
                        <small><span class="font-weight-bold">Delivery Charge -</span> <%= (totalPrice>=699)?0:70 %>/-</small><br/>
                        <small><span class="font-weight-bold">Total Order Price -</span> <%= ((totalPrice>=699)?0:70)+totalPrice %>/-</small>
                        <div class="text-center mt-2 mb-3">
                            <%
                                if(totalPrice==0){
                                    response.sendRedirect("./index.jsp");
                                }
                                boolean checkShip = orderDAO.checkShippingAddress(udCart.getId());
                                if(checkShip) {
                            %>
                                <a target="_blank" href="shippingAddress.jsp">Edit shipping address</a><br/>
                                <button onclick="paymentMethod()" class="mt-2 btn btn-sm btn-success">Payment Method</button>
                            <%
                                } else {
                            %>
                                <a target="_blank" href="shippingAddress.jsp">Add shipping address</a><br/>
                                <button class="mt-2 btn btn-sm btn-success" disabled>Payment Method</button>
                            <%        
                                }
                            %>
                        </div>
                    </div>

                    <div id="paymentMethod" style="display: none">
                        <label>Payment Method</label> <br/>
                        <select class="form-control" id="pMethod">
                            <option value="cash" selected>Cash On Delivery</option>
                            <option value="online">Online Payment</option>
                        </select>
                        <label class="mt-3"><span class="font-weight-bold">Total Order Price -</span> <%= ((totalPrice>=699)?0:70)+totalPrice %>/-</label><br/>
                        <div class="text-center">
                            <button onclick="confirmOrder()" class="btn btn-success mt-2">Confirm Order</button>
                        </div>
                    </div>

                    <!-- Updated Thanks for Order Section -->
                    <div id="thanksForOrder" style="display: none;">
                        <div class="success-card mt-4">
                            <div class="success-icon">
                                <i class="bi bi-check-lg"></i>
                            </div>
                            <h2 class="mt-3 fw-bold text-success">Thanks for ordering!</h2>
                            <p class="text-muted">Your order has been placed successfully. We’ll notify you once it’s shipped.</p>
                            <div class="mt-4">
                                <a href="./index.jsp" class="btn btn-success btn-lg px-4">
                                    <i class="bi bi-house-door"></i> Continue Shopping
                                </a>
                            </div>
                        </div>
                    </div>
                    <!-- End Thanks for Order -->
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
