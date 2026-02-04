<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Update Venue</title>
    <link rel="stylesheet" href="style/formStyle.css">
</head>

<body>
    <h2>Update Venue</h2>

    <form action="VenueController" method="post">
        <input type="hidden" name="action" value="update">

        <label for="venue_id">Venue ID:</label>
        <input type="number" id="venue_id" name="venue_id" value="${param.venue_id}" readonly>

        <label for="venue_name">Venue Name:</label>
        <input type="text" id="venue_name" name="venue_name" value="${param.venue_name}" required>

        <label for="venue_status">Venue Status:</label>
        <select id="venue_status" name="venue_status" required>
            <option value="Available" ${param.venue_status=='Available' ? 'selected' : '' }>Available</option>
            <option value="Booked" ${param.venue_status=='Booked' ? 'selected' : '' }>Booked</option>
        </select>

        <label for="venue_capacity">Capacity:</label>
        <input type="number" id="venue_capacity" name="venue_capacity" value="${param.venue_capacity}" required>

        <label for="venue_cost">Cost:</label>
        <input type="number" id="venue_cost" name="venue_cost" value="${param.venue_cost}" required>

        <label for="venue_image">Image:</label>
        <input type="text" id="venue_image" name="venue_image">

        <input type="submit" value="Update Venue">
    </form>

    <a href="VenueController">Back to venue List</a>
    <script src="script/form-validation.js"></script>
</body>

</html>