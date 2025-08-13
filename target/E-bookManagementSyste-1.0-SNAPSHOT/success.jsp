<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Successful</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        body {
            background: whitesmoke;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Segoe UI', sans-serif;
            padding: 20px;
        }
        .success-card {
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(8px);
            border-radius: 20px;
            box-shadow: 0 8px 40px rgba(0,0,0,0.15);
            padding: 40px 30px;
            text-align: center;
            max-width: 600px;
            width: 100%;
            animation: fadeInUp 0.8s ease-in-out;
        }
        .success-icon {
            position: relative;
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
        .details-box {
            text-align: left;
            background: white;
            border-radius: 10px;
            padding: 15px 20px;
            margin-top: 20px;
        }
        .details-box p {
            margin: 0;
            font-size: 15px;
            color: #555;
        }
        .details-box p strong {
            color: #000;
        }
    </style>
</head>
<body>

<div class="success-card">
    <div class="success-icon">
        <i class="bi bi-check-lg"></i>
    </div>
    <h2 class="mt-3 fw-bold text-success">Payment Successful!</h2>
    <p class="text-muted">Your payment has been processed successfully. A confirmation email has been sent to you.</p>

    <div class="mt-4">
           <a href="./index.jsp" class="btn btn-success btn-lg px-4">
                                    <i class="bi bi-house-door"></i> Continue Shopping
                                </a>
    </div>
</div>
F
<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
