<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Create Package</title>
    <link rel="stylesheet" href="style/formStyle.css">
</head>

<body>
    <h2>Create Package</h2>

    <form action="PackageController" method="post">
        <input type="hidden" name="action" value="create">

        <label for="package_name">Package Name:</label>
        <input type="text" id="package_name" name="package_name" required>

        <label for="attendee_count">Attendee Count:</label>
        <input type="number" id="attendee_count" name="attendee_count" required>
        
        <input type="hidden" name="package_creator" value="${sessionScope.user_email}">

        <label for="package_venue">Venue:</label>
        <input type="number" id="package_venue" name="package_venue" required>

        <label for="package_cost">Package Cost:</label>
        <input type="number" id="package_cost" name="package_cost" required>

        <input type="submit" value="Create Package">
    </form>

    <a href="PackageController">Back to Package List</a>
    <script src="script/form-validation.js"></script>
</body>

</html>