<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.models.items.ItemsModel" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Item Exchange - Home</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/style.css">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #d7eaf3;
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
        .hero {
            position: relative;
            background-image: url('https://hmarkets.com/wp-media/2024/02/SWAP-on-a-wooden-cubes-with-pen-and-calculator-resize.jpg');
            background-size: cover;
            background-position: center;
            padding: 180px 0;
            text-align: center;
            color: #d7eaf3;
            height: 600px;
        }
        .hero::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5); /* Dark overlay */
            backdrop-filter: blur(5px); /* Blur effect */
        }
        .hero h1, .hero p, .hero .btn {
            position: relative;
            z-index: 1;
        }
        .hero h1 {
            font-size: 3.5rem;
            font-weight: 700;
            margin-bottom: 1rem;
        }
        .hero p {
            font-size: 1.25rem;
            margin-bottom: 2rem;
        }
        .btn-primary, .btn-secondary {
            border-radius: 30px;
            padding: 10px 30px;
        }
        .btn-primary {
            background-color: #14397d;
            border: none;
        }
        .btn-primary:hover, .btn-primary:focus {
            background-color: #0f2c99;
        }
        .btn-secondary {
            background-color: #d7eaf3;
            border: none;
            color: #14397d;
        }
        .btn-secondary:hover, .btn-secondary:focus {
            background-color: #b9d7e0;
        }
        .featured-items .card {
            margin: 20px 0;
            border: none;
        }
        .featured-items .card-body {
            background-color: #14397d;
            color: #d7eaf3;
        }
        .how-it-works {
            margin-bottom: 100px;
        }
        .how-it-works .col-md-3 {
            margin-bottom: 50px;
        }
        .how-it-works img {
            height: 60px;
            margin-bottom: 20px;
        }
        .testimonials .carousel-item {
            padding: 30px;
            background-color: #77b5d9;
            color: #14397d;
            border-radius: 10px;
        }


        /*footer*/
        .footer {
            background-color: #14397d;
            padding: 20px 0;
            text-align: center;
            color: #d7eaf3;
        }
        .footer a {
            color: #d7eaf3;
            margin: 0 10px;
        }
        .footer a:hover, .footer a:focus {
            color: #77b5d9;
        }
    </style>
</head>
<body>

<!-- Header -->
<nav class="navbar navbar-expand-lg">
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

<!-- Hero Section -->
<div class="hero">
    <div class="container text-center">
        <h1>Discover the Joy of Item Exchange</h1>
        <p>Your go-to platform for swapping items with ease and trust.</p>
        <a href="register.jsp" class="btn btn-primary btn-lg">Join Now</a>
        <a href="#how-it-works" class="btn btn-secondary btn-lg">Learn More</a>
    </div>
</div>

<!-- Featured Items -->
<section class="container my-5">
    <h2 class="text-center mb-4">Popular Items</h2>
    <div class="row">
        <%
            @SuppressWarnings("unchecked")
            List<ItemsModel> items = (List<ItemsModel>) request.getAttribute("items");
            if (items != null && !items.isEmpty()) {
                System.out.println("Items received in JSP: " + items.size());
                for (ItemsModel item : items) {
                    System.out.println("Item: " + item.getName());
        %>
        <div class="col-md-4">
            <div class="card mb-4">
                <img src="<%= item.getImageUrl() %>" class="card-img-top" alt="<%= item.getName() %>">
                <div class="card-body">
                    <h5 class="card-title"><%= item.getName() %></h5>
                    <p class="card-text"><%= item.getDescription() %></p>
                </div>
            </div>
        </div>
        <%
            }
        } else {
            System.out.println("No items available in JSP.");
        %>
        <p>No items available.</p>
        <%
            }
        %>
    </div>
</section>

<!-- How It Works -->
<section id="how-it-works" class="container my-5">
    <h2 class="text-center mb-4">How It Works</h2>
    <div class="row text-center">
        <div class="col-md-3">
            <img src="images/register.png" alt="Step 1" class="mb-3"> <!-- Replace with your icon -->
            <h5>Sign Up</h5>
            <p>Create an account to start listing and exchanging items.</p>
        </div>
        <div class="col-md-3">
            <img src="images/additem.png" alt="Step 2" class="mb-3"> <!-- Replace with your icon -->
            <h5>List Items</h5>
            <p>Upload details and images of items you wish to exchange.</p>
        </div>
        <div class="col-md-3">
            <img src="images/search.png" alt="Step 3" class="mb-3"> <!-- Replace with your icon -->
            <h5>Browse Listings</h5>
            <p>Explore a variety of items listed by other users.</p>
        </div>
        <div class="col-md-3">
            <img src="images/message.png" alt="Step 4" class="mb-3"> <!-- Replace with your icon -->
            <h5>Exchange Items</h5>
            <p>Communicate with users to arrange the exchange.</p>
        </div>
    </div>
</section>

<!-- User Testimonials -->
<section class="container my-5">
    <h2 class="text-center mb-4">User Experiences</h2>
    <div id="testimonialsCarousel" class="carousel slide" data-ride="carousel">
        <div class="carousel-inner">
            <div class="carousel-item active">
                <blockquote class="blockquote text-center">
                    <p class="mb-0">"X-Change has made swapping items so easy and fun. Highly recommend it!"</p>
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
</section>

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


<script>
    console.log("Items received in JSP: <%= (items != null) ? items.size() : "0" %>");
    <% if (items != null) { %>
    <% for (ItemsModel item : items) { %>
    console.log("Item: <%= item.getName() %>");
    <% } %>
    <% } %>
</script>

</body>
</html>
