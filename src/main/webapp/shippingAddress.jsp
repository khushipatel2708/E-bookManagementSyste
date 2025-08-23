<%@ page import="auth.User" %>
<%@ page import="com.dao.ShippingDAO" %>
<%@ page import="com.detail.ShippingDetail" %>
<%@ page import="com.database.DBConnect" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
    // Check if user is logged in
    User user = (User) session.getAttribute("userObj");
    if (user == null) {
        response.sendRedirect("./index.jsp");
        return;
    }

    // Fetch shipping address for logged-in user
    ShippingDAO shipDAO = new ShippingDAO(DBConnect.getConnection());
    ShippingDetail sd = shipDAO.getAddress(user.getId());
%>

<!DOCTYPE html>
<html>
<head>
    <%@ include file="./component/header.jsp" %>
    <title>Shipping Address | Book Store</title>
    <style>
        body { background: #f8f9fa; font-family: "Open Sans", sans-serif; }
        .address-card {
            background: #fff; border-radius: 16px; padding: 35px; margin-top: 20px;
            box-shadow: 0 6px 20px rgba(0,0,0,0.1); transition: all 0.3s ease;
        }
        .address-card:hover { transform: translateY(-5px); box-shadow: 0 10px 25px rgba(0,0,0,0.15); }
        h3 { font-weight: 700; color: #0077b6; }
        label { font-weight: 600; color: #333; }
        .form-control { border-radius: 10px; padding: 12px 14px; border: 1px solid #ced4da; transition: 0.3s ease; }
        .form-control:focus { border-color: #007bff; box-shadow: 0 0 6px rgba(0,123,255,0.3); }
        .btn-custom { border-radius: 30px; padding: 10px 30px; font-weight: 600; transition: all 0.3s ease; }
        .btn-custom:hover { background: #0056b3; transform: translateY(-2px); box-shadow: 0 6px 15px rgba(0,0,0,0.2); }
        #status { display: none; font-size: 0.9rem; margin-top: 10px; }
    </style>
</head>
<body>
    <%@ include file="./component/navbar.jsp" %>

    <div class="container-md mt-4 mb-5">
        <div class="row justify-content-center">
            <div class="col-xl-8 col-lg-9 col-md-10 col-sm-11 col-12">
                <div class="address-card">
                    <div class="text-center mb-4">
                        <h3><i class="fas fa-map-marker-alt"></i> Shipping Address</h3>
                        <small id="status"></small>
                    </div>

                    <form id="shippingAddress">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="name">Full Name <span class="text-danger">*</span></label>
                                <input type="text" class="form-control"
                                       value="<%= (sd != null) ? sd.getName() : user.getFullname() %>"
                                       name="name" id="name" maxlength="30" required placeholder="Enter Your Full Name" />
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="phone">Phone Number <span class="text-danger">*</span></label>
                                <input type="number" class="form-control"
                                       value="<%= (sd != null) ? sd.getPhone() : user.getPhone() %>"
                                       name="phone" id="phone" required placeholder="+91 9638527410" />
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="add1">Address Line 1 <span class="text-danger">*</span></label>
                                <input type="text" class="form-control"
                                       value="<%= (sd != null) ? sd.getAddress1() : "" %>"
                                       name="add1" id="add1" maxlength="30" required placeholder="Address Line 1" />
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="add2">Address Line 2</label>
                                <input type="text" class="form-control"
                                       value="<%= (sd != null) ? sd.getAddress2() : "" %>"
                                       name="add2" id="add2" maxlength="30" placeholder="Address Line 2" />
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="lMark">Landmark <span class="text-danger">*</span></label>
                                <input type="text" class="form-control"
                                       value="<%= (sd != null) ? sd.getLandmark() : "" %>"
                                       name="lMark" id="lMark" maxlength="30" required placeholder="Landmark" />
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="city">City <span class="text-danger">*</span></label>
                                <input type="text" class="form-control"
                                       value="<%= (sd != null) ? sd.getCity() : "" %>"
                                       name="city" id="city" maxlength="30" required placeholder="City" />
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="pin">Pin Code <span class="text-danger">*</span></label>
                                <input type="number" class="form-control"
                                       value="<%= (sd != null) ? sd.getPinCode() : "" %>"
                                       name="pin" id="pin" required placeholder="For eg: 250002" />
                            </div>
                        </div>

                        <div class="text-center mt-3">
                            <button type="submit" class="btn btn-primary btn-custom">
                                <%= (sd == null) ? "Save" : "Update" %>
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script>
        $("#searchBook").attr("action","./newBook.jsp");
        $("#searchBook2").attr("action","./newBook.jsp");
    </script>
    <script src="js/shippingAddress.js" type="text/javascript"></script>
</body>
</html>
