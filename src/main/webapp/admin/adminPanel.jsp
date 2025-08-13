<%
    if(session.getAttribute("admin") == null){
        response.sendRedirect("./adminLogin.jsp");
    } else {
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@include file="adminHead.jsp" %>
    <title>Admin Panel | Book Store</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background: linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.6)),
                        url('https://wallpapercave.com/wp/wp9167352.jpg') no-repeat center center fixed;
            background-size: cover;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            animation: fadeInBody 1.2s ease-in;
        }

        @keyframes fadeInBody {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        .welcome-heading {
            font-size: 2.2rem;
            color: #ffffff;
            font-weight: 700;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.6);
            animation: slideDown 1s ease;
        }

        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .subtitle {
            color: #ccc;
            margin-bottom: 30px;
            animation: fadeInText 1.2s ease;
        }

        @keyframes fadeInText {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .card-custom {
            border: none;
            border-radius: 15px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            background: #ffffff;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            opacity: 0;
            transform: translateY(20px);
            animation: fadeInCard 0.9s ease forwards;
        }

        .card-custom:nth-child(1) { animation-delay: 0.2s; }
        .card-custom:nth-child(2) { animation-delay: 0.4s; }
        .card-custom:nth-child(3) { animation-delay: 0.6s; }

        @keyframes fadeInCard {
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .card-custom:hover {
            transform: translateY(-8px);
            box-shadow: 0 12px 30px rgba(0, 0, 0, 0.2);
        }

        .card-body h4 {
            margin-top: 15px;
            font-weight: 600;
            color: #333;
        }

        .card-body img {
            width: 60px;
            height: 60px;
        }

        .card-body p {
            color: #666;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <%@include file="adminNavbar.jsp" %>

    <div class="container mt-5 mb-5">
        <div class="row">
            <div class="col-12 text-center">
                <h2 class="welcome-heading">Welcome to Admin Panel</h2>
                <p class="subtitle">Manage everything related to your Book Store from here</p>
            </div>
        </div>

        <div class="row g-4">
            <div class="col-xl-4 col-lg-4 col-md-6 col-sm-12">
                <a class="text-decoration-none" href="./adminAddBook.jsp">
                    <div class="card text-center card-custom p-4">
                        <div class="card-body">
                            <img src="https://cdn0.iconfinder.com/data/icons/carbon-mobile-browser-2/48/Add_to_reading_list-512.png" alt="Add Book Icon">
                            <h4>Add Books</h4>
                            <p>Add new books to your store's collection</p>
                        </div>
                    </div>
                </a>
            </div>

            <div class="col-xl-4 col-lg-4 col-md-6 col-sm-12">
                <a class="text-decoration-none" href="./adminAllBook.jsp">
                    <div class="card text-center card-custom p-4">
                        <div class="card-body">
                            <img src="https://icon-library.com/images/books-icon-png/books-icon-png-12.jpg" alt="All Books Icon">
                            <h4>All Books</h4>
                            <p>View and manage all listed books</p>
                        </div>
                    </div>
                </a>
            </div>

            <div class="col-xl-4 col-lg-4 col-md-6 col-sm-12">
                <a class="text-decoration-none" href="./adminOrderBook.jsp">
                    <div class="card text-center card-custom p-4">
                        <div class="card-body">
                            <img src="https://cdn-icons-png.flaticon.com/512/3176/3176290.png" alt="Orders Icon">
                            <h4>Order Books</h4>
                            <p>Check and manage customer book orders</p>
                        </div>
                    </div>
                </a>
            </div>
        </div>
    </div>

</body>
</html>
<%
    }
%>
