<!--<!DOCTYPE html>
<html>
<head>
    <title>PayU Payment</title>
</head>
<body>
    <h2>Online Payment</h2>

    <form action="PayUServlet" method="post">
        <input type="text" id="firstname" name="firstname" placeholder="First Name" readonly required><br>
        <input type="email" id="email" name="email" placeholder="Email" readonly required><br>
        <input type="text" name="phone" placeholder="Phone" required><br>
        <input type="text" id="amount" name="amount" placeholder="Amount" readonly required><br>
        <input type="submit" value="Pay Now">
    </form>

    <script>
        // Function to get URL parameters
        function getQueryParam(param) {
            const urlParams = new URLSearchParams(window.location.search);
            return urlParams.get(param);
        }

        // Bind values to the input fields
        document.getElementById("firstname").value = getQueryParam("name") || "";
        document.getElementById("email").value = getQueryParam("email") || "";
        document.getElementById("amount").value = getQueryParam("amount") || "";
    </script>
</body>
</html>-->

<!DOCTYPE html>
<html>
<head>
    <title>PayU Payment</title>
    <!-- Bootstrap 4 or 5 CDN -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card shadow-sm">
                <div class="card-body">
                    <h3 class="text-center mb-4">Online Payment</h3>

                    <form action="PayUServlet" method="post">
                        <div class="form-group">
                            <input type="text" id="firstname" name="firstname" placeholder="First Name" class="form-control" readonly required>
                        </div>
                        <div class="form-group">
                            <input type="email" id="email" name="email" placeholder="Email" class="form-control" readonly required>
                        </div>
                        <div class="form-group">
                            <input type="text" id="phone" name="phone" placeholder="Phone" class="form-control" required autocomplete="off">
                        </div>
                        <div class="form-group">
                            <input type="text" id="amount" name="amount" placeholder="Amount" class="form-control" readonly required>
                        </div>
                        <button type="submit" class="btn btn-success btn-block">Pay Now</button>
                    </form>

                </div>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS (optional for interactive elements like modals) -->
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
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
