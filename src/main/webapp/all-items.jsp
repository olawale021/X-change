<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All Items - MangoEx</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f8f9fa;
            color: #333;
        }
        .navbar {
            background-color: #14397d;
            box-shadow: 0 2px 4px rgba(0,0,0,.1);
        }
        .navbar .logo {
            color: #ffffff;
            font-size: 24px;
            font-weight: bold;
        }
        .navbar-nav .nav-link {
            color: #ffffff;
            margin-right: 15px;
            transition: color 0.3s ease;
        }
        .navbar-nav .nav-link:hover, .navbar-nav .nav-link:focus {
            color: #ffd700;
        }
        .sidebar {
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
        }
        .card {
            margin-bottom: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
        }
        .card-body {
            padding: 20px;
        }
        .item-widget {
            display: flex;
            align-items: flex-start;
            gap: 20px;
        }
        .item-img {
            flex: 1;
            max-width: 200px;
        }
        .item-img img {
            width: 100%;
            height: 200px;
            object-fit: cover;
            border-radius: 8px;
        }
        .item-details {
            flex: 2;
        }
        .item-booking {
            flex: 1;
            text-align: right;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }
        .item-name {
            font-size: 22px;
            font-weight: bold;
            margin-bottom: 10px;
            color: #14397d;
        }
        .item-name a {
            color: #14397d;
            text-decoration: none;
            transition: color 0.3s ease;
        }
        .item-name a:hover {
            color: #0056b3;
        }
        .item-description {
            font-size: 16px;
            margin-bottom: 10px;
            color: #555;
        }
        .item-category {
            font-size: 14px;
            color: #6c757d;
            margin-bottom: 10px;
        }
        .rating {
            margin-bottom: 10px;
        }
        .rating .fas {
            color: #ffc107;
        }
        .detail-section {
            margin-bottom: 15px;
        }
        .detail-section strong {
            display: block;
            margin-bottom: 5px;
            font-size: 14px;
            color: #14397d;
        }
        .btn-view-item {
            background-color: #14397d !important;
            border-color: #14397d !important;
            color: white !important;
            padding: 10px 20px;
            font-size: 16px;
            font-weight: 500;
            border-radius: 8px;
            transition: all 0.3s ease;
        }
        .btn-view-item:hover, .btn-view-item:focus {
            background-color: #0e2b5c !important;
            border-color: #0e2b5c !important;
            transform: translateY(-2px);
        }
        .info-item {
            display: flex;
            align-items: center;
            font-size: 14px;
            color: #6c757d;
            margin-bottom: 10px;
        }
        .info-item i {
            margin-right: 8px;
            color: #14397d;
        }
        .search-filter h4 {
            color: #14397d;
            margin-bottom: 20px;
        }
        .form-check-label {
            cursor: pointer;
        }
        .btn-primary {
            background-color: #14397d;
            border-color: #14397d;
            transition: all 0.3s ease;
        }
        .btn-primary:hover {
            background-color: #0e2b5c;
            border-color: #0e2b5c;
        }
    </style>
</head>
<body>

<jsp:include page="header.jsp"/>

<div class="container mt-5">
    <div class="row">
        <!-- Sidebar Filter -->
        <div class="col-md-3 mb-4">
            <div class="sidebar">
                <div class="search-filter">
                    <h4>Search Filter</h4>
                    <form method="get" action="all-items">
                        <div class="form-group">
                            <h5>Select Category</h5>
                            <c:forEach var="category" items="${categories}">
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" name="category" value="${category.id}" id="category${category.id}">
                                    <label class="form-check-label" for="category${category.id}">
                                        <c:out value="${category.name}"/>
                                    </label>
                                </div>
                            </c:forEach>
                        </div>
                        <button type="submit" class="btn btn-primary btn-block">Search</button>
                    </form>
                </div>
            </div>
        </div>

        <!-- Items Display -->
        <div class="col-md-9">
            <c:forEach var="item" items="${items}">
                <div class="card">
                    <div class="card-body">
                        <div class="item-widget">
                            <div class="item-img">
                                <a href="<c:url value='/item-detail?id=${item.id}' />">
                                    <img src="<c:out value='${item.firstPhotoUrl}' />" class="img-fluid" alt="<c:out value='${item.title}' />">
                                </a>
                            </div>
                            <div class="item-details">
                                <h4 class="item-name"><a href="<c:url value='/item-detail?id=${item.id}' />"><c:out value="${item.title}" /></a></h4>

                                <div class="detail-section">
                                    <strong>Description:</strong>
                                    <p class="item-description"><c:out value="${item.description}" /></p>
                                </div>

                                <div class="detail-section">
                                    <strong>Category:</strong>
                                    <h5 class="item-category"><c:out value="${item.categoryName}" /></h5>
                                </div>

                                <div class="detail-section">
                                    <strong>Rating:</strong>
                                    <div class="rating">
                                        <i class="fas fa-star filled"></i>
                                        <i class="fas fa-star filled"></i>
                                        <i class="fas fa-star filled"></i>
                                        <i class="fas fa-star"></i>
                                        <span class="d-inline-block average-rating">(<c:out value="80" />)</span>
                                    </div>
                                </div>
                            </div>
                            <div class="item-booking">
                                <a class="btn btn-view-item" href="<c:url value='/item-detail?id=${item.id}' />">View Item</a>
                                <div class="detail-section">
                                    <strong>Condition:</strong>
                                    <div class="info-item">
                                        <i class="far fa-check-circle"></i>
                                        <c:out value="${item.condition}" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp"/>

<!-- Bootstrap JS, Popper.js, and jQuery -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>