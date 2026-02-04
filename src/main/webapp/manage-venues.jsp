<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Manage Venues</title>
    <link rel="stylesheet" href="style/manageStyle.css">
</head>

<body>
    <%@include file="admin-nav.jsp" %>
        <h2>EventPro Venue</h2>
        <a href="create-venue.jsp" class="create-btn">Create New venue</a>

        <div class="venue-container">
            <c:forEach var="venue" items="${venueList}">
                <div class="venue-card">
                    <div class="venue-info">
                        <img src="${venue.venue_image}" alt="Venue Image" class="venue-image" />
                        <p>
                            <span class="label">ID:</span> ${venue.venue_id}
                        </p>
                        <p>
                            <span class="label">Name:</span> ${venue.venue_name}
                        </p>
                        <p>
                            <span class="label">Status:</span> ${venue.venue_status}
                        </p>
                        <p>
                            <span class="label">Capacity:</span> ${venue.venue_capacity}
                        </p>
                        <p>
                            <span class="label">Cost:</span> ${venue.venue_cost}
                        </p>
                    </div>
                    <div class="actions">
                        <a
                            href="update-venue.jsp?venue_id=${venue.venue_id}&venue_name=${venue.venue_name}&venue_status=${venue.venue_status}&venue_capacity=${venue.venue_capacity}&venue_cost=${venue.venue_cost}">Edit</a>
                        <form action="VenueController" method="post"
                            onsubmit="return confirm('Are you sure you want to delete this venue?')">
                            <input type="hidden" name="action" value="delete"> <input type="hidden"
                                name="venue_id" value="${venue.venue_id}">
                            <input type="submit" value="Delete">
                        </form>
                    </div>
                </div>
            </c:forEach>
        </div>
</body>

</html>