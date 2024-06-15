<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Footer</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
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
            <a href="#"><img src="<c:url value='https://res.cloudinary.com/dtvclnkeo/image/upload/v1718400052/linkedin_rxwojk.png' />" alt="LinkedIn"></a>
            <a href="#"><img src="<c:url value='https://res.cloudinary.com/dtvclnkeo/image/upload/v1718400235/twitter_ym3j4d.png' />" alt="Twitter"></a>
            <a href="#"><img src="<c:url value='https://res.cloudinary.com/dtvclnkeo/image/upload/v1718400223/instagram_xybsuw.png' />" alt="Instagram"></a>
        </div>
    </div>
</footer>
</body>
</html>