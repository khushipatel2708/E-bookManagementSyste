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
        :root {
            --primary-color: #5d5dff;
            --secondary-color: #8a8aff;
            --bg-color: #f0f4f8;
            --card-bg: #ffffff;
            --text-dark: #2c3e50;
            --text-muted: #7f8c8d;
            --border-color: #ecf0f1;
            --shadow-light: rgba(0, 0, 0, 0.08);
            --shadow-hover: rgba(0, 0, 0, 0.15);
        }

        body {
            background-color: var(--bg-color);
            font-family: 'Poppins', sans-serif;
            color: var(--text-dark);
        }

        .container {
            max-width: 1320px;
        }

        /* Search box */
        .search-box {
            background: var(--card-bg);
            padding: 12px 24px;
            border-radius: 50px;
            box-shadow: 0 4px 15px var(--shadow-light);
            margin-bottom: 40px;
            transition: box-shadow 0.3s ease;
        }
        .search-box input {
            border: none;
            outline: none;
            width: 100%;
            font-size: 1rem;
            color: var(--text-dark);
            background: transparent;
        }
        .search-box input::placeholder {
            color: var(--text-muted);
        }
        .search-box:focus-within {
            box-shadow: 0 8px 25px var(--shadow-hover);
        }

        /* Category sidebar */
        .category-nav {
            position: sticky;
            top: 90px;
            background: var(--card-bg);
            padding: 24px;
            border-radius: 20px;
            box-shadow: 0 4px 15px var(--shadow-light);
        }
        .category-nav h5 {
            font-weight: 700;
            margin-bottom: 20px;
            color: var(--primary-color);
            font-size: 1.25rem;
            border-bottom: 2px solid var(--border-color);
            padding-bottom: 15px;
        }
        .category-nav a {
            display: flex;
            align-items: center;
            padding: 12px 15px;
            color: var(--text-dark);
            font-weight: 500;
            border-radius: 12px;
            margin-bottom: 8px;
            transition: background 0.25s ease, color 0.25s ease;
            text-decoration: none;
        }
        .category-nav a:hover {
            background-color: var(--primary-color);
            color: var(--card-bg);
        }
        .category-nav a:hover i {
            color: var(--card-bg);
        }
        .category-nav i {
            margin-right: 12px;
            font-size: 1rem;
            color: var(--primary-color);
            transition: color 0.25s ease;
        }

        /* Category title */
        .category-title {
            margin-top: 50px;
            margin-bottom: 30px;
            font-weight: 700;
            font-size: 2rem;
            color: var(--primary-color);
            border-left: 6px solid var(--primary-color);
            padding-left: 1rem;
        }

        /* Book card */
        .book-card {
            background: var(--card-bg);
            border-radius: 20px;
            overflow: hidden;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            height: 100%;
            border: none;
            display: flex;
            flex-direction: column;
        }
        .book-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 12px 30px var(--shadow-hover);
        }
        .book-img-container {
            position: relative;
            background: linear-gradient(135deg, var(--bg-color), #ffffff);
            padding: 20px;
            height: 250px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-bottom: 1px solid var(--border-color);
        }
        .book-img {
            height: 100%;
            width: auto;
            object-fit: contain;
            transition: transform 0.3s ease;
        }
        .book-card:hover .book-img {
            transform: scale(1.08);
        }

        .book-card .card-body {
            padding: 20px;
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;
            flex-grow: 1; /* Allow card body to take up remaining space */
        }
        .book-info {
            width: 100%;
            display: flex;
            justify-content: space-between;
            align-items: baseline;
            padding: 0 10px;
        }
        .book-info .card-title {
            font-size: 1.15rem;
            font-weight: 600;
            color: var(--primary-color);
            margin: 0;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            max-width: 60%;
        }
        .book-info .card-subtitle {
            font-size: 0.9rem;
            color: var(--text-muted);
            margin: 0;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            max-width: 40%;
            text-align: right;
        }

        .price-badge {
            font-weight: 700;
            font-size: 1.5rem;
            color: #2ecc71;
            margin-bottom: 15px;
        }

        /* This is the new, more professional button group layout */
        .btn-group-actions {
            margin-top: auto; /* Push to the bottom of the card */
            width: 100%;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .btn-group-actions .btn {
            border-radius: 50px;
            font-weight: 600;
            transition: all 0.3s ease;
            text-decoration: none;
            flex-grow: 1;
            margin: 0 5px;
        }
        .btn-group-actions .btn-view {
            color: var(--primary-color);
            border-color: var(--primary-color);
            background-color: transparent;
            width: 70%;
        }
        .btn-group-actions .btn-view:hover {
            background-color: var(--primary-color);
            color: var(--card-bg);
        }
        .btn-group-actions .btn-cart {
            background-color: #28a745;
            color: white;
            border-color: #28a745;
            width: 30%;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .btn-group-actions .btn-cart:hover {
            background-color: #218838;
        }

        /* Availability badge */
        .availability-badge {
            position: absolute;
            top: 15px;
            right: 15px;
            z-index: 10;
            font-size: 0.75rem;
            padding: 6px 12px;
            border-radius: 20px;
            font-weight: 600;
            color: white;
        }
        .availability-badge.bg-success {
            background-color: #2ecc71 !important;
        }
        .availability-badge.bg-danger {
            background-color: #e74c3c !important;
        }
    </style>
</head>
<body>
<%@include file="./component/navbar.jsp" %>

<div class="container my-5">
    <div class="search-box">
        <input type="text" id="bookSearch" placeholder="🔍 Search books by name or author...">
    </div>

    <div class="row">
        <div class="col-lg-3 col-md-4 mb-4">
            <div class="category-nav shadow-sm">
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

        <div class="col-lg-9 col-md-8">
            <%
                if (groupedBooks == null || groupedBooks.isEmpty()) {
            %>
                <div class="text-center text-muted py-5">
                    <h4 class="fw-bold">No books found.</h4>
                    <p>Please check back later or try a different search.</p>
                </div>
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
                        <div class="col-lg-4 col-md-6 col-sm-6 mb-4 book-item"
                             data-title="<%= bd.getBookName().toLowerCase() %>"
                             data-author="<%= bd.getAuthorName().toLowerCase() %>">
                            <div class="card book-card h-100" data-aos="fade-up" data-aos-delay="<%= count * 100 %>">
                                <div class="book-img-container">
                                    <img src="<%= request.getContextPath() %>/BookImage?img=<%= bd.getPhoto() %>"
                                         class="book-img"
                                         alt="Book Cover">
                                    <span class="availability-badge <%= bd.getAvailable() > 0 ? "bg-success" : "bg-danger" %>">
                                        <%= bd.getAvailable() > 0 ? "Available" : "Out of Stock" %>
                                    </span>
                                </div>
                                <div class="card-body">
                                    <div class="book-info">
                                        <h4 class="card-title" title="<%= bd.getBookName() %>">
                                            <%= bd.getBookName() %>
                                        </h4>
                                        <p class="card-subtitle"><small>by <%= bd.getAuthorName() %></small></p>
                                    </div>
                                    <p class="price-badge">₹<%= bd.getPrice() %></p>
                                    <div class="btn-group-actions">
                                        <a href="./viewBook.jsp?bookId=<%= bd.getId() %>"
                                           class="btn btn-sm btn-outline-primary btn-view">
                                            View
                                        </a>
                                        <button onclick="addCart(<%= bd.getId() %>)"
                                                class="btn btn-sm btn-success btn-cart">
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
    AOS.init({ duration: 1000, once: true });

    // Live Search
    document.getElementById('bookSearch').addEventListener('input', function () {
        let searchValue = this.value.toLowerCase();
        document.querySelectorAll('.book-item').forEach(function (item) {
            let title = item.dataset.title;
            let author = item.dataset.author;
            item.style.display = (title.includes(searchValue) || author.includes(searchValue)) ? '' : 'none';
        });
    });
</script>
</body>
</html>