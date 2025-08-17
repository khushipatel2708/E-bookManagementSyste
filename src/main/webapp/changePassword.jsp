<%-- 
    Document   : changePassword
    Created on : 11-Jun-2021, 12:56:40 PM
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
        <title>Change Password | Book Store</title>
        <style>
            body {
                background: #f8f9fa;
                font-family: 'Open Sans', sans-serif;
            }

            .password-card {
                background: #ffffff;
                border-radius: 16px;
                padding: 30px;
                box-shadow: 0 6px 20px rgba(0,0,0,0.1);
                transition: transform 0.3s ease, box-shadow 0.3s ease;
            }
            .password-card:hover {
                transform: translateY(-6px);
                box-shadow: 0 10px 25px rgba(0,0,0,0.15);
            }

            .password-card h3 {
                font-weight: 700;
                color: #0077b6;
                margin-bottom: 15px;
            }

            .form-control {
                border-radius: 10px;
                border: 1px solid #ced4da;
                padding: 12px 14px;
                transition: all 0.3s ease;
            }
            .form-control:focus {
                border-color: #007bff;
                box-shadow: 0 0 6px rgba(0,123,255,0.4);
            }

            .btn-custom {
                border-radius: 30px;
                padding: 10px 30px;
                font-weight: 600;
                transition: all 0.3s ease;
            }
            .btn-custom:hover {
                background: #0056b3;
                transform: translateY(-2px);
                box-shadow: 0 6px 15px rgba(0,0,0,0.2);
            }

            #status {
                display: none;
                font-size: 0.9rem;
                margin-top: 8px;
            }
        </style>
    </head>
    <body>
        <%@include file="./component/navbar.jsp" %>
        
        <div class="container-md mt-5 mb-5">
            <div class="row justify-content-center">
                <div class="col-xl-6 col-lg-7 col-md-8 col-sm-10 col-12">
                    <div class="password-card text-center">
                        <h3><i class="fas fa-key"></i> Change Password</h3>
                        <small id="status"></small>

                        <form id="changePassword" class="mt-3">
                            <div class="mb-3">
                                <input class="form-control" type="password" minlength="6" placeholder="Old Password" id="oPassword" name="oPassword" required="required"/>
                            </div>
                            <div class="mb-3">
                                <input class="form-control" type="password" minlength="6" placeholder="New Password" id="nPassword" name="nPassword" required="required"/>
                            </div>
                            <div class="mb-3">
                                <input class="form-control" type="password" minlength="6" placeholder="Confirm Password" id="cPassword" name="cPassword" required="required"/>
                            </div>
                            <button type="submit" class="btn btn-primary btn-custom">Update Password</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        
        <script>
            $("#searchBook").attr("action","./newBook.jsp");
            $("#searchBook2").attr("action","./newBook.jsp");
        </script>
        <script src="js/changePassword.js" type="text/javascript"></script>
    </body>
</html>
<%
    }
%>
