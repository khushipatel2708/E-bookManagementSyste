<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>User Registration</title>
</head>
<body>
    <h2>Register</h2>

    <% String msg = request.getParameter("msg"); 
       if (msg != null) { %>
       <p style="color:red;"><%= msg %></p>
    <% } %>

    <form action="<%= request.getContextPath() %>/RegisterServlet" method="post">
    Full Name: <input type="text" name="fullname" required><br>
    Username: <input type="text" name="username" required><br>
    Email: <input type="email" name="email" required><br>
    Password: <input type="password" name="password" required><br>
    Phone: <input type="text" name="phone"><br>
    Role: 
    <select name="role">
        <option value="2">User</option>
        <option value="1">Admin</option>
    </select><br>
    <input type="submit" value="Register">
</form>

    <p>Already have an account? 
       <a href="<%= request.getContextPath() %>/Authentication/login.jsp">Login Here</a>
    </p>
</body>
</html>
