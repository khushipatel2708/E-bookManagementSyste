<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>PayU Payment</title>
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #00c6ff, #0072ff);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Segoe UI', sans-serif;
        }
        .payment-card {
            background: #fff;
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0px 8px 25px rgba(0, 0, 0, 0.15);
            width: 100%;
            max-width: 420px;
        }
        .payment-card h3 {
            font-weight: 700;
            color: #0072ff;
        }
        .form-control {
            border-radius: 10px;
            padding: 12px;
        }
        .btn-pay {
            border-radius: 10px;
            font-weight: 600;
            padding: 12px;
        }
    </style>
</head>
<body>

<div class="payment-card">
    <h3 class="text-center mb-4">? PayU Payment</h3>

    <form action="PayUServlet" method="post">
        <div class="mb-3">
            <label class="form-label">First Name</label>
            <input type="text" id="firstname" name="firstname" class="form-control" readonly required>
        </div>

        <div class="mb-3">
            <label class="form-label">Email</label>
            <input type="email" id="email" name="email" class="form-control" readonly required>
        </div>

        <div class="mb-3">
            <label class="form-label">Phone</label>
            <input type="text" id="phone" name="phone" class="form-control" placeholder="Enter Phone" required autocomplete="off">
        </div>

        <div class="mb-4">
            <label class="form-label">Amount</label>
            <input type="text" id="amount" name="amount" class="form-control" readonly required>
        </div>

        <button type="submit" class="btn btn-success btn-pay w-100">Pay Now</button>
    </form>
</div>

<!-- Bootstrap & jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    function getQueryParam(param) {
        const urlParams = new URLSearchParams(window.location.search);
        return urlParams.get(param);
    }

    document.getElementById("firstname").value = getQueryParam("name") || "";
    document.getElementById("email").value = getQueryParam("email") || "";
    document.getElementById("amount").value = getQueryParam("amount") || "";
</script>

</body>
</html>
