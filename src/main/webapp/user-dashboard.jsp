<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Dashboard</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="<c:url value='/css/style.css' />">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
        }
        .navbar-brand {
            font-size: 30px;
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
        .card-header {
            background-color: #007bff;
            color: white;
        }
        .footer {
            background-color: #343a40;
            color: white;
            padding: 20px 0;
        }
        .footer a {
            color: white;
            margin: 0 10px;
        }
        .footer a:hover {
            color: #007bff;
        }
    </style>
</head>
<body>

<jsp:include page="header.jsp"/>

<!-- Sidebar -->
<div class="sidebar">
    <a href="<c:url value='/dashboard.jsp' />">Dashboard</a>
    <a href="<c:url value='/my-items.jsp' />">My Items</a>
    <a href="<c:url value='/add-item.jsp' />">Add Item</a>
    <a href="<c:url value='/exchanged-items.jsp' />">Exchanged Items</a>
    <a href="<c:url value='/pending-requests.jsp' />">Pending Requests</a>
    <a href="<c:url value='/edit-profile.jsp' />">Edit Profile</a>
    <a href="<c:url value='/logout' />">Logout</a>
</div>

<!-- Main Content -->
<div class="main-content">
    <div class="container mt-5">
        <div class="row">
            <!-- Items Listed Card -->
            <div class="col-md-4 mb-4">
                <div class="card">
                    <div class="card-header">
                        Items Listed
                    </div>
                    <div class="card-body">
                        <p class="card-text">You have <c:out value="${itemsListedCount}" /> items listed for exchange.</p>
                        <a href="<c:url value='/my-items.jsp' />" class="btn btn-primary">View Items</a>
                    </div>
                </div>
            </div>
            <!-- Items Exchanged Card -->
            <div class="col-md-4 mb-4">
                <div class="card">
                    <div class="card-header">
                        Items Exchanged
                    </div>
                    <div class="card-body">
                        <p class="card-text">You have exchanged <c:out value="${itemsExchangedCount}" /> items.</p>
                        <a href="<c:url value='/exchanged-items.jsp' />" class="btn btn-primary">View Exchanged Items</a>
                    </div>
                </div>
            </div>
            <!-- Pending Requests Card -->
            <div class="col-md-4 mb-4">
                <div class="card">
                    <div class="card-header">
                        Pending Requests
                    </div>
                    <div class="card-body">
                        <p class="card-text">You have <c:out value="${pendingRequestsCount}" /> pending requests.</p>
                        <a href="<c:url value='/pending-requests.jsp' />" class="btn btn-primary">View Requests</a>
                    </div>
                </div>
            </div>
        </div>
        <div class="row mt-5">
            <!-- My Items Section -->
            <div class="col-md-12">
                <h2>My Items</h2>
                <a href="<c:url value='/add-item.jsp' />" class="btn btn-success mb-3">Add New Item</a>
                <table class="table table-striped">
                    <thead>
                    <tr>
                        <th>Item Name</th>
                        <th>Description</th>
                        <th>Category</th>
                        <th>Condition</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="item" items="${myItems}">
                        <tr>
                            <td><c:out value="${item.name}" /></td>
                            <td><c:out value="${item.description}" /></td>
                            <td><c:out value="${item.category}" /></td>
                            <td><c:out value="${item.condition}" /></td>
                            <td>
                                <a href="<c:url value='/edit-item.jsp?id=${item.id}' />" class="btn btn-warning btn-sm">Edit</a>
                                <a href="<c:url value='/delete-item?id=${item.id}' />" class="btn btn-danger btn-sm">Delete</a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="row mt-5">
            <!-- User Profile Section -->
            <div class="col-md-6">
                <h2>User Profile</h2>
                <p>Name: <c:out value="${userName}" /></p>
                <p>Email: <c:out value="${userEmail}" /></p>
                <a href="<c:url value='/edit-profile.jsp' />" class="btn btn-primary">Edit Profile</a>
            </div>
            <!-- Recent Activities Section -->
            <div class="col-md-6">
                <h2>Recent Activities</h2>
                <ul class="list-group">
                    <c:forEach var="activity" items="${recentActivities}">
                        <li class="list-group-item"><c:out value="${activity}" /></li>
                    </c:forEach>
                </ul>
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