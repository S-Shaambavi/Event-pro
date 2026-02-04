<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Create Service</title>
    <link rel="stylesheet" href="style/formStyle.css">
</head>

<body>
    <h2>Create New Service</h2>

    <form action="ServiceController" method="post">
        <input type="hidden" name="action" value="create">

        <label for="service_name">Service Name:</label>
        <input type="text" id="service_name" name="service_name" required>

        <label for="service_description">Service Description:</label>
        <input type="text" id="service_description" name="service_description" required>

        <label for="service_price">Service Price:</label>
        <input type="number" id="service_price" name="service_price" required>

        <label for="service_image">Service Image:</label>
        <input type="text" id="service_image" name="service_image" required>

        <input type="submit" value="Create Service">
    </form>

    <a href="ServiceController">Back to Package List</a>
    <script src="script/form-validation.js"></script>
</body>

</html>