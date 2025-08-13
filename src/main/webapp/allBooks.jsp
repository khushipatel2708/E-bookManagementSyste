<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="com.database.DBConnect"%>
<%@page import="com.detail.BookDetail"%>
<%@page import="com.dao.UserBookDAO"%>
<%
    UserBookDAO dao1 = new UserBookDAO(DBConnect.getConnection());
    Map<String, List<BookDetail>> groupedBooks = dao1.getBooksGroupedByCategory();
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    <%@include file="./component/header.jsp" %>
    <title>Books by Category</title>
    <style>
        body {
            background: #f4f6f9;
            font-family: 'Segoe UI', sans-serif;
        }

        /* Search box */
        .search-box {
            background: #fff;
            padding: 14px 20px;
            border-radius: 50px;
            box-shadow: 0 3px 12px rgba(0,0,0,0.08);
            margin-bottom: 30px;
            transition: 0.3s ease;
        }
        .search-box input {
            border: none;
            outline: none;
            width: 100%;
            font-size: 16px;
            background: transparent;
        }
        .search-box:focus-within {
            box-shadow: 0 5px 18px rgba(0,0,0,0.12);
        }

        /* Category sidebar */
        .category-nav {
            position: sticky;
            top: 90px;
            background: linear-gradient(145deg, #ffffff, #f0f4ff);
            padding: 20px;
            border-radius: 15px;
            box-shadow: 0 4px 14px rgba(0,0,0,0.06);
        }
        .category-nav h5 {
            font-weight: 700;
            margin-bottom: 15px;
            color: #0d6efd;
        }
        .category-nav a {
            display: flex;
            align-items: center;
            padding: 8px 12px;
            color: #333;
            font-weight: 500;
            border-radius: 8px;
            margin-bottom: 6px;
            transition: background 0.25s ease, color 0.25s ease;
            text-decoration: none;
        }
        .category-nav a:hover {
            background: #eaf2ff;
            color: #0d6efd;
        }
        .category-nav i {
            margin-right: 8px;
            color: #0d6efd;
        }

        /* Category title */
        .category-title {
            margin-top: 50px;
            margin-bottom: 25px;
            padding-left: 12px;
            font-weight: 700;
            font-size: 24px;
            color: #0d6efd;
            border-left: 5px solid #0d6efd;
        }

        /* Book card */
        .book-card {
            background: linear-gradient(135deg, #ffffff, #f8faff);
            border-radius: 14px;
            overflow: hidden;
            transition: transform 0.25s ease, box-shadow 0.25s ease;
            height: 100%;
        }
        .book-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 24px rgba(0,0,0,0.12);
        }
        .book-img {
            height: 230px;
            object-fit: contain;
            padding: 15px;
            background: linear-gradient(135deg, #f0f4ff, #ffffff);
            transition: transform 0.3s ease;
        }
        .book-card:hover .book-img {
            transform: scale(1.05);
        }

        .badge-available {
            background: #28a745;
            color: white;
            font-size: 12px;
            padding: 4px 8px;
            border-radius: 20px;
        }
        .badge-out {
            background: #dc3545;
            color: white;
            font-size: 12px;
            padding: 4px 8px;
            border-radius: 20px;
        }
    </style>
</head>
<body>
<%@include file="./component/navbar.jsp" %>

<div class="container my-5">
    <!-- Search Bar -->
    <div class="search-box">
        <input type="text" id="bookSearch" placeholder="🔍 Search books by name or author...">
    </div>

    <div class="row">
        <!-- Sidebar -->
        <div class="col-lg-3 mb-4">
            <div class="category-nav">
                <h5>📂 Categories</h5>
                <%
                    for (String category : groupedBooks.keySet()) {
                %>
                    <a href="#cat-<%= category.replaceAll("\\s+", "-") %>">
                        <i class="fas fa-book"></i> <%= category %>
                    </a>
                <%
                    }
                %>
            </div>
        </div>

        <!-- Book List -->
        <div class="col-lg-9">
            <%
                if (groupedBooks == null || groupedBooks.isEmpty()) {
            %>
                <div class="text-center text-muted">No books available.</div>
            <%
                } else {
                    for (Map.Entry<String, List<BookDetail>> entry : groupedBooks.entrySet()) {
                        String bookCategory = entry.getKey();
                        List<BookDetail> books = entry.getValue();
            %>
                <h2 id="cat-<%= bookCategory.replaceAll("\\s+", "-") %>" class="category-title" data-aos="fade-right">
                    📚 <%= bookCategory %>
                </h2>
                <div class="row">
                    <%
                        int count = 0;
                        for (BookDetail bd : books) {
                            count++;
                    %>
                        <div class="col-md-4 col-sm-6 mb-4 book-item" 
                             data-title="<%= bd.getBookName().toLowerCase() %>" 
                             data-author="<%= bd.getAuthorName().toLowerCase() %>">
                            <div class="card book-card border-0 h-100" data-aos="fade-up" data-aos-delay="<%= count * 100 %>">
                                <img src="<%= request.getContextPath() %>/BookImage?img=<%= bd.getPhoto() %>" class="card-img-top book-img" alt="Book">
                                <div class="card-body d-flex flex-column">
                                    <h6 class="card-title font-weight-bold text-primary"><%= bd.getBookName() %></h6>
                                    <p class="text-muted mb-1"><small>by <%= bd.getAuthorName() %></small></p>
                                    <p class="text-muted mb-2">₹<%= bd.getPrice() %></p>
                                    <span class="<%= bd.getAvailable() > 0 ? "badge-available" : "badge-out" %>">
                                        <%= bd.getAvailable() > 0 ? "Available" : "Out of Stock" %>
                                    </span>
                                    <div class="mt-auto d-flex justify-content-between pt-3">
                                        <a href="./viewBook.jsp?bookId=<%= bd.getId() %>" class="btn btn-sm btn-outline-primary">View</a>
                                        <button onclick="addCart(<%= bd.getId() %>)" class="btn btn-sm btn-success">
                                            <i class="fas fa-cart-plus"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    <% } %>
                </div>
            <% 
                    }
                }
            %>
        </div>
    </div>
</div>

<script src="js/addCart.js" type="text/javascript"></script>
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<script>
    AOS.init({ duration: 1000, offset: 100 });

    // Live Search
    document.getElementById('bookSearch').addEventListener('input', function() {
        let searchValue = this.value.toLowerCase();
        document.querySelectorAll('.book-item').forEach(function(item) {
            let title = item.dataset.title;
            let author = item.dataset.author;
            item.style.display = (title.includes(searchValue) || author.includes(searchValue)) ? '' : 'none';
        });
    });
</script>
</body>
</html>
