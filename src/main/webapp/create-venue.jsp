<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Create Venue</title>
    <link rel="stylesheet" href="style/formStyle.css">
</head>

<body>
    <h2>Create New Venue</h2>

    <form action="VenueController" method="post">
        <input type="hidden" name="action" value="create">

        <label for="venue_name">Venue Name:</label>
        <input type="text" id="venue_name" name="venue_name" required>

        <label for="venue_status">Venue Status:</label>
        <select id="venue_status" name="venue_status" required>
            <option value="Available" selected>Available</option>
            <option value="Booked">Booked</option>
        </select>

        <label for="venue_capacity">Venue Capacity:</label>
        <input type="number" id="venue_capacity" name="venue_capacity" required>
        
        <label for="venue_cost">Venue Cost:</label>
        <input type="number" id="venue_cost" name="venue_cost" required>

        <label for="venue_image">Venue Image:</label>
        <input type="text" id="venue_image" name="venue_image" required>

        <input type="submit" value="Create Venue">
    </form>

    <a href="VenueController">Back to Venue List</a>
    <script src="script/form-validation.js"></script>
</body>

</html>