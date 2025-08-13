<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Register - Book Store</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        body {
            background: linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.6)),
                        url('https://wallpapercave.com/wp/wp9167352.jpg') no-repeat center center fixed;
            background-size: cover;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .register-card {
            background-color: rgba(255, 255, 255, 0.95);
            border-radius: 15px;
            padding: 40px;
            max-width: 900px;
            margin: auto;
        }

        .form-control::placeholder {
            color: #6c757d;
        }

        .error-msg {
            color: red;
            font-size: 0.9rem;
        }
    </style>
</head>
<body class="d-flex align-items-center justify-content-center vh-100 px-3">

    <div class="register-card shadow">
        <div class="text-center mb-4">
            <i class="bi bi-person-plus fs-1"></i>
            <h4 class="fw-bold mt-2">Admin Registration</h4>
            <p class="text-muted mb-0">Create your admin account</p>
        </div>

        <form method="post" action="${pageContext.request.contextPath}/admin/register" onsubmit="return validateForm()">
            <div class="row">
                <div class="col-md-6 mb-3">
                    <div class="input-group">
                        <span class="input-group-text"><i class="bi bi-person-badge-fill"></i></span>
                        <input type="text" name="fullName" class="form-control" placeholder="Full Name" required>
                    </div>
                </div>

                <div class="col-md-6 mb-3">
                    <div class="input-group">
                        <span class="input-group-text"><i class="bi bi-person-fill"></i></span>
                        <input type="text" name="userName" class="form-control" placeholder="Username" required>
                    </div>
                </div>

                <div class="col-md-6 mb-3">
                    <div class="input-group">
                        <span class="input-group-text"><i class="bi bi-envelope-fill"></i></span>
                        <input type="email" name="email" class="form-control" placeholder="Email" required>
                    </div>
                </div>

                <div class="col-md-6 mb-3">
                    <div class="input-group">
                        <span class="input-group-text"><i class="bi bi-telephone-fill"></i></span>
                        <input type="text" name="phone" class="form-control" placeholder="Phone Number" required>
                    </div>
                </div>

                <div class="col-md-6 mb-1">
                    <div class="input-group">
                        <span class="input-group-text"><i class="bi bi-lock-fill"></i></span>
                        <input type="password" id="password" name="password" class="form-control" placeholder="Password" required>
                    </div>
                    <small id="passwordError" class="error-msg"></small>
                </div>

                <div class="col-md-6 mb-4">
                    <div class="input-group">
                        <span class="input-group-text"><i class="bi bi-shield-lock-fill"></i></span>
                        <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" placeholder="Confirm Password" required>
                    </div>
                    <small id="confirmPasswordError" class="error-msg"></small>
                </div>
            </div>

            <div class="d-grid">
                <button type="submit" class="btn btn-dark">Register</button>
            </div>

            <div class="text-center mt-3">
                <a href="adminLogin.jsp" class="text-decoration-none">Already registered? Login here</a>
            </div>
        </form>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <!-- 🔐 Password Validation JS -->
    <script>
        function validateForm() {
            const password = document.getElementById("password").value;
            const confirmPassword = document.getElementById("confirmPassword").value;

            const passwordError = document.getElementById("passwordError");
            const confirmPasswordError = document.getElementById("confirmPasswordError");

            const regex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_+\-=[\]{};':"\\|,.<>/?]).{8,}$/;

            let valid = true;

            // Reset previous messages
            passwordError.innerText = "";
            confirmPasswordError.innerText = "";

            if (!regex.test(password)) {
                passwordError.innerText = "Password must be 8+ chars, include uppercase, lowercase, number, and special character.";
                valid = false;
            }

            if (password !== confirmPassword) {
                confirmPasswordError.innerText = "Passwords do not match.";
                valid = false;
            }

            return valid;
        }
    </script>
</body>
</html>
