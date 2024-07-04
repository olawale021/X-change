<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Item Details - MangoEx</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f8f9fa;
            color: #333;
        }
        .container {
            max-width: 100%;
            padding: 0;
        }
        .card {
            border: none;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            border-radius: 0;
            overflow: hidden;
        }
        .card-header {
            background-color: #14397d;
            color: white;
            border-bottom: none;
            padding: 20px;
        }
        .card-header h4 {
            margin-bottom: 0;
            font-weight: 600;
        }
        .card-body {
            padding: 30px;
        }
        .card-title {
            color: #14397d;
            font-size: 24px;
            font-weight: 600;
            margin-bottom: 20px;
        }
        .item-image-container {
            position: relative;
            width: 100%;
            padding-top: 56.25%; /* 16:9 Aspect Ratio */
            margin-bottom: 20px;
            overflow: hidden;
        }
        .item-image {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            width: 80%;
            height: 80%;
        }
        .item-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        .card-text {
            font-size: 16px;
            line-height: 1.6;
            margin-bottom: 15px;
        }
        .card-text strong {
            color: #14397d;
            font-weight: 600;
        }
        .btn-primary {
            background-color: #14397d;
            border-color: #14397d;
            padding: 10px 20px;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        .btn-primary:hover {
            background-color: #0e2b5c;
            border-color: #0e2b5c;
            transform: translateY(-2px);
        }
        .item-details {
            background-color: #f8f9fa;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
        }
        .item-details h5 {
            color: #14397d;
            font-weight: 600;
            margin-bottom: 15px;
        }
        .item-detail {
            display: flex;
            align-items: flex-start;
            margin-bottom: 10px;
        }
        .item-detail i {
            color: #14397d;
            margin-right: 10px;
            font-size: 18px;
            margin-top: 3px;
        }
        @media (max-width: 768px) {
            .item-image-container {
                padding-top: 75%; /* 4:3 Aspect Ratio for smaller screens */
            }
        }
    </style>
</head>
<body>

<jsp:include page="header.jsp"/>

<div class="container mt-5">
    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-header">
                    <h4><i class="fas fa-info-circle"></i> Item Details</h4>
                </div>
                <div class="card-body">
                    <h5 class="card-title"><c:out value="${item.title}" /></h5>
                    <div class="item-image-container">
                        <div class="item-image">
                            <img src="<c:out value='${item.firstPhotoUrl}' />" alt="<c:out value='${item.title}' />">
                        </div>
                    </div>
                    <div class="item-details">
                        <h5>Item Information</h5>
                        <div class="item-detail">
                            <i class="fas fa-align-left"></i>
                            <p class="card-text"><strong>Description:</strong> <c:out value="${item.description}" /></p>
                        </div>
                        <div class="item-detail">
                            <i class="fas fa-tag"></i>
                            <p class="card-text"><strong>Category:</strong> <c:out value="${item.categoryName}" /></p>
                        </div>
                        <div class="item-detail">
                            <i class="fas fa-star-half-alt"></i>
                            <p class="card-text"><strong>Condition:</strong> <c:out value="${item.condition}" /></p>
                        </div>
                    </div>
                    <form action="exchange" method="post">
                        <input type="hidden" name="itemId" value="<c:out value='${item.id}' />">
                        <input type="hidden" name="ownerId" value="<c:out value='${item.userId}' />">
                        <input type="hidden" name="interestedUserId" value="<c:out value='${user.id}' />">
                        <div class="form-group">
                            <label for="offerMessage">Your Offer Message</label>
                            <textarea class="form-control" id="offerMessage" name="offerMessage" rows="4" placeholder="Type your offer message here..."></textarea>
                        </div>
                        <button type="submit" class="btn btn-primary"><i class="fas fa-paper-plane"></i> Send Offer</button>
                    </form>
                    <a href="all-items" class="btn btn-primary mt-3"><i class="fas fa-arrow-left"></i> Back to All Items</a>
                </div>
            </div>
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
