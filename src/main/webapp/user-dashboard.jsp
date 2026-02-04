<%@ page import="java.util.*, model.UserData" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:if test="${empty sessionScope.user_email}">
    <c:redirect url="login.jsp" />
</c:if>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Dashboard | Event Management System</title>

    <!-- Favicon -->
    <link rel="icon" href="${pageContext.request.contextPath}/assets/favicon.ico" type="image/x-icon">

    <!-- Font Awesome for icons -->
    <link rel="stylesheet"
        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <link rel="stylesheet" href="style/user-dashboard.css">
</head>

<body>
    <jsp:include page="header.jsp" />

    <div class="container">
        <h1>
            <i class="fas fa-tachometer-alt"></i> Dashboard
        </h1>

        <div class="welcome-section">
            <div class="welcome-message">
                Welcome back, <strong>${sessionScope.user_email}</strong>!
                <c:if test="${not empty sessionScope.last_login}">
                    <br><small>Last login:
                        <fmt:formatDate value="${sessionScope.last_login}"
                            pattern="MMM dd, yyyy hh:mm a" />
                    </small>
                </c:if>
            </div>
            <div class="quick-actions">
                <a href="PackageServlet" class="btn btn-primary">
                    <i class="fas fa-plus"></i> New Booking
                </a>
                <a href="UserProfile.jsp" class="btn btn-secondary">
                    <i class="fas fa-user-cog"></i> Profile
                </a>
            </div>
        </div>

        <div class="slideshow-container">
            <div class="slides">
                <img src="${pageContext.request.contextPath}/assets/promotion.webp"
                    alt="Special Promotion">
            </div>
            <div class="slides">
                <img src="${pageContext.request.contextPath}/assets/scheduling.webp"
                    alt="Easy Scheduling">
            </div>
            <div class="slides">
                <img src="${pageContext.request.contextPath}/assets/ticketing.webp"
                    alt="Online Ticketing">
            </div>
        </div>

        <div class="dashboard-grid">
            <div class="bookings-section">
                <h2 class="section-title">
                    <i class="fas fa-calendar-check"></i> Your Bookings
                </h2>

                <c:choose>
                    <c:when test="${not empty requestScope.dashboardData}">
                        <c:forEach var="data" items="${requestScope.dashboardData}">
                            <div class="booking-card">
                                <div class="booking-header">
                                    <span class="booking-id">Booking #${data.bookingId}</span>
                                    <span class="booking-date">
                                        ${data.bookingDate}
                                    </span>
                                </div>

                                <table class="booking-details">
                                    <tr>
                                        <th>Package</th>
                                        <td>${data.packageName}</td>
                                    </tr>
                                    <tr>
                                        <th>Attendees</th>
                                        <td>${data.attendeeCount}</td>
                                    </tr>
                                    <tr>
                                        <th>Venue</th>
                                        <td>${data.venueName}</td>
                                    </tr>
                                    <tr>
                                        <th>Service</th>
                                        <td>${data.serviceName}</td>
                                    </tr>
                                </table>

                                <div class="payment-details">
                                    <table class="booking-details">
                                        <tr>
                                            <th colspan="2">
                                                <i class="fas fa-credit-card"></i> Payment Details
                                            </th>
                                        </tr>
                                        <tr>
                                            <td>Payment Date</td>
                                            <td>
                                                ${data.paymentDate}
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Status</td>
                                            <td>
                                                <span
                                                    class="status-badge status-${data.paymentStatus.toLowerCase()}">
                                                    ${data.paymentStatus}
                                                </span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Amount</td>
                                            <td>
                                                <fmt:formatNumber value="${data.paymentAmount}"
                                                    type="currency" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>

                                <c:if test="${not empty data.replyText}">
                                    <div class="organizer-reply">
                                        <table class="booking-details">
                                            <tr>
                                                <th colspan="2">
                                                    <i class="fas fa-comment-dots"></i> Organizer Reply
                                                </th>
                                            </tr>
                                            <tr>
                                                <td>Message</td>
                                                <td>${data.replyText}</td>
                                            </tr>
                                            <tr>
                                                <td>Replied At</td>
                                                <td>
                                                    ${data.repliedAt}
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </c:if>
                                
                                <!-- Make Complaint Button -->
								<form action="ComplaintServlet" method="post" style="margin-top: 15px;">
								    <input type="hidden" name="bookingId" value="${data.bookingId}" />
								    <button type="submit" class="complaint-btn">
								        🚨 Make Complaint
								    </button>
								</form>
                                
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="no-bookings">
                            <i class="far fa-calendar-times fa-3x"
                                style="color: #b2dfdb; margin-bottom: 15px;"></i>
                            <h3>No Bookings Found</h3>
                            <p>You haven't made any bookings yet. Start by creating a new booking!</p>
                            <a href="booking.jsp" class="btn btn-primary" style="margin-top: 15px;">
                                <i class="fas fa-plus"></i> Create Booking
                            </a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="sidebar-widgets">
                <div class="widget clock">
                    <div id="clock"></div>
                    <div id="date" style="font-size: 1rem; margin-top: 5px;"></div>
                </div>

                <div class="widget calendar">
                    <div class="calendar-header">
                        <h3 class="calendar-title" id="monthYear"></h3>
                        <div class="calendar-controls">
                            <button onclick="changeMonth(-1)">
                                <i class="fas fa-chevron-left"></i>
                            </button>
                            <button onclick="changeMonth(1)">
                                <i class="fas fa-chevron-right"></i>
                            </button>
                        </div>
                    </div>
                    <div id="calendarGrid" class="calendar-grid"></div>
                </div>

                <div class="widget">
                    <h3><i class="fas fa-bullhorn"></i> Announcements</h3>
                    <p>Check back soon for updates and announcements about our services.</p>
                </div>
            </div>
        </div>
    </div>

    <script src="script/user-dashboard.js">
    </script>
    <jsp:include page="footer.jsp" />
</body>

</html>