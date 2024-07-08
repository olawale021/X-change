<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Your Offers - MangoEx</title>
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
  <style>
    :root {
      --primary-color: #14397d;
      --secondary-color: #f8f9fa;
      --accent-color: #ffc107;
      --text-color: #333;
      --light-text-color: #6c757d;
      --success-color: #28a745;
      --danger-color: #dc3545;
    }
    body {
      font-family: 'Roboto', -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Oxygen', 'Ubuntu', 'Cantarell', 'Fira Sans', 'Droid Sans', 'Helvetica Neue', sans-serif;
      background-color: var(--secondary-color);
      color: var(--text-color);
    }
    .container {
      max-width: 1400px;
      padding: 40px 20px;
    }
    .offers-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
      gap: 20px;
    }
    .offer-section {
      margin-bottom: 50px;
      background-color: #fff;
      border-radius: 15px;
      padding: 30px;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    }
    .offer-section h2 {
      margin-bottom: 20px;
      color: var(--primary-color);
      font-weight: 700;
      padding-bottom: 10px;
      border-bottom: 2px solid var(--accent-color);
    }
    .card {
      border: none;
      border-radius: 10px;
      box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
      transition: all 0.3s ease;
      height: 100%;
      display: flex;
      flex-direction: column;
    }
    .card:hover {
      transform: translateY(-5px);
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
    }
    .card-header {
      color: white;
      padding: 15px 20px;
      border-top-left-radius: 10px;
      border-top-right-radius: 10px;
      font-weight: 600;
    }
    .pending .card-header {
      background-color: var(--accent-color);
      color: var(--text-color);
    }
    .accepted .card-header {
      background-color: var(--success-color);
    }
    .rejected .card-header {
      background-color: var(--danger-color);
    }
    .card-body {
      padding: 20px;
      flex-grow: 1;
      display: flex;
      flex-direction: column;
    }
    .card-title {
      color: var(--primary-color);
      font-size: 18px;
      font-weight: 600;
      margin-bottom: 15px;
    }
    .card-text {
      font-size: 14px;
      line-height: 1.6;
      margin-bottom: 15px;
      flex-grow: 1;
    }
    .meta-info {
      font-size: 12px;
      color: var(--light-text-color);
      margin-bottom: 5px;
    }
    .meta-info i {
      margin-right: 5px;
    }
    .btn {
      padding: 8px 15px;
      font-size: 14px;
      font-weight: 500;
      transition: all 0.3s ease;
    }
    .btn-primary {
      background-color: var(--primary-color);
      border-color: var(--primary-color);
    }
    .btn-primary:hover {
      background-color: #0e2b5c;
      border-color: #0e2b5c;
    }
    .btn-success {
      background-color: var(--success-color);
      border-color: var(--success-color);
    }
    .btn-danger {
      background-color: var(--danger-color);
      border-color: var (--danger-color);
    }
    .offer-type {
      position: absolute;
      top: 10px;
      right: 10px;
      padding: 5px 10px;
      border-radius: 15px;
      font-size: 12px;
      font-weight: 600;
      background-color: var(--primary-color);
      color: white;
    }
  </style>
</head>
<body>

<jsp:include page="header.jsp"/>

<div class="container">
  <div class="offer-section pending">
    <h2>Pending Offers</h2>
    <div class="offers-grid">
      <c:forEach var="offer" items="${pendingOffers}">
        <div class="card">
          <div class="card-header">
            <c:out value="${offer.itemName}" />
            <span class="offer-type">${offer.isSentOffer ? 'Sent' : 'Received'}</span>
          </div>
          <div class="card-body">
            <h5 class="card-title">
                ${offer.isSentOffer ? 'Your Message' : 'Message from '.concat(offer.senderName)}
            </h5>
            <p class="card-text"><c:out value="${offer.message}" /></p>
            <div class="meta-info">
              <i class="far fa-clock"></i> ${offer.isSentOffer ? 'Sent' : 'Received'} on: <c:out value="${offer.createdAt}" />
            </div>
            <div class="meta-info">
              <i class="fas fa-user"></i> ${offer.isSentOffer ? 'To: '.concat(offer.recipientName) : 'From: '.concat(offer.senderName)}
            </div>
            <form action="fetchConversation" method="get" target="_blank">
              <input type="hidden" name="exchangeId" value="<c:out value='${offer.exchangeId}' />" />
              <button type="submit" class="btn btn-primary mt-3">View Conversation</button>
            </form>
            <c:if test="${!offer.isSentOffer}">
              <form action="offerAction" method="post" class="mt-3">
                <input type="hidden" name="offerId" value="<c:out value='${offer.id}' />" />
                <button type="submit" name="action" value="accept" class="btn btn-success mr-2">Accept</button>
                <button type="submit" name="action" value="reject" class="btn btn-danger">Reject</button>
              </form>
            </c:if>
          </div>
        </div>
      </c:forEach>
    </div>
  </div>


  <div class="offer-section accepted">
    <h2>Accepted Offers</h2>
    <div class="offers-grid">
      <c:forEach var="offer" items="${acceptedOffers}">
        <div class="card">
          <div class="card-header">
            <c:out value="${offer.itemName}" />
            <span class="offer-type">${offer.isSentOffer ? 'Sent' : 'Received'}</span>
          </div>
          <div class="card-body">
            <h5 class="card-title">
                ${offer.isSentOffer ? 'Your Message' : 'Message from '.concat(offer.senderName)}
            </h5>
            <p class="card-text"><c:out value="${offer.message}" /></p>
            <div class="meta-info">
              <i class="far fa-clock"></i> ${offer.isSentOffer ? 'Sent' : 'Received'} on: <c:out value="${offer.createdAt}" />
            </div>
            <div class="meta-info">
              <i class="fas fa-user"></i> ${offer.isSentOffer ? 'To: '.concat(offer.recipientName) : 'From: '.concat(offer.senderName)}
            </div>
            <form action="fetchConversation" method="get" target="_blank">
              <input type="hidden" name="exchangeId" value="<c:out value='${offer.exchangeId}' />" />
              <button type="submit" class="btn btn-primary mt-3">View Conversation</button>
            </form>
          </div>
        </div>
      </c:forEach>
    </div>
  </div>

  <div class="offer-section rejected">
    <h2>Rejected Offers</h2>
    <div class="offers-grid">
      <c:forEach var="offer" items="${rejectedOffers}">
        <div class="card">
          <div class="card-header">
            <c:out value="${offer.itemName}" />
            <span class="offer-type">${offer.isSentOffer ? 'Sent' : 'Received'}</span>
          </div>
          <div class="card-body">
            <h5 class="card-title">
                ${offer.isSentOffer ? 'Your Message' : 'Message from '.concat(offer.senderName)}
            </h5>
            <p class="card-text"><c:out value="${offer.message}" /></p>
            <div class="meta-info">
              <i class="far fa-clock"></i> ${offer.isSentOffer ? 'Sent' : 'Received'} on: <c:out value="${offer.createdAt}" />
            </div>
            <div class="meta-info">
              <i class="fas fa-user"></i> ${offer.isSentOffer ? 'To: '.concat(offer.recipientName) : 'From: '.concat(offer.senderName)}
            </div>
            <form action="fetchConversation" method="get" target="_blank">
              <input type="hidden" name="exchangeId" value="<c:out value='${offer.exchangeId}' />" />
              <button type="submit" class="btn btn-primary mt-3">View Conversation</button>
            </form>
          </div>
        </div>
      </c:forEach>
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
