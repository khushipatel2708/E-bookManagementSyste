<%@ page import="com.detail.AdminDetail" %>
<%@ page session="true" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%
    AdminDetail admin = (AdminDetail) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Profile</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            background-color: #f2f2f2;
        }
        .profile-card {
            background: #fff;
            padding: 30px;
            border-radius: 10px;
            max-width: 600px;
            margin: auto;
            margin-top: 60px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body>

<!-- Removed header.jsp for testing -->

<div class="container">
    <div class="profile-card">
        <h4 class="text-center text-success mb-4"><i class="bi bi-person-circle"></i> Admin Profile</h4>
        <form method="post" action="updateProfile">
            <input type="hidden" name="userName" value="<%= admin.getUserName() %>"/>

            <div class="mb-3">
                <label class="form-label">Full Name</label>
                <input type="text" name="fullName" value="<%= admin.getFullName() %>" class="form-control" required/>
            </div>
  <div class="mb-3">
                <label class="form-label">User Name</label>
                <input type="text" name="userName" value="<%= admin.getUserName() %>" class="form-control" required/>
            </div>
            <div class="mb-3">
                <label class="form-label">Email</label>
                <input type="email" name="email" value="<%= admin.getEmail() %>" class="form-control" required/>
            </div>

            <div class="mb-3">
                <label class="form-label">Phone</label>
                <input type="text" name="phone" value="<%= admin.getPhone() %>" class="form-control" required/>
            </div>

            <div class="d-grid">
                <button type="submit" class="btn btn-success">Update Profile</button>
            </div>
        </form>
    </div>
</div>

</body>
</html>
