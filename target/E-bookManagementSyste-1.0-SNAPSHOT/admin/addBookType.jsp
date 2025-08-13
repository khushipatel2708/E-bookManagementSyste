<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("admin") == null) {
        response.sendRedirect("./adminLogin.jsp");
    } else {
%>
<!DOCTYPE html>
<html>
<head>
    <%@include file="adminHead.jsp" %>
    <title>Add Book Type | Book Store Admin</title>

    <!-- Bootstrap & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        body {
            background: linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.6)),
                url('https://wallpapercave.com/wp/wp9167352.jpg') no-repeat center center fixed;
            background-size: cover;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .card-form {
            background-color: rgba(255, 255, 255, 0.95);
            border-radius: 12px;
            box-shadow: 0 6px 16px rgba(0, 0, 0, 0.25);
            padding: 20px;
            margin-top: 30px;
            animation: fadeIn 0.8s ease-in-out;
            max-width: 500px;
            margin-left: auto;
            margin-right: auto;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        h3 {
            font-weight: 600;
            font-size: 24px;
            color: #0d6efd;
        }
        .btn {
            font-size: 15px;
            padding: 8px 24px;
        }
    </style>
</head>

<body>
    <%@include file="adminNavbar.jsp" %>

    <div class="container mt-5 mb-5">
        <div class="row justify-content-center">
            <div class="col-xl-6 col-lg-8 col-md-10">
                <div class="text-center mb-3">
                    <h3 class="text-white fw-bold"><i class="bi bi-tags-fill me-2"></i>Add Book Type</h3>
                    <small id="status" class="text-muted"></small>
                </div>
                <div class="card-form">
                    <form action="addBookType" method="post">
                        <div class="row mb-3 align-items-center">
                            <div class="col-4">
                                <label for="typeName" class="col-form-label">Type Name <span class="text-danger">*</span></label>
                            </div>
                            <div class="col-8">
                                <input type="text" class="form-control" id="typeName" name="typeName" placeholder="Education, MCA, BCA..." maxlength="100" required>
                            </div>
                        </div>

                        <div class="row mb-3 align-items-center">
                            <div class="col-4">
                                <label for="description" class="col-form-label">Description</label>
                            </div>
                            <div class="col-8">
                                <textarea class="form-control" id="description" name="description" rows="3" placeholder="Enter short description"></textarea>
                            </div>
                        </div>

                        <div class="text-center">
                            <button type="submit" class="btn btn-primary px-4">
                                <i class="bi bi-plus-circle me-1"></i> Save
                            </button>
                            <a href="bookTypeList.jsp" class="btn btn-secondary px-4">
                                <i class="bi bi-arrow-left me-1"></i> Cancel
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
<%
    }
%>
