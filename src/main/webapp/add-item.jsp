<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add New Item</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="<c:url value='/css/style.css' />">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #d7eaf3;
        }
        .sidebar {
            position: fixed;
            top: 56px;
            left: 0;
            width: 200px;
            height: 100%;
            background-color: #14397d;
            padding-top: 20px;
            border-right: 1px solid #dee2e6;
        }
        .sidebar a {
            display: block;
            color: #ffffff;
            padding: 10px;
            text-decoration: none;
        }
        .sidebar a:hover {
            background-color: #ffffff;
            color: #14397d;
        }
        .main-content {
            margin-left: 210px;
            padding: 20px;
        }
    </style>
</head>
<body>

<jsp:include page="header.jsp" />

<!-- Sidebar -->
<div class="sidebar">
    <a href="<c:url value='/user-dashboard.jsp' />">Dashboard</a>
    <a href="<c:url value='/my-items.jsp' />">My Items</a>
    <a href="<c:url value='/add-item.jsp' />">Add Item</a>
    <a href="<c:url value='/exchanged-items.jsp' />">Exchanged Items</a>
    <a href="<c:url value='/pending-requests.jsp' />">Pending Requests</a>
    <a href="<c:url value='/edit-profile.jsp' />">Edit Profile</a>
    <a href="<c:url value='/logout' />">Logout</a>
</div>

<!-- Main Content -->
<div class="main-content">
    <div class="container">
        <div class="card">
            <div class="card-header bg-primary text-white">
                <h2>Add New Item</h2>
            </div>
            <div class="card-body">
                <form action="<c:url value='/additem' />" method="post" enctype="multipart/form-data">
                    <div class="form-group">
                        <label for="name">Item Name:</label>
                        <input type="text" class="form-control" id="name" name="name" required>
                    </div>
                    <div class="form-group">
                        <label for="description">Description:</label>
                        <textarea class="form-control" id="description" name="description" rows="3" required></textarea>
                    </div>
                    <div class="form-group">
                        <label for="category">Category:</label>
                        <select class="form-control" id="category" name="category" required>
                            <option value="" disabled selected>Select Category</option>
                            <option value="electronics">Electronics</option>
                            <option value="clothing">Clothing</option>
                            <option value="furniture">Furniture</option>
                            <option value="vehicles">Vehicles</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="condition">Condition:</label>
                        <select class="form-control" id="condition" name="condition" required>
                            <option value="" disabled selected>Select Condition</option>
                            <option value="new">New</option>
                            <option value="used">Used</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="location">Location:</label>
                        <input type="text" class="form-control" id="location" name="location" required>
                    </div>
                    <div class="form-group">
                        <label for="exchangePreferences">Exchange Preferences:</label>
                        <textarea class="form-control" id="exchangePreferences" name="exchangePreferences" rows="2"></textarea>
                    </div>
                    <div class="form-group">
                        <label for="quantity">Quantity:</label>
                        <input type="number" class="form-control" id="quantity" name="quantity" required>
                    </div>
                    <div class="form-group">
                        <label for="image">Image:</label>
                        <input type="file" class="form-control-file" id="image" name="image" required>
                    </div>
                    <input type="hidden" name="userId" value="${sessionScope.user.id}">
                    <button type="submit" class="btn btn-primary">Add Item</button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Footer -->
<footer class="footer">
    <jsp:include page="footer.jsp" />
</footer>

<!-- Bootstrap JS, Popper.js, and jQuery -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>