<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Library Login</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap Icons -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
        <style>
            body {
                background-image: url('https://images.unsplash.com/photo-1524995997946-a1c2e315a42f');
                background-size: cover;
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
    <body class="d-flex align-items-center justify-content-start vh-100 px-4">

        <div class="login-card shadow">
            <div class="text-center mb-4">
                <i class="bi bi-pc-display-horizontal fs-1"></i>
                <h4 class="fw-bold mt-2">E-BOOK</h4>
                <p class="text-muted mb-0">Management System</p>
            </div>

            <form action="UserLoginServlet" method="post" id="loginForm" novalidate>
                <div class="mb-3">
                    <div class="input-group has-validation">
                        <span class="input-group-text"><i class="bi bi-person-fill"></i></span>
                        <input type="text" class="form-control" name="lEmail" placeholder="User Name" required>
                        <div class="invalid-feedback">Username is required.</div>
                    </div>
                </div>

                <div class="mb-3">
                    <div class="input-group has-validation">
                        <span class="input-group-text"><i class="bi bi-house-fill"></i></span>
                        <input type="password" class="form-control" name="lPassword" placeholder="Password" required>
                        <div class="invalid-feedback">Password is required.</div>
                    </div>
                </div>

                <div class="d-grid">
                    <button type="submit" class="btn btn-dark">Login</button>
                </div>
                <div class="text-center mt-3">
                    <span>Don't have an account?</span>
                    <a href="signup.jsp" class="text-decoration-none">Register here</a>
                </div>
                  <div class="text-center mt-2">
                        <a href="forgotPassword.jsp" target="_blank" >Forgot Password?</a>
                    </div>
            </form>


        </div>

        <script>
            // Bootstrap 5 form validation
            document.getElementById('loginForm').addEventListener('submit', function (event) {
                const form = event.target;

                if (!form.checkValidity()) {
                    event.preventDefault();
                    event.stopPropagation();
                }

                form.classList.add('was-validated');
            });

        </script>
    </body>
</html>
