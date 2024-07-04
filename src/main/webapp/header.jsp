<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title></title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
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
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="all-items">All Items</a></li>
                <li class="nav-item"><a class="nav-link" href="additem">Add Item</a></li>
                <li class="nav-item"><a class="nav-link" href="user-items">My Items</a></li>
                <li class="nav-item"><a class="nav-link" href="offers">Offers</a></li>
                <c:choose>
                    <c:when test="${not empty user}">
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <c:out value="${user.username}" />
                            </a>
                            <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                                <a class="dropdown-item" href="<c:url value='/settings.jsp' />">Settings</a>
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item" href="<c:url value='/user-dashboard.jsp' />">Dashboard</a>
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item" href="<c:url value='/logout' />">Logout</a>
                            </div>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item"><a class="nav-link" href="login.jsp">Login</a></li>
                        <li class="nav-item"><a class="nav-link btn btn-primary text-white" href="register.jsp">Get Started</a></li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>
</body>
</html>