<%-- 
    Document   : profile
    Created on : 11-Jun-2021, 12:31:58 PM
    Author     : chetan
--%>
<%
    if(session.getAttribute("userL")==null){
        response.sendRedirect("./index.jsp");
    } else {
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="./component/header.jsp" %>
        <title>Profile | Book Store</title>
        <!-- SweetAlert2 CDN -->
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <style>
            body {
                background: #f8f9fa;
                font-family: 'Open Sans', sans-serif;
            }

            .profile-header {
                text-align: center;
                margin: 40px 0 30px 0;
            }
            .profile-header h2 {
                font-weight: 700;
                color: #0077b6;
            }
            .profile-header p {
                color: #6c757d;
            }

            .card-link-a {
                text-decoration: none !important;
            }

            .card-custom {
                background: #ffffff;
                border-radius: 16px;
                border: none;
                box-shadow: 0 4px 12px rgba(0,0,0,0.08);
                transition: all 0.3s ease-in-out;
                height: 100%;
            }
            .card-custom:hover {
                transform: translateY(-8px);
                box-shadow: 0 8px 20px rgba(0,0,0,0.15);
            }

            .card-custom .card-body i {
                margin-bottom: 12px;
                transition: transform 0.3s ease;
            }
            .card-custom:hover .card-body i {
                transform: scale(1.15) rotate(-5deg);
            }

            .card-custom h4 {
                font-weight: 600;
                margin-bottom: 8px;
            }

            .divider {
                width: 50px;
                height: 3px;
                margin: 0 auto;
                border-radius: 2px;
            }
            .text-primary .divider { background-color: #007bff; }
            .text-success .divider { background-color: #28a745; }
            .text-info .divider { background-color: #17a2b8; }
            .text-warning .divider { background-color: #ffc107; }
            .text-danger .divider { background-color: #dc3545; }
        </style>
    </head>
    <body>
        <%@include file="./component/navbar.jsp" %>
        
        <!-- Header -->
        <div class="container profile-header">
            <h2>👤 My Profile</h2>
            <p>Manage your account, orders, and preferences</p>
        </div>

        <!-- Profile Options -->
        <div class="container-md mb-5">
            <div class="row g-4">
                <div class="col-xl-4 col-lg-4 col-md-6 col-sm-6 col-12">
                    <a class="card-link-a" href="./myCart.jsp">
                        <div class="card text-center text-primary p-4 card-custom">
                            <div class="card-body">
                                <i class="fas fa-shopping-cart fa-3x"></i>
                                <h4>My Cart</h4>
                                <div class="divider"></div>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col-xl-4 col-lg-4 col-md-6 col-sm-6 col-12">
                    <a class="card-link-a" href="./orderList.jsp">
                        <div class="card text-center text-success p-4 card-custom">
                            <div class="card-body">
                                <i class="fas fa-shopping-bag fa-3x"></i>
                                <h4>My Orders</h4>
                                <div class="divider"></div>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col-xl-4 col-lg-4 col-md-6 col-sm-6 col-12">
                    <a class="card-link-a" href="./shippingAddress.jsp">
                        <div class="card text-center text-info p-4 card-custom">
                            <div class="card-body">
                                <i class="fas fa-address-card fa-3x"></i>
                                <h4>Shipping Address</h4>
                                <div class="divider"></div>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col-xl-4 col-lg-4 col-md-6 col-sm-6 col-12 mt-4">
                    <a class="card-link-a" href="./changePassword.jsp">
                        <div class="card text-center text-warning p-4 card-custom">
                            <div class="card-body">
                                <i class="fas fa-unlock-alt fa-3x"></i>
                                <h4>Change Password</h4>
                                <div class="divider"></div>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col-xl-4 col-lg-4 col-md-6 col-sm-6 col-12 mt-4">
                    <a class="card-link-a" href="javascript:void(0)" onclick="deleteAccount()">
                        <div class="card text-center text-danger p-4 card-custom">
                            <div class="card-body">
                                <i class="fas fa-user-slash fa-3x"></i>
                                <h4>Delete Account</h4>
                                <div class="divider"></div>
                            </div>
                        </div>
                    </a>
                </div>
            </div>
        </div>
        
        <script>
            $("#searchBook").attr("action","./newBook.jsp");
            $("#searchBook2").attr("action","./newBook.jsp");

            // SweetAlert delete confirmation
            function deleteAccount() {
                Swal.fire({
                    title: 'Are you sure?',
                    text: "This action will permanently delete your account!",
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#d33',
                    cancelButtonColor: '#3085d6',
                    confirmButtonText: 'Yes, delete it!',
                    cancelButtonText: 'Cancel'
                }).then((result) => {
                    if (result.isConfirmed) {
                        // Redirect to deleteAccount servlet or JSP
                        window.location.href = "deleteAccount.jsp";
                    }
                });
            }
        </script>
    </body>
</html>
<%
    }
%>
