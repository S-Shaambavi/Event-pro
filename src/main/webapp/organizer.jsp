<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.ComplaintReply,model.BookingDetails,model.Team,model.PaymentDetails" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>EventPro - Organizer Dashboard</title>
    <link rel="stylesheet"
        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" />
    <link rel="stylesheet" href="style/Organizer.css">
</head>

<body>
    <div class="dashboard-container">
        <!-- Sidebar -->
        <div class="sidebar">
            <div class="sidebar-header">
                <h2>EventPro</h2>
                <p>Organizer Dashboard</p>
            </div>
            <div class="sidebar-menu">
                <a href="OrganizerController" class="menu-item active">
                    <i class="fas fa-tachometer-alt"></i> Dashboard
                </a>
                <a href="#booking" class="menu-item">
                    <i class="fas fa-calendar-alt"></i> Events
                </a>
                <a href="#teams" class="menu-item">
                    <i class="fas fa-users"></i> Teams
                </a>
                <a href="#complaints" class="menu-item">
                    <i class="fas fa-comments"></i> Complaints
                </a>
                <a href="#paymentDetails" class="menu-item">
                    <i class="fas fa-money-check-alt"></i> PaymentDetails
                </a>
                <c:if test="${not empty sessionScope.user_email}">
                    <a href="logout" class="menu-item">
                        <i class="fas fa-sign-out-alt"></i> LogOut
                    </a>
                </c:if>
            </div>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <div class="header">
                <h1>Dashboard Overview</h1>
                <div class="user-info">
                    <img src="assets/default-avatar.webp" alt="User">
                    <span>Welcome, ${sessionScope.user_email}</span>
                </div>
            </div>

            <!-- Stats Cards -->
            <div class="stats-container">
                <div class="stat-card">
                    <h3>Total Bookings</h3>
                    <div class="value">24</div>
                    <div class="trend up">
                        <i class="fas fa-arrow-up"></i> 12% from last month
                    </div>
                </div>
                <div class="stat-card">
                    <h3>Active Teams</h3>
                    <div class="value">8</div>
                    <div class="trend up">
                        <i class="fas fa-arrow-up"></i> 3% from last month
                    </div>
                </div>
                <div class="stat-card">
                    <h3>Pending Complaints</h3>
                    <div class="value">5</div>
                    <div class="trend down">
                        <i class="fas fa-arrow-down"></i> 20% from last month
                    </div>
                </div>
                <div class="stat-card">
                    <h3>Revenue</h3>
                    <div class="value">$12,450</div>
                    <div class="trend up">
                        <i class="fas fa-arrow-up"></i> 8% from last month
                    </div>
                </div>
            </div>

            <!-- Bookings Section -->
            <div class="section" id="booking">
                <div class="section-header">
                    <h2>Recent Bookings</h2>
                </div>
                <div class="table-responsive">
                    <table>
                        <thead>
                            <tr>
                                <th>Booking ID</th>
                                <th>Customer</th>
                                <th>Package</th>
                                <th>Attendees</th>
                                <th>Date</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% List<BookingDetails> bookings = (List<BookingDetails>)
                                    request.getAttribute("bookings");
                                    if (bookings != null) {
                                    for (BookingDetails b : bookings) {
                                    %>
                                    <tr>
                                        <td>
                                            <%= b.getBookingId() %>
                                        </td>
                                        <td>
                                            <%= b.getCustomer_name() %>
                                        </td>
                                        <td>
                                            <%= b.getPackageName() %>
                                        </td>
                                        <td>
                                            <%= b.getAttendeeCount() %>
                                        </td>
                                        <td>
                                            <%= b.getBookingDate() %>
                                        </td>
                                        <td>
                                            <span class="status <%= b.getPaymentStatus() %>">
                                                <%= b.getPaymentStatus() %>
                                            </span>
                                        </td>
                                    </tr>
                                    <% } } else { %>
                                        <tr>
                                            <td colspan="7" style="text-align:center;">No bookings
                                                available.</td>
                                        </tr>
                                        <% } %>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Teams Section -->
            <div class="section" id="teams">
                <div class="section-header">
                    <h2>Your Teams</h2>
                    <a href="TeamController" class="btn">
                        <i class="fas fa-users-cog"></i> Manage Teams
                    </a>
                </div>
                <div class="table-responsive">
                    <table>
                        <thead>
                            <tr>
                                <th>Team ID</th>
                                <th>Team Name</th>
                                <th>Workers</th>
                                <th>Assigned To</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% List<Team> teams = (List<Team>) request.getAttribute("teams");
                                    if (teams != null) {
                                    for (Team t : teams) {
                                    %>
                                    <tr>
                                        <td>
                                            <%= t.getTeamId() %>
                                        </td>
                                        <td>
                                            <%= t.getTeamName() %>
                                        </td>
                                        <td>
                                            <%= t.getNoOfWorkers() %>
                                        </td>
                                        <td>Booking No <%= t.getBooking_id() %>
                                        </td>
                                        <td>
                                            <a href="TeamController" class="btn btn-secondary"
                                                style="padding: 5px 10px; font-size: 0.8rem;">
                                                <i class="fas fa-edit"></i> Edit
                                            </a>
                                        </td>
                                    </tr>
                                    <% } } else { %>
                                        <tr>
                                            <td colspan="5" style="text-align:center;">No teams available.
                                            </td>
                                        </tr>
                                        <% } %>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Complaints Section -->
<div class="section" id="complaints">
    <div class="section-header">
        <h2>Recent Complaints</h2>
    </div>
    <div class="table-responsive">
        <table>
            <thead>
                <tr>
                    <th>Complaint ID</th>
                    <th>From</th>
                    <th>Status</th>
                    <th>Message</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<ComplaintReply> complaintreplies = (List<ComplaintReply>) request.getAttribute("complaintReplies");
                    if (complaintreplies != null && !complaintreplies.isEmpty()) {
                        for (ComplaintReply c : complaintreplies) {
                %>
                    <tr>
                        <td><%= c.getComplaint_id() %></td>
                        <td><%= c.getComplaint_user() %></td>
                        <td>
                            <span class="status <%= c.getComplaint_status() %>">
                                <%= c.getComplaint_status() %>
                            </span>
                        </td>
                        <td>
                            <%= c.getComplaint_text().length() > 50 ?
                                    c.getComplaint_text().substring(0, 50) + "..." :
                                    c.getComplaint_text() %>
                        </td>
                        <td>
                            <!-- Reply Button -->
                            <a href="manage-replies.jsp" class="btn btn-secondary"
                               style="padding: 5px 10px; font-size: 0.8rem;">
                                <i class="fas fa-comment-dots"></i> Reply
                            </a>

                            <!-- Delete Button -->
                            <button class="btn btn-danger"
                                    style="padding: 5px 10px; font-size: 0.8rem;"
                                    onclick="confirmDelete(<%= c.getComplaint_id() %>)">
                                <i class="fas fa-trash-alt"></i> Delete
                            </button>
                        </td>
                    </tr>
                <%
                        }
                    } else {
                %>
                    <tr>
                        <td colspan="5" style="text-align:center;">No complaints available.</td>
                    </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>
</div>

<!-- Confirmation script -->
<script>
    function confirmDelete(id) {
        if (confirm("Are you sure you want to delete this complaint?")) {
            window.location.href = "manage-replies.jsp" ;
        }
    }
</script>


            <!-- Payment Details Section -->
            <div class="section" id="paymentDetails">
                <div class="section-header">
                    <h2>Payment Details</h2>
                </div>
                <div class="table-responsive">
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
                                        <td><span class="status <%= p.getPaymentStatus() %>">
                                                <%= p.getPaymentStatus() %>
                                            </span></td>
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

        </div>
    </div>
</body>

</html>