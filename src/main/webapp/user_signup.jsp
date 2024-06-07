<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>User Registration</title>
</head>
<body>
<h1>User Registration</h1>
<form action="register" method="post">
    <label>Username:</label>
    <input type="text" name="username" required><br>
    <label>Password:</label>
    <input type="password" name="password" required><br>
    <label>Street:</label>
    <input type="text" name="addressStreet"><br>
    <label>City:</label>
    <input type="text" name="addressCity"><br>
    <label>Country:</label>
    <input type="text" name="addressCountry"><br>
    <label>Zip Code:</label>
    <input type="text" name="addressZipCode"><br>
    <input type="submit" value="Register">
</form>
</body>
</html>
