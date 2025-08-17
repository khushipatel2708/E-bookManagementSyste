<%@page import="com.dao.CartDAO"%>
<%@page import="com.database.DBConnect"%>
<%@page import="com.dao.UserDAO"%>
<%@page import="com.detail.UserDetail"%>
<%
    UserDetail ud = (UserDetail) session.getAttribute("userL");
    if (ud != null) {
        UserDAO dao = new UserDAO();
        session.setAttribute("userL", dao.userDetail(ud.getEmail()));
        UserDetail ud1 = (UserDetail) session.getAttribute("userL");
        if (!ud1.isActive()) {
%>
<div class="container-fluid m-0 pt-1 pb-1 bg-danger text-center text-light">
    <p class="m-0">This account is not activate. Please check your email(<%= ud.getEmail()%>).</p>
</div>
<%
        }
    }
%>

<!--<div class="container-fluid p-4 top-navbar-custom m-0" id="topNavBar">
    <div class="row">
        <div class="col-md-2">
            <h3 class="text-success">
                <i class="fas fa-book"></i> eBook
            </h3>
        </div>

        <div  class="col-md-6 pl-5 pr-5">
            <form id="searchBook">
                <div style="display: flex">
                    <input class="form-control mr-sm-2" name="search" id="searchInput" type="search" placeholder="Search" aria-label="Search">
                    <button class="btn btn-primary my-2 my-sm-0" type="submit">Search</button>
                </div>
            </form>
        </div>

        <div class="col-md-4 text-right">
            <%
                if (ud == null) {
            %>
            <a href="login.jsp" class="btn btn-success">
                <i class="fas fa-user"></i> Login
            </a>

             Add this Register button 
            <a href="signup.jsp" class="btn btn-primary">
                <i class="fas fa-user-plus"></i> Register
            </a>
            <%
            } else {
            %>
            <a href="./UserLogoutServlet" class="btn btn-danger">
                <i class="fa fa-sign-out-alt" aria-hidden="true"></i> Logout
            </a>
            <%
                }
            %>

        </div>
    </div>
</div>-->

<!-- Modern Top Navbar -->
<nav class="navbar navbar-expand-lg navbar-light shadow-sm sticky-top" 
     style="background: linear-gradient(90deg, #007bff 0%, #6610f2 100%);">
  <div class="container">
    <!-- Brand -->
    <a class="navbar-brand text-white font-weight-bold d-flex align-items-center" href="./index.jsp">
      <i class="fas fa-book-open mr-2"></i> eBook
    </a>

    <!-- Mobile Toggle -->
    <button class="navbar-toggler text-white" type="button" data-toggle="collapse" data-target="#navbarNav" 
            aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>

    <!-- Menu -->
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

        <!-- Cart -->
        <%
            if (ud != null) {
                CartDAO cartDAO = new CartDAO(DBConnect.getConnection());
                int totalCart = cartDAO.totalCart(ud.getId());
        %>
        <li class="nav-item">
          <a class="nav-link text-white nav-hover" href="./myCart.jsp">
            <i class="fa fa-shopping-cart"></i> Cart 
            <span class="badge badge-light ml-1" id="navbarTotalCart"><%= totalCart%></span>
          </a>
        </li>
        <% } %>
      </ul>

      <!-- Right Buttons -->
      <div class="ml-3">
        <%
          if (ud == null) {
        %>
        <a href="login.jsp" class="btn btn-outline-light btn-sm mr-2">
          <i class="fas fa-sign-in-alt"></i> Login
        </a>
        <a href="signup.jsp" class="btn btn-warning btn-sm text-dark font-weight-bold">
          <i class="fas fa-user-plus"></i> Register
        </a>
        <%
          } else {
        %>
        <a href="./profile.jsp" class="btn btn-light btn-sm mr-2">
          <i class="fas fa-user"></i> <%= ud.getName() %>
        </a>
        <a href="./UserLogoutServlet" class="btn btn-danger btn-sm">
          <i class="fas fa-sign-out-alt"></i> Logout
        </a>
        <%
          }
        %>
      </div>
    </div>
  </div>
</nav>

<style>
  .nav-hover {
    transition: color 0.3s ease, transform 0.3s ease;
  }
  .nav-hover:hover {
    color: #ffd700 !important;  /* gold text highlight */
    transform: translateY(-2px); /* slight lift */
  }
  .navbar-brand {
    font-size: 1.4rem;
  }
  .badge {
    font-size: 0.75rem;
    border-radius: 12px;
    padding: 3px 7px;
  }
</style>


<div class="container-fluid p-4 top-navbar-custom2 m-0">
    <div class="row">
        <div class="col-md-5 col-sm-5 col-4">
            <h3 class="text-success">
                <i class="fas fa-book"></i> eBook
            </h3>
        </div>
        <div class="col-md-7 col-sm-7 col-8 text-right">
            <%
                if (ud == null) {
            %>
            <button class="btn btn-success btn-sm" data-toggle="modal" data-target="#modalLogin">
                <i class="fas fa-user"></i> Login
            </button>

            <%
            } else {
            %>
            <a href="./UserLogoutServlet" class="btn btn-danger btn-sm">
                <i class="fa fa-sign-out-alt" aria-hidden="true"></i> Logout
            </a>
            <%
                }
            %>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12 mt-2">
            <form id="searchBook2">
                <div style="display: flex">
                    <input class="form-control mr-1" id="searchInput2" name="search" type="search" placeholder="Search" aria-label="Search">
                    <button class="btn btn-primary " type="submit"><i class="fa fa-search" aria-hidden="true"></i></button>
                </div>
            </form>

        </div>
    </div>
</div>

<%
    if (ud == null) {
%>
<!--modal-->
<!--<div class="modal fade" id="modalLogin" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Sign in</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form id="loginForm">
                <div class="modal-body" >
                    <div class="alert alert-danger" id="lStatus" style="display: none"></div>
                    <label for="lEmail">Email Address</label> <br/>
                    <input type="email" id="lEmail" name="lEmail" required="required" class="form-control" placeholder="john@example.com" />
                    <label for="lPassword" class="mt-2">Password</label> <br/>
                    <input type="password" id="lPassword" name="lPassword" required="required" class="form-control" placeholder="password" />
                    <div class="text-center mt-2">
                        <a href="forgotPassword.jsp" target="_blank" >Forgot Password?</a>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary">Login</button>
                </div>
            </form>
        </div>
    </div>
</div>
<div class="modal fade" id="modalRegister" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Sign in</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form id="registerForm">
                <div class="modal-body" >
                    <div class="alert alert-danger" id="rStatus" style="display: none"></div>
                    <label for="rName">Name</label> <br/>
                    <input type="text" id="rName" name="rName" required="required" class="form-control" placeholder="John Smith" />
                    <label for="rEmail" class="mt-2">Email Address</label> <br/>
                    <input type="email" id="rEmail" name="rEmail" required="required" class="form-control" placeholder="john@example.com" />
                    <label for="rPassword" class="mt-2">Password</label> <br/>
                    <input type="password" id="rPassword" name="rPassword" required="required" class="form-control" placeholder="password" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary">Register</button>
                </div>
            </form>
        </div>
    </div>
</div>-->
<script src="./js/login.js" type="text/javascript"></script>
<%
    }
%>