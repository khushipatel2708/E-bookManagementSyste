<!-- Include this in your <head> section -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

<style>
    .admin-header {
        background-color: #f8f9fa;
        border-bottom: 2px solid #dee2e6;
    }
    .navbar-dark.bg-custom {
        background-color: #2F4F4F;
    }
    .top-navbar-custom2 {
        background-color: #fff;
    }
</style>


<!-- Unified Sticky Header + Navbar -->
<div class="sticky-top" style="z-index: 1030;">
    <!-- Top Header -->
    <nav class="navbar navbar-expand-sm navbar-dark bg-custom shadow-sm sticky-top">
    </nav>
    <!-- Top Header -->
    <div class="container-fluid admin-header">
        <div class="row align-items-center">
            <div class="col-md-4 py-2 text-md-start text-center mb-2 mb-md-0">
                <h3 class="text-success m-0 fw-bold">
                    <i class="bi bi-book-half"></i> Book Store
                </h3>
            </div>
            <div class="col-md-4 d-none d-md-block"></div>
            <div class="col-md-4 text-md-end text-center">
                <a href="../AdminLogoutServlet" class="btn btn-sm btn-danger shadow-sm">
                    <i class="bi bi-box-arrow-right"></i> Logout
                </a>
            </div>
        </div>
    </div>

    <!-- Main Navigation -->
    <nav class="navbar navbar-expand-sm navbar-dark bg-custom shadow-sm p-0">
        <div class="container-fluid">
            <a class="navbar-brand">Admin Panel</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                    data-bs-target="#adminNavbar" aria-controls="adminNavbar" aria-expanded="false"
                    aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="adminNavbar">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item me-3">
                        <a class="nav-link active" href="./adminPanel.jsp"><i class="bi bi-house-door-fill"></i> Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="../index.jsp"><i class="bi bi-globe"></i> Main Website</a>
                    </li>
                    <li class="nav-item me-3">
                        <a class="nav-link" href="adminProfile.jsp"><i class="bi bi-person-circle"></i> Profile</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
</div>
