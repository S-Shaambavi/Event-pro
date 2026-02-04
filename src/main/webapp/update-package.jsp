<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Update Package</title>
    <link rel="stylesheet" href="style/formStyle.css">
</head>

<body>
    <h2>Update Package</h2>

    <form action="PackageController" method="post">
        <input type="hidden" name="action" value="update">

        <label for="package_id">Package ID:</label>
        <input type="number" id="package_id" name="package_id" value="${param.package_id}" readonly>

        <label for="package_name">Package Name:</label>
        <input type="text" id="package_name" name="package_name" value="${param.package_name}" required>

        <label for="attendee_count">Attendee Count:</label>
        <input type="number" id="attendee_count" name="attendee_count" value="${param.attendee_count}" min="1" required>

        <label for="package_creator">Package Creator:</label>
        <input type="number" id="package_creator" name="package_creator" value="${param.package_creator}" required>

        <label for="package_venue">Venue:</label>
        <input type="number" id="package_venue" name="package_venue" value="${param.package_venue}" required>

        <label for="package_cost">Package Cost:</label>
        <input type="text" id="package_cost" name="package_cost" value="${param.package_cost}" min="0" step="0.01"
            required>

        <input type="submit" value="Update Package">
    </form>

    <a href="PackageController">Back to Package List</a>
    <script src="script/form-validation.js"></script>
</body>

</html>