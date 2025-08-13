<%-- 
    Document   : failure
    Created on : Aug 5, 2025, 10:31:05 PM
    Author     : 91931
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Failed</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <style>
        body {
            background: whitesmoke;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .card {
            border: none;
            border-radius: 15px;
            box-shadow: 0px 4px 15px rgba(0,0,0,0.1); 
            padding: 30px;
            text-align: center; 
            max-width: 420px;
            background: #fff;
        }
        .failure-icon {
            font-size: 70px;
            color: #dc3545;
            animation: pulse 1s infinite alternate;
        }
        @keyframes pulse {
            from { transform: scale(1); }
            to { transform: scale(1.1); }
        }
    </style>
</head>
<body>

<div class="card">
    <div class="failure-icon">
        <i class="bi bi-x-circle-fill"></i>
    </div>
    <h2 class="mt-3 text-danger fw-bold">Payment Failed!</h2>
    <p class="text-muted">
        Unfortunately, your payment could not be processed. Please check your payment details or try again later.
    </p>
    <div class="d-grid gap-2 mt-4">
        <a href="payment.jsp" class="btn btn-danger btn-lg">
            <i class="bi bi-arrow-repeat"></i> Try Again
        </a>
        <a href="./index.jsp" class="btn btn-outline-secondary">
            <i class="bi bi-house"></i> Back to Home
        </a>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
