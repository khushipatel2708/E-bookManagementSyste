<%@page import="java.util.List"%>
<%@page import="com.database.DBConnect"%>
<%@page import="com.detail.BookDetail"%>
<%@page import="com.dao.UserBookDAO"%>
<%
    UserBookDAO dao1 = new UserBookDAO(DBConnect.getConnection());
    List<BookDetail> bookList = dao1.getAllBooks();
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    <%@include file="./component/header.jsp" %>
    <title>Book Store</title>
    <style>
        /* Global Styles */
        body {
            background: #f3f6fb;
            font-family: 'Segoe UI', sans-serif;
            line-height: 1.6;
        }
        h2, h3, h4 {
            font-weight: 700;
        }

        /* Hero Slider */
        .slider-img {
            height: 500px;
            object-fit: cover;
            filter: brightness(0.85);
        }
        .carousel-caption {
            background: rgba(0, 0, 0, 0.35);
            backdrop-filter: blur(8px);
            padding: 20px 35px;
            border-radius: 15px;
            animation: fadeIn 2s ease-in-out;
        }
        .carousel-caption h2 {
            font-size: 2.2rem;
            font-weight: 700;
            color: #fff;
        }
        .carousel-caption p {
            color: #f8f9fa;
            font-size: 1.1rem;
        }

        /* Book Cards */
        .book-card {
            border-radius: 15px;
            overflow: hidden;
            transition: transform 0.4s ease, box-shadow 0.4s ease;
            background: white;
            border: none;
        }
        .book-card:hover {
            transform: translateY(-8px) scale(1.02);
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.12);
        }
        .book-img {
            height: 250px;
            object-fit: contain;
            background: linear-gradient(145deg, #eef2f7, #ffffff);
            padding: 10px;
        }

        /* Price */
        .card-body p {
            font-size: 1rem;
            font-weight: 600;
            color: #28a745;
        }

        /* Buttons */
        .btn-custom {
            border-radius: 50px;
            padding: 6px 18px;
            transition: all 0.3s ease;
            font-size: 0.85rem;
        }
        .btn-custom:hover {
            transform: translateY(-2px) scale(1.05);
        }

        /* Services Section */
        .service-box {
            background: white;
            border-radius: 14px;
            padding: 25px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 14px rgba(0, 0, 0, 0.05);
            text-align: center;
        }
        .service-box:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        }
        .service-box i {
            background: linear-gradient(45deg, #007bff, #6610f2);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        /* Quote Section */
        .quote-section {
            background: linear-gradient(90deg, #007bff, #6610f2);
            color: white;
            padding: 40px 20px;
            border-radius: 0 0 30px 30px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.15);
        }

        /* About Us */
        .about-img {
            border-radius: 15px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
        }

        /* Animations */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>
<%@include file="./component/navbar.jsp" %>

<!-- Hero Slider -->
<div id="mainCarousel" class="carousel slide" data-ride="carousel" data-interval="5000">
    <ol class="carousel-indicators">
        <li data-target="#mainCarousel" data-slide-to="0" class="active"></li>
        <li data-target="#mainCarousel" data-slide-to="1"></li>
        <li data-target="#mainCarousel" data-slide-to="2"></li>
    </ol>
    <div class="carousel-inner">
        <div class="carousel-item active">
            <img class="d-block w-100 slider-img" src="https://e0.pxfuel.com/wallpapers/88/99/desktop-wallpaper-candle-light-still-life-books.jpg" alt="First slide">
            <div class="carousel-caption">
                <h2>Welcome to CodeBook Store</h2>
                <p>Explore Coding, Learn Fast & Build Big!</p>
            </div>
        </div>
        <div class="carousel-item">
            <img class="d-block w-100 slider-img" src="https://wallpaperaccess.com/full/934067.jpg" alt="Second slide">
            <div class="carousel-caption">
                <h2>Top Programming Books</h2>
                <p>Java, Python, C++, Web Dev & More</p>
            </div>
        </div>
        <div class="carousel-item">
            <img class="d-block w-100 slider-img" src="https://images2.alphacoders.com/261/26102.jpg" alt="Third slide">
            <div class="carousel-caption">
                <h2>Become a Coding Pro</h2>
                <p>Step-by-Step Books to Boost Your Career</p>
            </div>
        </div>
    </div>
    <a class="carousel-control-prev" href="#mainCarousel" role="button" data-slide="prev">
        <span class="carousel-control-prev-icon"></span>
    </a>
    <a class="carousel-control-next" href="#mainCarousel" role="button" data-slide="next">
        <span class="carousel-control-next-icon"></span>
    </a>
</div>

<!-- Quote -->
<div class="quote-section text-center">
    <h4 class="mb-2">"Code is like humor. When you have to explain it, it’s bad."</h4>
    <p>– Cory House</p>
</div>

<!-- Featured Books -->
<div class="container my-5">
    <div class="text-center mb-4" data-aos="fade-up">
        <h3 class="text-dark font-weight-bold">📚 Featured Programming Books</h3>
        <hr class="w-25 mx-auto border-primary">
    </div>
    <div class="row">
        <%
            int count = 0;
            for (BookDetail bd : bookList) {
                if (count == 8) break;
                count++;
        %>
        <div class="col-xl-3 col-lg-4 col-md-6 mb-4" data-aos="zoom-in" data-aos-delay="<%= count * 100 %>">
            <div class="card book-card h-100 shadow-sm">
                <img src="<%= request.getContextPath() %>/BookImage?img=<%= bd.getPhoto() %>" class="card-img-top book-img" alt="Book">
                <div class="card-body d-flex flex-column">
                    <h6 class="card-title text-truncate font-weight-bold text-primary"><%= bd.getBookName() %></h6>
                    <p>₹<%= bd.getPrice() %></p>
                    <div class="mt-auto d-flex justify-content-between">
                        <a href="./viewBook.jsp?bookId=<%= bd.getId() %>" class="btn btn-outline-primary btn-sm btn-custom">View</a>
                        <button onclick="addCart(<%= bd.getId() %>)" class="btn btn-success btn-sm btn-custom">
                            <i class="fas fa-cart-plus"></i>
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <% } %>
    </div>
    <div class="text-center mt-3" data-aos="fade-up">
        <a href="allBooks.jsp" class="btn btn-outline-primary btn-lg px-4 btn-custom">Show More Books</a>
    </div>
</div>

<!-- Services -->
<div class="container py-5">
    <div class="text-center mb-4" data-aos="fade-right">
        <h2>📦 Our Services</h2>
        <hr class="w-25 mx-auto border-primary">
    </div>
    <div class="row">
        <div class="col-md-4 mb-4" data-aos="zoom-in">
            <div class="service-box">
                <i class="fas fa-shipping-fast fa-2x mb-3"></i>
                <h5>Fast Delivery</h5>
                <p class="text-muted">Get your coding books delivered in 2-4 days across India.</p>
            </div>
        </div>
        <div class="col-md-4 mb-4" data-aos="zoom-in">
            <div class="service-box">
                <i class="fas fa-book-reader fa-2x mb-3"></i>
                <h5>Top-Rated Authors</h5>
                <p class="text-muted">We only list books from the best authors in software & IT fields.</p>
            </div>
        </div>
        <div class="col-md-4 mb-4" data-aos="zoom-in">
            <div class="service-box">
                <i class="fas fa-sync-alt fa-2x mb-3"></i>
                <h5>Easy Return</h5>
                <p class="text-muted">7-day return policy on all physical book orders.</p>
            </div>
        </div>
    </div>
</div>

<!-- About Us -->
<section class="py-5" style="background-color: #f8f9fa;">
    <div class="container">
        <div class="row align-items-center">
            <!-- Image -->
            <div class="col-md-5 mb-4 mb-md-0">
                <img src="https://assets.vogue.com/photos/594830328ba2821cdbcb950f/master/w_1600,c_limit/01-best-new-york-city-bookstores.jpg" alt="About Our Bookstore" class="img-fluid about-img">
            </div>
            <!-- Text -->
            <div class="col-md-7">
                <h2 class="mb-3">About Us</h2>
                <p style="font-size: 1.1rem;">
                    Welcome to <strong>ReadEase Bookstore</strong> — your cozy corner for stories, knowledge, and imagination.  
                    From timeless classics to the latest bestsellers, we curate every book with love for our readers.
                </p>
                <p style="font-size: 1.1rem;">
                    Whether you're looking for your next adventure, a thoughtful gift, or just a quiet place to browse,  
                    we’re here to make every page turn unforgettable.
                </p>
                <a href="Aboutus.jsp" class="btn btn-primary mt-3">Learn More</a>
            </div>
        </div>
    </div>
</section>

<!-- Scripts -->
<script>
    $("#searchBook").attr("action", "./allBooks.jsp");
    $("#searchBook2").attr("action", "./allBooks.jsp");
</script>
<script src="js/addCart.js" type="text/javascript"></script>
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<script>
    AOS.init({ duration: 1000, offset: 100 });
</script>
</body>
</html>
