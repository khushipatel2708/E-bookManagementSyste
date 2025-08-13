<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Login - Book Store</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    
    <style>
        body {
             background: linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.6)),
                    url('https://wallpapercave.com/wp/wp9167352.jpg') no-repeat center center fixed;
                background-size: cover;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .login-card {
            background-color: rgba(255, 255, 255, 0.9);
            border-radius: 15px;
            padding: 40px;
            max-width: 400px;
            margin: auto;
        }
        .form-control::placeholder {
            color: #6c757d;
        }
    </style>
</head>
<body class="d-flex align-items-center justify-content-center vh-100 px-3">

    <div class="login-card shadow">
        <div class="text-center mb-4">
            <i class="bi bi-person-gear fs-1"></i>
            <h4 class="fw-bold mt-2">Admin Panel</h4>
            <p class="text-muted mb-0">Login to manage books</p>
        </div>

        <form id="adminLogin" novalidate>
            <div class="mb-3">
                <div class="input-group has-validation">
                    <span class="input-group-text"><i class="bi bi-person-fill"></i></span>
                    <input type="text" class="form-control" name="name" placeholder="Username" required>
                    <div class="invalid-feedback">Username is required.</div>
                </div>
            </div>

            <div class="mb-3">
                <div class="input-group has-validation">
                    <span class="input-group-text"><i class="bi bi-lock-fill"></i></span>
                    <input type="password" class="form-control" name="password" placeholder="Password" required>
                    <div class="invalid-feedback">Password is required.</div>
                </div>
            </div>

            <div class="text-center mb-2">
                <small id="status" class="text-danger" style="display:none;">Invalid username or password</small>
            </div>

            <div class="d-grid">
                <button type="submit" class="btn btn-dark">Login</button>
            </div>
            <div class="text-center mt-2">
    <a href="adminRegister.jsp" class="text-decoration-none">New Admin? Register here</a>
</div>

        </form>
    </div>

    <!-- Scripts -->
    <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        // Form validation
        document.getElementById('adminLogin').addEventListener('submit', function (event) {
            const form = event.target;
            if (!form.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
            }
            form.classList.add('was-validated');
        });

        // AJAX login
        $(document).ready(function () {
            $("#adminLogin").on("submit", function (event) {
                event.preventDefault();
                var f = $(this).serialize();
                $.ajax({
                    url: "../AdminLoginServlet",
                    data: f,
                    type: "POST",
                    success: function (data) {
                        if (data.trim() === "done") {
                            location.href = "./adminPanel.jsp";
                        } else {
                            $("#status").show();
                        }
                    },
                    error: function () {
                        $("#status").show();
                    }
                });
            });
        });
    </script>
</body>
</html>
