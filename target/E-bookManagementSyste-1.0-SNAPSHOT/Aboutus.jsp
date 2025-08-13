<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us - Book Management</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <%@include file="./component/header.jsp" %>
    <style>
        body {
            background-color: #f9f9f9;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .about-header {
            background: linear-gradient(135deg, #6a11cb, #2575fc);
            color: white;
            padding: 60px 20px;
            text-align: center;
        }
        .about-header h1 {
            font-weight: bold;
            font-size: 2.5rem;
        }
        .about-section {
            padding: 60px 20px;
        }
        .about-section h2 {
            font-weight: bold;
            margin-bottom: 20px;
        }
        .about-section p {
            font-size: 1.1rem;
            line-height: 1.8;
            color: #555;
        }
        .map-container {
            position: relative;
            overflow: hidden;
            border-radius: 15px;
            box-shadow: 0px 4px 15px rgba(0,0,0,0.2);
        }
        .map-container iframe {
            border: 0;
            width: 100%;
            height: 400px;
        }
        .team-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            padding: 20px;
            text-align: center;
            transition: transform 0.3s;
        }
        .team-card:hover {
            transform: translateY(-10px);
        }
        .team-card img {
            border-radius: 50%;
            width: 100px;
            margin-bottom: 15px;
        }
    </style>
</head>
<body>
<%@include file="./component/navbar.jsp" %>
    <!-- Header Section -->
    <div class="about-header">
        <h1>About Us</h1>
        <p>Connecting Readers with the Books They Love 📚</p>
    </div>

    <!-- About Content -->
    <div class="container about-section">
        <div class="row">
            <div class="col-md-6">
                <h2>Our Story</h2>
                <p>Welcome to our Book Management System — your one-stop solution for exploring, managing, and sharing your favorite books. We aim to make book discovery seamless and enjoyable for every reader. Our platform helps you explore a wide variety of books, track your reading list, and connect with fellow book lovers.</p>
            </div>
            <div class="col-md-6">
                <img src="https://images.unsplash.com/photo-1512820790803-83ca734da794" alt="Library" class="img-fluid rounded shadow">
            </div>
        </div>
    </div>

    <!-- Team Section -->
    <div class="container about-section">
        <h2 class="text-center mb-4">Meet Our Team</h2>
        <div class="row">
            <div class="col-md-4">
                <div class="team-card">
                    <img src="https://randomuser.me/api/portraits/men/45.jpg" alt="Team Member">
                    <h5>John Smith</h5>
                    <p>Founder & CEO</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="team-card">
                    <img src="https://randomuser.me/api/portraits/women/50.jpg" alt="Team Member">
                    <h5>Emma Johnson</h5>
                    <p>Lead Developer</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="team-card">
                    <img src="https://randomuser.me/api/portraits/men/60.jpg" alt="Team Member">
                    <h5>Michael Lee</h5>
                    <p>UI/UX Designer</p>
                </div>
            </div>
        </div>
    </div>

    <!-- Google Map -->
    <div class="container about-section">
        <h2 class="text-center mb-4">Our Location</h2>
        <div class="map-container">
            <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3153.04620776937!2d-122.40136338468163!3d37.79361717975644!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x80858064f1e9b3a3%3A0x9c5a17cbde3d42e5!2sGoogle%20San%20Francisco!5e0!3m2!1sen!2sus!4v1677068230190!5m2!1sen!2sus" allowfullscreen="" loading="lazy"></iframe>
        </div>
    </div>

</body>
</html>
