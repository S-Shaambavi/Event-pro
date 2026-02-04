<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Update Organizer</title>
    <link rel="stylesheet" href="style/formStyle.css">
</head>

<body>
    <h2>Update User</h2>

    <form action="UserController" method="post">
        <input type="hidden" name="action" value="update">

        <label for="user_id">User ID:</label>
        <input type="number" id="user_id" name="user_id" value="${param.user_id}" readonly>

        <label for="user_fName">First Name:</label>
        <input type="text" id="user_fName" name="user_fName" value="${param.user_fName}" required>

        <label for="user_lName">Last Name:</label>
        <input type="text" id="user_lName" name="user_lName" value="${param.user_lName}" required>

        <label for="user_dob">Date of Birth:</label>
        <input type="date" id="user_dob" name="user_dob" value="${param.user_dob}" required>

        <label for="user_email">Email:</label>
        <input type="email" id="user_email" name="user_email" value="${param.user_email}" required>

        <label for="user_phone">Phone:</label>
        <input type="tel" id="user_phone" name="user_phone" value="${param.user_phone}" required>

        <label for="user_address">Address:</label>
        <input type="text" id="user_address" name="user_address" value="${param.user_address}" required>

        <label for="user_gender">Gender:</label>
        <select id="user_gender" name="user_gender" required>
            <option value="Male" ${param.user_gender=='Male' ? 'selected' : '' }>Male</option>
            <option value="Female" ${param.user_gender=='Female' ? 'selected' : '' }>Female</option>
            <option value="Other" ${param.user_gender=='Other' ? 'selected' : '' }>Other</option>
        </select>

        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required>

        <label for="user_role">Role:</label>
        <select id="user_role" name="user_role" required>
            <option value="Customer" ${param.user_role=='Customer' ? 'selected' : '' }>Customer</option>
            <option value="Organizer" ${param.user_role=='Organizer' ? 'selected' : '' }>Organizer</option>
            <option value="Admin" ${param.user_role=='Admin' ? 'selected' : '' }>Admin</option>
        </select>

        <label for="user_profile">Profile Image URL:</label>
        <input type="text" id="user_profile" name="user_profile" value="${param.user_profile}">

        <input type="hidden" name="created_at" value="${param.created_at}">

        <input type="submit" value="Update Organizer">
        <script src="script/form-validation.js"></script>
    </form>

    <a href="UserController">Back to User List</a>
</body>

</html>