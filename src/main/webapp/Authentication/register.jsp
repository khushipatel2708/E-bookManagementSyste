<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Registration</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
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

        <% String msg = request.getParameter("msg"); 
           if (msg != null) { %>
           <div class="alert alert-danger py-2"><%= msg %></div>
        <% } %>

        <!-- Registration Form (logic unchanged) -->
        <form action="<%= request.getContextPath() %>/RegisterServlet" method="post" id="registerForm" novalidate>
            <div class="mb-3">
                <div class="input-group">
                    <span class="input-group-text"><i class="bi bi-person-badge-fill"></i></span>
                    <input type="text" name="fullname" class="form-control" placeholder="Full Name" required>
                </div>
            </div>

            <div class="mb-3">
                <div class="input-group">
                    <span class="input-group-text"><i class="bi bi-person-circle"></i></span>
                    <input type="text" name="username" class="form-control" placeholder="Username" required>
                </div>
            </div>

            <div class="mb-3">
                <div class="input-group">
                    <span class="input-group-text"><i class="bi bi-envelope-fill"></i></span>
                    <input type="email" name="email" class="form-control" placeholder="Email Address" required>
                </div>
            </div>

            <div class="mb-3">
                <div class="input-group">
                    <span class="input-group-text"><i class="bi bi-lock-fill"></i></span>
                    <input type="password" name="password" class="form-control" placeholder="Password" required>
                </div>
            </div>

            <div class="mb-3">
                <div class="input-group">
                    <span class="input-group-text"><i class="bi bi-telephone-fill"></i></span>
                    <input type="text" name="phone" class="form-control" placeholder="Phone Number">
                </div>
            </div>

            <div class="mb-3">
                <div class="input-group">
                    <span class="input-group-text"><i class="bi bi-shield-lock-fill"></i></span>
                    <select name="role" class="form-select" required>
                        <option value="" disabled selected class="text-muted">Select Role</option>
                        <option value="2">User</option>
                        <option value="1">Admin</option>
                    </select>
                </div>
            </div>

            <div class="d-grid mb-2">
                <button type="submit" class="btn btn-dark">Register</button>
            </div>

            <div class="text-center">
                <a href="<%= request.getContextPath() %>/Authentication/login.jsp" class="text-decoration-none">
                    Already have an account? Login
                </a>
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
