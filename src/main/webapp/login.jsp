<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Login</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>

<jsp:include page="header.jsp"/>

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card">
                <div class="card-header bg-primary text-white">User Login</div>
                <div class="card-body">
                    <form action="<c:url value='/login' />" method="post">
                        <div class="form-group">
                            <label for="username">Username</label>
                            <input type="text" class="form-control" id="username" name="username" required>
                        </div>
                        <div class="form-group">
                            <label for="password">Password</label>
                            <input type="password" class="form-control" id="password" name="password" required>
                        </div>
                        <button type="submit" class="btn btn-primary btn-block">Login</button>
                    </form>
                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger mt-3">
                            <c:out value="${errorMessage}" />
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- How It Works -->
<section id="how-it-works" class="container my-5">
    <h2 class="text-center mb-4">How It Works</h2>
    <div class="row text-center">
        <div class="col-md-3">
            <img src="https://res.cloudinary.com/dtvclnkeo/image/upload/v1718400341/register_zcinem.png" alt="Step 1" class="mb-3">
            <h5>Sign Up</h5>
            <p>Create an account to start listing and exchanging items.</p>
        </div>
        <div class="col-md-3">
            <img src="https://res.cloudinary.com/dtvclnkeo/image/upload/v1718400321/additem_yywq7u.png" alt="Step 2" class="mb-3">
            <h5>List Items</h5>
            <p>Upload details and images of items you wish to exchange.</p>
        </div>
        <div class="col-md-3">
            <img src="https://res.cloudinary.com/dtvclnkeo/image/upload/v1718400349/search_vim4md.png" alt="Step 3" class="mb-3">
            <h5>Browse Listings</h5>
            <p>Explore a variety of items listed by other users.</p>
        </div>
        <div class="col-md-3">
            <img src="https://res.cloudinary.com/dtvclnkeo/image/upload/v1718400359/message_f5cu6b.png" alt="Step 4" class="mb-3">
            <h5>Exchange Items</h5>
            <p>Communicate with users to arrange the exchange.</p>
        </div>
    </div>
</section>

<jsp:include page="footer.jsp"/>

<!-- Bootstrap JS, Popper.js, and jQuery -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>