<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MangoEx - Item Exchange Platform</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
        :root {
            --primary-color: #14397d;
            --secondary-color: #d7eaf3;
            --accent-color: #ffc107;
            --text-color: #333;
            --light-text-color: #6c757d;
        }
        body {
            font-family: 'Roboto', -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Oxygen', 'Ubuntu', 'Cantarell', 'Fira Sans', 'Droid Sans', 'Helvetica Neue', sans-serif;
            color: var(--text-color);
            background-color: #f8f9fa;
        }
        .hero {
            background: linear-gradient(rgba(20, 57, 125, 0.7), rgba(20, 57, 125, 0.7)), url('https://hmarkets.com/wp-media/2024/02/SWAP-on-a-wooden-cubes-with-pen-and-calculator-resize.jpg');
            background-size: cover;
            background-position: center;
            color: #fff;
            padding: 100px 0;
            text-align: center;
        }
        .hero h1 {
            font-size: 3.5rem;
            font-weight: 700;
            margin-bottom: 1rem;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.5);
        }
        .hero p {
            font-size: 1.25rem;
            margin-bottom: 2rem;
            text-shadow: 1px 1px 2px rgba(0,0,0,0.5);
        }
        .btn-custom {
            padding: 12px 30px;
            font-size: 1.1rem;
            font-weight: 600;
            text-transform: uppercase;
            border-radius: 30px;
            transition: all 0.3s ease;
        }
        .btn-primary {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
        }
        .btn-primary:hover {
            background-color: #0f2c99;
            border-color: #0f2c99;
        }
        .btn-secondary {
            background-color: var(--secondary-color);
            border-color: var(--secondary-color);
            color: var(--primary-color);
        }
        .btn-secondary:hover {
            background-color: #b9d7e0;
            border-color: #b9d7e0;
        }
        .section-title {
            color: var(--primary-color);
            font-weight: 700;
            margin-bottom: 2rem;
            text-align: center;
            position: relative;
            padding-bottom: 15px;
        }
        .section-title::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 50px;
            height: 3px;
            background-color: var(--accent-color);
        }
        .featured-items .card-text {
            font-size: 0.9rem;
            margin-bottom: 0.5rem;
        }

        .featured-items .card-text strong {
            color: var(--primary-color);
        }

        .featured-items .card {
            height: 100%;
            display: flex;
            flex-direction: column;
        }

        .featured-items .card-body {
            flex-grow: 1;
            display: flex;
            flex-direction: column;
        }

        .featured-items .card-img-top {
            height: 200px;
            object-fit: cover;
        }

        .alert-info {
            background-color: var(--secondary-color);
            border-color: var(--primary-color);
            color: var(--primary-color);
        }
        .featured-items .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 12px rgba(0,0,0,0.15);
        }
        .featured-items .card-img-top {
            height: 200px;
            object-fit: cover;
        }
        .featured-items .card-title {
            color: var(--primary-color);
            font-weight: 600;
        }

        .featured-items .card-text i {
            width: 20px;
            text-align: center;
        }

        .featured-items .card-text {
            display: flex;
            align-items: flex-start;
        }

        .featured-items .card-text i {
            margin-top: 3px;
        }
        .card-text {
            font-size: 0.9rem;
            color: #6c757d;
            margin-bottom: 0.5rem;
            max-height: 3.6em;
            overflow: hidden;
            text-overflow: ellipsis;
            display: -webkit-box;
            -webkit-line-clamp: 3;
            -webkit-box-orient: vertical;
        }

        .card-text i {
            width: 20px;
            text-align: center;
            margin-right: 5px;
            color: #14397d;
        }

        .card-title {
            font-size: 1.1rem;
            font-weight: 600;
            margin-bottom: 0.75rem;
        }
        .how-it-works {
            background-color: var(--secondary-color);
            padding: 80px 0;
        }
        .how-it-works .icon-box {
            text-align: center;
            padding: 30px;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
        }
        .how-it-works .icon-box:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 12px rgba(0,0,0,0.15);
        }
        .how-it-works img {
            height: 80px;
            margin-bottom: 20px;
        }
        .testimonials {
            background-color: var(--primary-color);
            color: #fff;
            padding: 80px 0;
        }
        .testimonials .carousel-item {
            padding: 30px;
        }
        .testimonials blockquote {
            font-size: 1.1rem;
            font-style: italic;
        }
        .testimonials .blockquote-footer {
            color: var(--accent-color);
        }
    </style>
</head>
<body>

<jsp:include page="header.jsp"/>

<!-- Hero Section -->
<section class="hero">
    <div class="container">
        <h1>Discover the Joy of Item Exchange</h1>
        <p class="lead">Your go-to platform for swapping items with ease and trust.</p>
        <a href="<c:url value='/register.jsp' />" class="btn btn-custom btn-primary mr-3">Join Now</a>
        <a href="#how-it-works" class="btn btn-custom btn-secondary">Learn More</a>
    </div>
</section>

<!-- Featured Items -->
<section class="featured-items py-5">
    <div class="container">
        <h2 class="section-title">Popular Items</h2>
        <div class="row">
            <c:if test="${not empty items}">
                <c:forEach var="item" items="${items}">
                    <div class="col-md-4">
                        <div class="card mb-4">
                            <img src="<c:out value='${item.firstPhotoUrl}' />" class="card-img-top" alt="<c:out value='${item.title}' />">
                            <div class="card-body">
                                <h5 class="card-title"><c:out value='${item.title}' /></h5>
                                <p class="card-text">
                                    <i class="fas fa-info-circle text-primary mr-2"></i>
                                    <strong>Description:</strong>
                                    <c:out value='${fn:substring(item.description, 0, 100)}' />...
                                </p>
                                <p class="card-text">
                                    <i class="fas fa-star text-warning mr-2"></i>
                                    <strong>Condition:</strong> <c:out value='${item.condition}' />
                                </p>
                                <p class="card-text">
                                    <i class="fas fa-tag text-success mr-2"></i>
                                    <strong>Category:</strong> <c:out value='${item.categoryName}' />
                                </p>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:if>
            <c:if test="${empty items}">
                <div class="col-12">
                    <div class="alert alert-info text-center" role="alert">
                        <i class="fas fa-info-circle mr-2"></i>
                        No items available at the moment. Check back soon for exciting exchanges!
                    </div>
                </div>
            </c:if>
        </div>
    </div>
</section>

<!-- How It Works -->
<section id="how-it-works" class="how-it-works">
    <div class="container">
        <h2 class="section-title">How It Works</h2>
        <div class="row">
            <div class="col-md-3 mb-4">
                <div class="icon-box">
                    <img src="https://res.cloudinary.com/dtvclnkeo/image/upload/v1718400341/register_zcinem.png" alt="Step 1" class="mb-3">
                    <h5>Sign Up</h5>
                    <p>Create an account to start listing and exchanging items.</p>
                </div>
            </div>
            <div class="col-md-3 mb-4">
                <div class="icon-box">
                    <img src="https://res.cloudinary.com/dtvclnkeo/image/upload/v1718400321/additem_yywq7u.png" alt="Step 2" class="mb-3">
                    <h5>List Items</h5>
                    <p>Upload details and images of items you wish to exchange.</p>
                </div>
            </div>
            <div class="col-md-3 mb-4">
                <div class="icon-box">
                    <img src="https://res.cloudinary.com/dtvclnkeo/image/upload/v1718400349/search_vim4md.png" alt="Step 3" class="mb-3">
                    <h5>Browse Listings</h5>
                    <p>Explore a variety of items listed by other users.</p>
                </div>
            </div>
            <div class="col-md-3 mb-4">
                <div class="icon-box">
                    <img src="https://res.cloudinary.com/dtvclnkeo/image/upload/v1718400359/message_f5cu6b.png" alt="Step 4" class="mb-3">
                    <h5>Exchange Items</h5>
                    <p>Communicate with users to arrange the exchange.</p>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- User Testimonials -->
<section class="testimonials">
    <div class="container">
        <h2 class="section-title">User Experiences</h2>
        <div id="testimonialsCarousel" class="carousel slide" data-ride="carousel">
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <blockquote class="blockquote text-center">
                        <p class="mb-0">"MangoEx has made swapping items so easy and fun. Highly recommend it!"</p>
                        <footer class="blockquote-footer">Jane Doe</footer>
                    </blockquote>
                </div>
                <div class="carousel-item">
                    <blockquote class="blockquote text-center">
                        <p class="mb-0">"Great platform with a friendly community. I found exactly what I needed."</p>
                        <footer class="blockquote-footer">John Smith</footer>
                    </blockquote>
                </div>
                <div class="carousel-item">
                    <blockquote class="blockquote text-center">
                        <p class="mb-0">"Easy to use and lots of interesting items available for exchange."</p>
                        <footer class="blockquote-footer">Sarah Lee</footer>
                    </blockquote>
                </div>
            </div>
            <a class="carousel-control-prev" href="#testimonialsCarousel" role="button" data-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="sr-only">Previous</span>
            </a>
            <a class="carousel-control-next" href="#testimonialsCarousel" role="button" data-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="sr-only">Next</span>
            </a>
        </div>
    </div>
</section>

<jsp:include page="footer.jsp" />

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>