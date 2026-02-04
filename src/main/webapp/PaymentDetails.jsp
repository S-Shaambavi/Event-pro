<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.PaymentDetails" %>
<%@ page import="java.util.List" %>

<html>

<head>
    <title>Payment Details</title>
    <link rel="stylesheet" href="style/PaymentDetails.css">
</head>

<body>
    <%-- Error message display --%>
    <% if (request.getAttribute("error") !=null) { %>
    <div class="error">
        <%= request.getAttribute("error") %>
    </div>
    <% } %>

    <h2>Payment Details</h2>
    <div class="card-container">
        <% List<PaymentDetails> payments = (List<PaymentDetails>) request.getAttribute("payments");
            if (payments != null && !payments.isEmpty()) {
            for (PaymentDetails pd : payments) {
        %>
        <div class="card">
            <h3>Payment ID: <%= pd.getPaymentId() %>
            </h3>
            <p><strong>Event Name:</strong>
                <%= pd.getEventName() %>
            </p>
            <p><strong>Booking Date:</strong>
                <%= pd.getBookingDate() %>
            </p>
            <p><strong>Paid Date:</strong>
                <%= pd.getPaymentDate() %>
            </p>
            <p><strong>Amount:</strong> LKR<%= pd.getPaymentAmount() %>
            </p>
            <p><strong>Card Number:</strong> **** **** **** <%= pd.getCardNumber() !=null &&
                    pd.getCardNumber().length()> 4 ?
                    pd.getCardNumber().substring(pd.getCardNumber().length() - 4) : "****" %></p>
            <p><strong>Status:</strong>
                <span class="<%= pd.getPaymentStatus().toLowerCase() %>">
                    <%= pd.getPaymentStatus() %>
                </span>
            </p>
        </div>
    <% } } else { %>
        <div class="no-records">No payment records found.</div>
    <% } %>
    </div>

    <script src="script/PaymentDetails.js"></script>
</body>

</html>