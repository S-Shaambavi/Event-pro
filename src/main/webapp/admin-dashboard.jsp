<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.List" %>
<%@ page import="model.*" %>
<% List<ComplaintReply> complaintReplies = (List<ComplaintReply>)
    request.getAttribute("complaintreply");
    List<BookingDetails> bookings = (List<BookingDetails>) request.getAttribute("booking");
%>
<!DOCTYPE html>
<html>

<head>
    <title>Admin Dashboard</title>
    <!-- Font Awesome for icons -->
    <link rel="stylesheet"
        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="style/admin-dashboard.css">
</head>

<body data-context-path="${pageContext.request.contextPath}">
    <%@include file="admin-nav.jsp" %>
        <div class="admin-container">
            <h1><i class="fas fa-tachometer-alt"></i> Admin Dashboard</h1>

            <div class="dashboard-section">
                <h2><i class="fas fa-chart-line"></i> System Overview</h2>
                <div class="stats-container">
                    <div class="stat-card services">
                        <h3><i class="fas fa-concierge-bell"></i> Services</h3>
                        <p>${serviceCount}</p>
                    </div>
                    <div class="stat-card packages">
                        <h3><i class="fas fa-box-open"></i> Packages</h3>
                        <p>${packageCount}</p>
                    </div>
                    <div class="stat-card venues">
                        <h3><i class="fas fa-map-marker-alt"></i> Venues</h3>
                        <p>${venueCount}</p>
                    </div>
                    <div class="stat-card users">
                        <h3><i class="fas fa-users"></i> Users</h3>
                        <p>${userCount}</p>
                    </div>
                    <div class="stat-card complaints">
                        <h3><i class="fas fa-exclamation-circle"></i> Complaints</h3>
                        <p>${complaintCount}</p>
                    </div>
                </div>
            </div>

            <div class="dashboard-section">
                <h2><i class="fas fa-calendar-check"></i> Recent Bookings</h2>
                <div class="table-container">
                    <table>
                        <thead>
                            <tr>
                                <th>Booking ID</th>
                                <th>Customer</th>
                                <th>Package</th>
                                <th>Attendees</th>
                                <th>Venue</th>
                                <th>Status</th>
                                <th>Date</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="book" items="${booking}">
                                <tr>
                                    <td>${book.bookingId}</td>
                                    <td>${book.customer_name}</td>
                                    <td>${book.packageName}</td>
                                    <td>${book.attendeeCount}</td>
                                    <td>${book.packageVenue}</td>
                                    <td>
                                        <span
                                            class="status ${book.paymentStatus.toLowerCase()}">
                                            ${book.paymentStatus}
                                        </span>
                                    </td>
                                    <td>${book.bookingDate}</td>
                                    <td>
                                        <button class="action-btn view-btn"
                                            onclick="viewBooking(${book.bookingId})">
                                            <i class="fas fa-eye"></i>
                                        </button>
                                        <button class="action-btn edit-btn"
                                            onclick="editBooking(${book.bookingId})">
                                            <i class="fas fa-edit"></i>
                                        </button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="dashboard-section">
                <h2><i class="fas fa-comments"></i> Complaint Replies</h2>
                <div class="table-container">
                    <table>
                        <thead>
                            <tr>
                                <th>Complaint ID</th>
                                <th>From</th>
                                <th>To</th>
                                <th>Status</th>
                                <th>Complaint</th>
                                <th>Reply</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="reply" items="${complaintreply}">
                                <tr>
                                    <td>${reply.complaint_id}</td>
                                    <td>${reply.complaint_user}</td>
                                    <td>${reply.replied_user}</td>
                                    <td>
                                        <span
                                            class="status ${reply.complaint_status.toLowerCase()}">
                                            ${reply.complaint_status}
                                        </span>
                                    </td>
                                    <td class="truncate">${reply.complaint_text}</td>
                                    <td class="truncate">${reply.reply_text}</td>
                                    <td>
                                        <a
                                            href="${pageContext.request.contextPath}/ReplyController">
                                            <button class="action-btn view-btn">
                                                <i class="fas fa-eye"></i>
                                            </button>
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
			<!-- Payment Details Section -->
            <div class="dashboard-section">
                <h2><i class="fas fa-money-check-alt"></i> Payment Details</h2>
                <div class="table-container">
                    <table>
                        <thead>
                            <tr>
                                <th>Payment ID</th>
                                <th>Event Name</th>
                                <th>Booking Date</th>
                                <th>Payment Date</th>
                                <th>Status</th>
                                <th>Amount (Rs.)</th>
                                <th>Card Number</th>
                                <th>Expiry</th>
                                <th>CVV</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% List<PaymentDetails> paymentDetails = (List<PaymentDetails>)
                                    request.getAttribute("payments");
                                    if (paymentDetails != null && !paymentDetails.isEmpty()) {
                                    for (PaymentDetails p : paymentDetails) {
                                    %>
                                    <tr>
                                        <td>
                                            <%= p.getPaymentId() %>
                                        </td>
                                        <td>
                                            <%= p.getEventName() %>
                                        </td>
                                        <td>
                                            <%= p.getBookingDate() %>
                                        </td>
                                        <td>
                                            <%= p.getPaymentDate() %>
                                        </td>
                                        <td>
                                        	<span class="status <%= p.getPaymentStatus().toLowerCase() %>">
                                                <%= p.getPaymentStatus() %>
                                            </span>
                                        </td>
                                        <td>
                                            <%= String.format("%.2f", p.getPaymentAmount()) %>
                                        </td>
                                        <td>
                                            <%= p.getCardNumber() %>
                                        </td>
                                        <td>
                                            <%= p.getExpiryDate() %>
                                        </td>
                                        <td>
                                            <%= p.getCardCvv() %>
                                        </td>
                                    </tr>
                                    <% } } else { %>
                                        <tr>
                                            <td colspan="9" style="text-align:center;">No payment records
                                                available.</td>
                                        </tr>
                                        <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
            <button class="back-btn" onclick="goBack()">
                <i class="fas fa-arrow-left"></i> Back
            </button>
        </div>
        <script src="script/admin-dashboard.js"></script>
</body>

</html>