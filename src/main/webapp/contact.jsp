<%@page import="com.javaclass.Email" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <%@include file="./component/header.jsp" %>
    <title>Contact Us | Book Store</title>
    <!-- SweetAlert2 -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <!-- FontAwesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body {
            background: linear-gradient(120deg, #e3f2fd, #e1bee7);
        }
        .contact-header {
            background: linear-gradient(90deg, #303f9f, #4a57d1);
            color: white;
            padding: 60px 20px;
        }
        .contact-section {
            padding: 60px 20px;
        }
        .contact-card {
            background: rgba(255, 255, 255, 0.8);
            border-radius: 15px;
            padding: 30px;
            backdrop-filter: blur(10px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            text-align: center;
        }
        .contact-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 12px 35px rgba(0,0,0,0.2);
        }
        .contact-icon {
            font-size: 45px;
            color: #4a57d1;
            margin-bottom: 15px;
            transition: transform 0.3s;
        }
        .contact-card:hover .contact-icon {
            transform: scale(1.2);
            color: #303f9f;
        }
        .contact-title {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 5px;
        }
        .contact-info {
            color: #555;
            font-size: 16px;
        }
        .contact-form {
            background: rgba(255, 255, 255, 0.95);
            padding: 40px;
            border-radius: 15px;
            backdrop-filter: blur(10px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        }
        .btn-send {
            background: linear-gradient(90deg, #303f9f, #4a57d1);
            color: white;
            font-weight: bold;
            border: none;
            padding: 10px 25px;
            border-radius: 50px;
            transition: all 0.3s ease;
        }
        .btn-send:hover {
            box-shadow: 0 0 15px #4a57d1;
            transform: translateY(-2px);
        }
    </style>
</head>
<body>
<%@include file="./component/navbar.jsp" %>

<!-- Header -->
<div class="contact-header text-center">
    <h2>📞 Get in Touch</h2>
    <p>Your questions, feedback, and ideas make us better. Let’s connect!</p>
</div>

<!-- Contact Info -->
<section class="contact-section">
    <div class="container">
        <div class="row g-4 mb-5">
            <div class="col-md-4">
                <div class="contact-card">
                    <i class="fas fa-phone-alt contact-icon"></i>
                    <div class="contact-title">Phone</div>
                    <div class="contact-info">
                        <a href="tel:+919876543215" style="text-decoration:none; color:inherit;">+91 98765 43215</a>
                        <br><small>24x7 Support</small>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="contact-card">
                    <i class="fas fa-envelope contact-icon"></i>
                    <div class="contact-title">Email</div>
                    <div class="contact-info">
                        <a href="mailto:book@store.com" style="text-decoration:none; color:inherit;">book@store.com</a>
                        <br><small>Reply within 24 hours</small>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="contact-card">
                    <i class="fas fa-map-marker-alt contact-icon"></i>
                    <div class="contact-title">Address</div>
                    <div class="contact-info">
                        Book Store <br>
                        Near Amar Ujala, Meerut, 250002
                    </div>
                </div>
            </div>
        </div>

        <!-- Contact Form -->
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="contact-form">
                    <h4 class="text-center mb-4">Send Us a Message</h4>
                    <form method="post">
                        <div class="mb-3">
                            <label class="form-label">Your Name</label>
                            <input type="text" name="name" class="form-control" placeholder="Enter your name" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Your Email</label>
                            <input type="email" name="email" class="form-control" placeholder="Enter your email" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Message</label>
                            <textarea name="message" rows="4" class="form-control" placeholder="Write your message here..." required></textarea>
                        </div>
                        <div class="text-center">
                            <button type="submit" class="btn btn-send">Send Message <i class="fas fa-paper-plane ms-1"></i></button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</section>

<%
    String name = request.getParameter("name");
    String userEmail = request.getParameter("email");
    String message = request.getParameter("message");

    if (name != null && userEmail != null && message != null) {
        if (!name.trim().isEmpty() && !userEmail.trim().isEmpty() && !message.trim().isEmpty()) {
            try {
                String subject = "📩 New Contact Form Submission - Book Store";
                String body = "Name: " + name + "\nEmail: " + userEmail + "\nMessage: " + message;
                new Thread(new Email("bookingonline40@gmail.com", subject, body)).start();
%>
<script>
    Swal.fire({
        icon: 'success',
        title: 'Message Sent!',
        text: 'Thank you for contacting us. We will get back to you soon.',
        confirmButtonColor: '#303f9f'
    });
</script>
<%
            } catch (Exception e) {
%>
<script>
    Swal.fire({
        icon: 'error',
        title: 'Oops!',
        text: 'Something went wrong. Please try again later.',
        confirmButtonColor: '#d33'
    });
</script>
<%
            }
        } else {
%>
<script>
    Swal.fire({
        icon: 'warning',
        title: 'Missing Fields',
        text: 'Please fill out all fields before submitting.',
        confirmButtonColor: '#f39c12'
    });
</script>
<%
        }
    }
%>
</body>
</html>
