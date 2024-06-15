<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All Items</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f8f9fa;
        }
        .navbar {
            background-color: #14397d;
        }
        .navbar .logo {
            color: #d7eaf3;
            font-size: 30px;
        }
        .navbar-nav .nav-link {
            color: #d7eaf3;
            margin-right: 15px;
        }
        .navbar-nav .nav-link:hover, .navbar-nav .nav-link:focus {
            color: #77b5d9;
        }
        .sidebar {
            background-color: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .card {
            margin-bottom: 20px;
        }
        .card-header {
            background-color: white;
            border-bottom: none;
        }
        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
        }
        .btn-primary:hover, .btn-primary:focus {
            background-color: #0056b3;
            border-color: #0056b3;
        }
        .btn-secondary {
            background-color: #6c757d;
            border-color: #6c757d;
        }
        .btn-secondary:hover, .btn-secondary:focus {
            background-color: #5a6268;
            border-color: #545b62;
        }
    </style>
</head>
<body>

<jsp:include page="header.jsp"/>

<div class="container mt-5">
    <div class="row">
        <!-- Sidebar Filter -->
        <div class="col-md-3">
            <div class="sidebar">
                <h4>Search Filter</h4>
                <form method="get" action="all-items.jsp">
                    <div class="form-group">
                        <h5>Select Category</h5>
                        <c:forEach var="category" items="${categories}">
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" name="category" value="${category}" id="category${category}">
                                <label class="form-check-label" for="category${category}">
                                    <c:out value="${category}"/>
                                </label>
                            </div>
                        </c:forEach>
                    </div>
                    <button type="submit" class="btn btn-primary btn-block">Search</button>
                </form>
            </div>
        </div>

        <!-- Items Display -->
        <div class="col-md-9">
            <c:forEach var="item" items="${items}">
                <div class="card">
                    <div class="row no-gutters">
                        <div class="col-md-4">
                            <img src="<c:out value='${item.imageUrl}' />" class="card-img" alt="<c:out value='${item.name}' />">
                        </div>
                        <div class="col-md-8">
                            <div class="card-body">
                                <h5 class="card-title"><c:out value="${item.name}" /></h5>
                                <p class="card-text"><c:out value="${item.description}" /></p>
                                <p class="card-text"><small class="text-muted"><c:out value="${item.location}" /></small></p>
                                <a href="<c:url value='/item-details.jsp?id=${item.id}' />" class="btn btn-primary">View Profile</a>
                                <a href="<c:url value='/book-appointment.jsp?id=${item.id}' />" class="btn btn-secondary">Book Appointment</a>
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