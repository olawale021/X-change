<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Dashboard</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="./css/style.css">

</head>
<body>

<!-- Header -->
<nav class="navbar navbar-expand-lg navbar-dark fixed-top">
    <div class="container">
        <a class="navbar-brand logo" href="#">X-Change</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item"><a class="nav-link" href="#">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="#">Services</a></li>
                <li class="nav-item"><a class="nav-link" href="#">How It Works</a></li>
                <li class="nav-item"><a class="nav-link" href="#">Contact</a></li>
                <li class="nav-item"><a class="nav-link" href="login.jsp">Login</a></li>
                <li class="nav-item"><a class="nav-link btn btn-primary text-white" href="register.jsp">Get Started</a></li>
            </ul>
        </div>
    </div>
</nav>

<!-- Sidebar -->
<div class="sidebar">
    <a href="">Dashboard</a>
    <a href="my-items.jsp">My Items</a>
    <a href="add-item.jsp">Add Item</a>
    <a href="exchanged-items.jsp">Exchanged Items</a>
    <a href="pending-requests.jsp">Pending Requests</a>
    <a href="edit-profile.jsp">Edit Profile</a>
    <a href="logout">Logout</a>
</div>

<!-- Main Content -->
<div class="main-content">
    <div class="container mt-5">
        <div class="row">
            <!-- Items Listed Card -->
            <div class="col-md-4">
                <div class="card">
                    <div class="card-header">
                        Items Listed
                    </div>
                    <div class="card-body">
                        <p class="card-text">You have X items listed for exchange.</p>
                        <a href="my-items.jsp" class="btn btn-primary">View Items</a>
                    </div>
                </div>
            </div>
            <!-- Items Exchanged Card -->
            <div class="col-md-4">
                <div class="card">
                    <div class="card-header">
                        Items Exchanged
                    </div>
                    <div class="card-body">
                        <p class="card-text">You have exchanged X items.</p>
                        <a href="exchanged-items.jsp" class="btn btn-primary">View Exchanged Items</a>
                    </div>
                </div>
            </div>
            <!-- Pending Requests Card -->
            <div class="col-md-4">
                <div class="card">
                    <div class="card-header">
                        Pending Requests
                    </div>
                    <div class="card-body">
                        <p class="card-text">You have X pending requests.</p>
                        <a href="pending-requests.jsp" class="btn btn-primary">View Requests</a>
                    </div>
                </div>
            </div>
        </div>
        <div class="row mt-5">
            <!-- My Items Section -->
            <div class="col-md-12">
                <h2>My Items</h2>
                <a href="add-item.jsp" class="btn btn-success mb-3">Add New Item</a>
                <!-- Example table, replace with dynamic content -->
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
                    <!-- Example row, replace with dynamic content -->
                    <tr>
                        <td>Item 1</td>
                        <td>Item 1 Description</td>
                        <td>Electronics</td>
                        <td>New</td>
                        <td>
                            <a href="edit-item.jsp?id=1" class="btn btn-warning btn-sm">Edit</a>
                            <a href="delete-item?id=1" class="btn btn-danger btn-sm">Delete</a>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="row mt-5">
            <!-- User Profile Section -->
            <div class="col-md-6">
                <h2>User Profile</h2>
                <p>Name: John Doe</p>
                <p>Email: john.doe@example.com</p>
                <a href="edit-profile.jsp" class="btn btn-primary">Edit Profile</a>
            </div>
            <!-- Recent Activities Section -->
            <div class="col-md-6">
                <h2>Recent Activities</h2>
                <ul class="list-group">
                    <!-- Example items, replace with dynamic content -->
                    <li class="list-group-item">Exchanged item "Laptop" with "Jane Doe"</li>
                    <li class="list-group-item">Added new item "Smartphone"</li>
                    <li class="list-group-item">Received request for item "Bike"</li>
                </ul>
            </div>
        </div>
    </div>
</div>

<!-- Footer -->
<footer class="footer py-4">
    <div class="container text-center">
        <p class="mb-1">© 2024 X-Change. All Rights Reserved.</p>
        <ul class="list-inline mb-3">
            <li class="list-inline-item"><a href="#">About</a></li>
            <li class="list-inline-item"><a href="#">Contact</a></li>
            <li class="list-inline-item"><a href="#">Terms of Service</a></li>
            <li class="list-inline-item"><a href="#">Privacy Policy</a></li>
        </ul>
        <div>
            <a href="#"><img src="images/linkedin.png" alt="LinkedIn"></a>
            <a href="#"><img src="images/twitter.png" alt="Twitter"></a>
            <a href="#"><img src="images/instagram.png" alt="Instagram"></a>
        </div>
    </div>
</footer>

<!-- Bootstrap JS, Popper.js, and jQuery -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
