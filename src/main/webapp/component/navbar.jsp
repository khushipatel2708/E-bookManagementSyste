<%@page import="com.dao.CartDAO"%>
<%@page import="com.database.DBConnect"%>
<%@page import="auth.User"%>

<%
    // Get user object from session
    User ud = (User) session.getAttribute("userObj");

    // Use a local variable name that won't conflict
    String navDisplayName = (String) session.getAttribute("userName");

    if (navDisplayName == null && ud != null) {
        navDisplayName = (ud.getFullname() != null && !ud.getFullname().trim().isEmpty())
                ? ud.getFullname()
                : ud.getUsername();
        session.setAttribute("userName", navDisplayName); // cache it in session
    }
%>

<!-- ? Show red line if account is pending -->
<%
    if (ud != null && "pending".equalsIgnoreCase(ud.getStatus())) {
%>
<div style="background-color:#dc3545; color:white; text-align:center; padding:5px; font-weight:bold;">
    ? Your account is not verified yet! Please check your email to activate it.
</div>
<%
    }
%>

<nav class="navbar navbar-expand-lg navbar-light shadow-sm sticky-top" 
     style="background: linear-gradient(90deg, #007bff 0%, #6610f2 100%);">
    <div class="container">
        <a class="navbar-brand text-white font-weight-bold d-flex align-items-center" href="./index.jsp">
            <i class="fas fa-book-open mr-2"></i> eBook
        </a>

        <button class="navbar-toggler text-white" type="button" data-toggle="collapse" data-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav mr-auto ml-4">
                <li class="nav-item active">
                    <a class="nav-link text-white nav-hover" href="./index.jsp"><i class="fas fa-home mr-1"></i> Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-white nav-hover" href="./allBooks.jsp"><i class="fas fa-book mr-1"></i> Books</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-white nav-hover" href="./Aboutus.jsp"><i class="fas fa-info-circle mr-1"></i> About</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-white nav-hover" href="./contact.jsp"><i class="fas fa-envelope mr-1"></i> Contact</a>
                </li>

                <% if (ud != null) {
                        CartDAO cartDAO = new CartDAO(DBConnect.getConnection());
                        int totalCart = cartDAO.totalCart(ud.getId());
                %>
                <li class="nav-item">
                    <a class="nav-link text-white nav-hover" href="./myCart.jsp">
                        <i class="fa fa-shopping-cart"></i> Cart 
                        <span id="navbarTotalCart" class="badge badge-light ml-1"><%= totalCart%></span>
                    </a>
                </li>

                <% } %>
            </ul>

            <div class="ml-3">
                <% if (ud == null) {%>
                <a href="<%= request.getContextPath()%>/Authentication/login.jsp" class="btn btn-outline-light btn-sm mr-2">
                    <i class="fas fa-sign-in-alt"></i> Login
                </a>
                <a href="<%= request.getContextPath()%>/Authentication/signup.jsp" class="btn btn-warning btn-sm text-dark font-weight-bold">
                    <i class="fas fa-user-plus"></i> Register
                </a>
                <% } else {%>
                <a href="./profile.jsp" class="btn btn-light btn-sm mr-2">
                    <i class="fas fa-user"></i> <%= navDisplayName%>
                </a>
                <a href="./UserLogoutServlet" class="btn btn-danger btn-sm">
                    <i class="fas fa-sign-out-alt"></i> Logout
                </a>
                <% }%>
            </div>
        </div>
    </div>
</nav>
