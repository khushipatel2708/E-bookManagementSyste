<%-- 
    Document   : forgotPassword
    Created on : 09-Jun-2021, 2:20:16 PM
    Author     : chetan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Forgot Password | eBook Store</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Bootstrap -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"/>

    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: 'Segoe UI', sans-serif;
        }
        .card-custom {
            background: #fff;
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.2);
            width: 100%;
            max-width: 420px;
        }
        .brand {
            font-size: 1.8rem;
            font-weight: bold;
            color: #667eea;
        }
        .form-control {
            border-radius: 10px;
            padding: 12px;
        }
        .btn-custom {
            border-radius: 10px;
            font-weight: 600;
            padding: 10px;
        }
        .divider {
            height: 1px;
            background: #ddd;
            margin: 15px 0;
        }
        label {
            font-weight: 600;
            margin-top: 10px;
        }
    </style>
</head>
<body>

    <div class="card-custom">
        <!-- Brand -->
        <div class="text-center mb-3">
            <div class="brand"><i class="fas fa-book"></i> eBook</div>
            <small class="text-muted">Reset your password securely</small>
        </div>

        <div class="divider"></div>

        <!-- Status -->
        <div class="text-center">
            <small style="display: none;" id="status"></small>
        </div>

        <!-- Step 1: Email Form -->
        <form id="forgotForm">
            <label for="email">Email Address</label>
            <input class="form-control" type="text" placeholder="john@example.com" id="email" name="email" required/>
            <div class="text-center mt-3">
                <button type="submit" class="btn btn-primary btn-block btn-custom">
                    <i class="fas fa-paper-plane"></i> Send OTP
                </button>
            </div>
        </form>

        <!-- Step 2: OTP + Password -->
        <form id="otpConfirm" class="mt-4">
            <input type="password" hidden id="oEmail" name="oEmail" />

            <label for="otp">Enter OTP</label>
            <input class="form-control" type="text" placeholder="6-digit OTP" name="otp" maxlength="6" minlength="6" id="otp" required/>

            <label for="password">New Password</label>
            <input class="form-control" type="password" placeholder="********" name="password" id="password" required minlength="6"/>

            <div class="text-center mt-3">
                <input class="btn btn-success btn-block btn-custom" type="submit" value="Save Password"/>
            </div>
        </form>

        <!-- Footer -->
        <div class="text-center mt-4">
            <a href="./index.jsp" class="text-primary">← Back to Home</a>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="js/forgotPassword.js" type="text/javascript"></script>
</body>
</html>
