<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Library Register</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
        <style>
            body {
                background-image: url('https://images.unsplash.com/photo-1524995997946-a1c2e315a42f');
                background-size: cover;
            }
            .signup-card {
                background-color: rgba(255, 255, 255, 0.95);
                border-radius: 15px;
                padding: 40px;
                width: 450px;
                margin-left: 40px;
                box-shadow: 0 0 20px rgba(0,0,0,0.2);
            }
            .form-control::placeholder {
                color: #6c757d;
            }
        </style>
    </head>
    <body class="d-flex align-items-center justify-content-center vh-100">

        <div class="signup-card shadow">
            <div class="text-center mb-4">
                <i class="bi bi-person-plus-fill fs-1"></i>
                <h4 class="fw-bold mt-2">E-BOOK</h4>
                <p class="text-muted mb-0">User Registration</p>
            </div>

            <!-- ? Use correct input names that match servlet -->
            <form action="registerForm" method="post" id="registerForm" novalidate>
                <div class="mb-3">
                    <div class="input-group">
                        <span class="input-group-text"><i class="bi bi-person-badge-fill"></i></span>
                        <input type="text" name="rFullName" class="form-control" placeholder="Full Name" required>
                    </div>
                </div>

                <div class="mb-3">
                    <div class="input-group">
                        <span class="input-group-text"><i class="bi bi-person-circle"></i></span>
                        <input type="text" name="rName" class="form-control" placeholder="Username" required>
                    </div>
                </div>

                <div class="mb-3">
                    <div class="input-group">
                        <span class="input-group-text"><i class="bi bi-telephone-fill"></i></span>
                        <input type="text" name="rPhone" class="form-control" placeholder="Phone Number" required>
                    </div>
                </div>

                <div class="mb-3">
                    <div class="input-group">
                        <span class="input-group-text"><i class="bi bi-envelope-fill"></i></span>
                        <input type="email" name="rEmail" class="form-control" placeholder="Email Address" required>
                    </div>
                </div>

                <div class="mb-3">
                    <div class="input-group">
                        <span class="input-group-text"><i class="bi bi-lock-fill"></i></span>
                        <input type="password" name="rPassword" class="form-control" placeholder="Password" required minlength="6">
                    </div>
                </div>

                <div class="mb-3">
                    <div class="input-group">
                        <span class="input-group-text"><i class="bi bi-lock"></i></span>
                        <input type="password" name="rConfirmPassword" class="form-control" placeholder="Confirm Password" required minlength="6">
                    </div>
                </div>

                <div class="d-grid mb-2">
                    <button type="submit" class="btn btn-dark">Register</button>
                </div>

                <div class="text-center">
                    <a href="login.jsp" class="text-decoration-none">Already have an account? Login</a>
                </div>
            </form>

        </div>

        <script>
            document.getElementById('registerForm').addEventListener('submit', function (event) {
                const form = this;
                if (!form.checkValidity()) {
                    event.preventDefault();
                    event.stopPropagation();
                }
                form.classList.add('was-validated');
            });
        </script>
    </body>
</html>
