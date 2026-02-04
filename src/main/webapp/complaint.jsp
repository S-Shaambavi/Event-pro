<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <title>Submit Complaint</title>
    <link rel="stylesheet" href="style/complaint.css">
</head>
<body>

<c:if test="${not empty message}">
    <div class="alert">
        ${message}
    </div>
</c:if>

<div class="complaint-container">
    <h2>Event Details</h2>

    <div class="event-details">
        <div class="detail-row">
            <span class="detail-label">Event Name:</span>
            <span class="detail-value">
                <c:out value="${complaint.eventName != null ? complaint.eventName : 'N/A'}"/>
            </span>
        </div>
        <div class="detail-row">
            <span class="detail-label">Event Date:</span>
            <span class="detail-value">
                <c:choose>
                    <c:when test="${not empty complaint.eventDate}">
                        <fmt:formatDate value="${complaint.eventDate}" pattern="yyyy-MM-dd"/>
                    </c:when>
                    <c:otherwise>N/A</c:otherwise>
                </c:choose>
            </span>
        </div>
    </div>

    <form action="ComplaintServlet" method="post">
        <input type="hidden" name="bookingId" value="${complaint.bookingId}" />
        <input type="hidden" name="userId" value="${complaint.userId}" />

        <div class="form-group">
            <label for="complaintDescription">Describe Your Complaint:</label><br>
            <textarea id="complaintDescription" name="complaintDescription" rows="5" cols="50" required></textarea>
        </div>

        <button type="submit">Submit Complaint</button>
    </form>
</div>

</body>
</html>