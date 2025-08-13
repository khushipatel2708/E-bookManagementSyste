<%@ page import="com.detail.BookTypeDetail" %>
<%
    BookTypeDetail type = (BookTypeDetail) request.getAttribute("type");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Book Type</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="p-4">

<h3>Edit Book Type</h3>
<form method="post" action="updateBookType">
    <input type="hidden" name="id" value="<%= type.getId() %>">

    <div class="mb-3">
        <label class="form-label">Type Name</label>
        <input type="text" name="typeName" class="form-control" value="<%= type.getTypeName() %>" required>
    </div>
    <div class="mb-3">
        <label class="form-label">Description</label>
        <textarea name="description" class="form-control"><%= type.getDescription() %></textarea>
    </div>
    <button type="submit" class="btn btn-success">Update</button>
    <a href="bookTypeList.jsp" class="btn btn-secondary">Cancel</a>
</form>

</body>
</html>
