<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Signup_Page</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/style/signup.css">
</head>

<body
    style="background: url('<%=request.getContextPath()%>/image/wedding-room-with-stage-space-with-flowers-pink-walls-lighting_398492-4358.jpg') no-repeat center center fixed; background-size: cover;">
    <div class="overlay" id="overlay">
        <div class="signup-box">
            <h2>Signup</h2>

            <!-- Show error message if exists -->
            <% String error=request.getParameter("error"); if (error !=null) { %>
                <div class="error-message">
                    <%= error %>
                </div>
            <% } %>

            <form name="signupForm" action="Signup" method="post" onsubmit="return validateForm()">
                <div class="input-container">
                    <input type="text" name="firstName" placeholder="First Name" required>
                </div>
                <div class="input-container">
                    <input type="text" name="lastName" placeholder="Last Name" required>
                </div>
                <div class="input-container" style="display: flex; align-items: center; gap: 15px;">
                    <label style="color: white; font-weight: bold;">Gender:</label>
                    <div style="color: black;">
                        <input type="radio" id="male" name="gender" value="Male" required>
                        <label for="male">Male</label>
                    </div>
                    <div style="color: black;">
                        <input type="radio" id="female" name="gender" value="Female" required>
                        <label for="female">Female</label>
                    </div>
                    <div style="color: black;">
                        <input type="radio" id="other" name="gender" value="Other" required>
                        <label for="other">Other</label>
                    </div>
                </div>
                <div class="input-container">
                    <input type="date" name="dob" required>
                </div>
                <div class="input-container">
                    <input type="tel" name="phone" placeholder="Phone Number" required>
                </div>
                <div class="input-container">
                    <input type="text" name="address" placeholder="Address" required>
                </div>
                <div class="input-container">
                    <input type="email" name="email" placeholder="Email" required>
                </div>
                <div class="input-container">
                    <input type="password" name="password" placeholder="Password" required>
                </div>
                <div class="input-container">
                    <input type="password" name="confirmPassword" placeholder="Confirm Password" required>
                </div>
                <button type="submit" class="signup-btn">Signup</button>
            </form>
        </div>
    </div>
    <!-- Correct script path -->
    <script src="<%=request.getContextPath()%>/script/signup.js"></script>
</body>

</html>