<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Dashboard - MangoEx</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link rel="stylesheet" href="<c:url value='/css/style.css' />">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f8f9fa;
        }
        .navbar-brand {
            font-size: 24px;
            font-weight: bold;
        }
        .sidebar {
            position: fixed;
            top: 56px;
            left: 0;
            width: 220px;
            height: calc(100vh - 56px);
            background-color: #14397d;
            padding-top: 20px;
            overflow-y: auto;
        }
        .sidebar a {
            display: block;
            color: #ffffff;
            padding: 12px 20px;
            text-decoration: none;
            transition: all 0.3s ease;
        }
        .sidebar a:hover, .sidebar a:focus {
            background-color: #ffffff;
            color: #14397d;
        }
        .sidebar i {
            margin-right: 10px;
            width: 20px;
            text-align: center;
        }
        .main-content {
            margin-left: 220px;
            padding: 20px;
        }
        .card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
            transition: transform 0.3s ease;
        }
        .card:hover {
            transform: translateY(-5px);
        }
        .card-header {
            background-color: #14397d;
            color: white;
            font-weight: bold;
            border-top-left-radius: 10px;
            border-top-right-radius: 10px;
        }
        .btn-primary {
            background-color: #14397d;
            border-color: #14397d;
        }
        .btn-primary:hover {
            background-color: #0e2b5c;
            border-color: #0e2b5c;
        }
        .table {
            background-color: white;
            border-radius: 10px;
            overflow: hidden;
        }
        .table thead th {
            background-color: #14397d;
            color: white;
            border: none;
        }
        .footer {
            background-color: #14397d;
            color: white;
            padding: 20px 0;
            margin-top: 40px;
        }
        .footer a {
            color: #9fcdff;
            margin: 0 10px;
            transition: color 0.3s ease;
        }
        .footer a:hover {
            color: white;
            text-decoration: none;
        }
    </style>
</head>
<body>

<jsp:include page="header.jsp"/>

<!-- Main Content -->
<div class="main-content">
    <div class="container-fluid">
        <h1 class="mb-4">Dashboard</h1>
        <div class="row">
            <!-- Items Listed Card -->
            <div class="col-md-4 mb-4">
                <div class="card">
                    <div class="card-header">
                        <i class="fas fa-list"></i> Items Listed
                    </div>
                    <div class="card-body">
                        <h2 class="card-title"><c:out value="${itemsListedCount}" /></h2>
                        <p class="card-text">Items listed for exchange</p>
                        <a href="<c:url value='/my-items.jsp' />" class="btn btn-primary">View Items</a>
                    </div>
                </div>
            </div>
            <!-- Items Exchanged Card -->
            <div class="col-md-4 mb-4">
                <div class="card">
                    <div class="card-header">
                        <i class="fas fa-exchange-alt"></i> Items Exchanged
                    </div>
                    <div class="card-body">
                        <h2 class="card-title"><c:out value="${itemsExchangedCount}" /></h2>
                        <p class="card-text">Successfully exchanged items</p>
                        <a href="<c:url value='/exchanged-items.jsp' />" class="btn btn-primary">View Exchanges</a>
                    </div>
                </div>
            </div>
            <!-- Pending Requests Card -->
            <div class="col-md-4 mb-4">
                <div class="card">
                    <div class="card-header">
                        <i class="fas fa-hourglass-half"></i> Pending Requests
                    </div>
                    <div class="card-body">
                        <h2 class="card-title"><c:out value="${pendingRequestsCount}" /></h2>
                        <p class="card-text">Requests awaiting your response</p>
                        <a href="<c:url value='/pending-requests.jsp' />" class="btn btn-primary">View Requests</a>
                    </div>
                </div>
            </div>
        </div>

        <!-- My Items Section -->
        <div class="row mt-5">
            <div class="col-md-12">
                <h2 class="mb-3">My Items</h2>
                <a href="<c:url value='/add-item.jsp' />" class="btn btn-success mb-3"><i class="fas fa-plus"></i> Add New Item</a>
                <div class="table-responsive">
                    <table class="table table-hover">
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
                                    <a href="<c:url value='/edit-item.jsp?id=${item.id}' />" class="btn btn-warning btn-sm"><i class="fas fa-edit"></i></a>
                                    <a href="<c:url value='/delete-item?id=${item.id}' />" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure you want to delete this item?');"><i class="fas fa-trash-alt"></i></a>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- User Profile and Recent Activities -->
        <div class="row mt-5">
            <div class="col-md-6">
                <div class="card">
                    <div class="card-header">
                        <i class="fas fa-user"></i> User Profile
                    </div>
                    <div class="card-body">
                        <p><strong>Name:</strong> <c:out value="${userName}" /></p>
                        <p><strong>Email:</strong> <c:out value="${userEmail}" /></p>
                        <a href="<c:url value='/edit-profile.jsp' />" class="btn btn-primary"><i class="fas fa-user-edit"></i> Edit Profile</a>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="card">
                    <div class="card-header">
                        <i class="fas fa-history"></i> Recent Activities
                    </div>
                    <div class="card-body">
                        <ul class="list-group list-group-flush">
                            <c:forEach var="activity" items="${recentActivities}">
                                <li class="list-group-item"><c:out value="${activity}" /></li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
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