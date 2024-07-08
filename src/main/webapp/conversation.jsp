<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Conversation - MangoEx</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
        :root {
            --primary-color: #14397d;
            --secondary-color: #f8f9fa;
            --accent-color: #ffc107;
            --text-color: #333;
            --light-text-color: #6c757d;
        }
        body {
            font-family: 'Roboto', sans-serif;
            background-color: var(--secondary-color);
            color: var(--text-color);
        }
        .container {
            max-width: 800px;
            margin-top: 30px;
            margin-bottom: 30px;
        }
        .conversation-container {
            background-color: #fff;
            border-radius: 15px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            padding: 20px;
        }
        .conversation-header {
            border-bottom: 2px solid var(--accent-color);
            margin-bottom: 20px;
            padding-bottom: 10px;
        }
        .conversation {
            max-height: 500px;
            overflow-y: auto;
            padding: 10px;
            border: 1px solid #e9ecef;
            border-radius: 5px;
            background-color: #f8f9fa;
        }
        .message {
            margin-bottom: 15px;
            padding: 10px;
            border-radius: 10px;
            position: relative;
        }
        .message-sent {
            background-color: #d4edda;
            margin-left: 20%;
        }
        .message-received {
            background-color: #e9ecef;
            margin-right: 20%;
        }
        .message p {
            margin-bottom: 5px;
        }
        .message .timestamp {
            font-size: 0.8em;
            color: var(--light-text-color);
            position: absolute;
            bottom: 5px;
            right: 10px;
        }
        .new-message-form {
            margin-top: 20px;
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        .btn-send {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
        }
        .btn-send:hover {
            background-color: #0e2b5c;
            border-color: #0e2b5c;
        }
        .logo {
            max-height: 50px;
            margin-right: 15px;
        }
    </style>
</head>
<body>

<jsp:include page="header.jsp"/>

<div class="container">
    <div class="conversation-container">
        <div class="conversation-header d-flex align-items-center">
<%--            <img src="path/to/your/logo.png" alt="MangoEx Logo" class="logo">--%>
            <h2 class="mb-0">Conversation</h2>
        </div>
        <div class="conversation">
            <c:forEach var="message" items="${messages}">
                <div class="message ${message.senderId eq sessionScope.userId ? 'message-sent' : 'message-received'}">
                    <p><strong>${message.senderName}:</strong> <c:out value="${message.message}" /></p>
                    <span class="timestamp"><c:out value="${message.createdAt}" /></span>
                </div>
            </c:forEach>
        </div>

        <!-- Form for adding new message -->
        <div class="new-message-form">
            <form action="addMessage" method="post">
                <div class="form-group">
                    <input type="hidden" name="exchangeId" value="${param.exchangeId}" />
                    <input type="hidden" name="senderId" value="${sessionScope.userId}" />
                    <label for="message"><i class="fas fa-pen"></i> New Message:</label>
                    <textarea name="message" id="message" class="form-control" rows="3" required></textarea>
                </div>
                <button type="submit" class="btn btn-primary btn-send">
                    <i class="fas fa-paper-plane"></i> Send Message
                </button>
            </form>
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