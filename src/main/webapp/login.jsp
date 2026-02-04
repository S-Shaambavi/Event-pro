<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Login EventPro</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/style/login.css">
</head>

<body>
    <div class="login-container">
        <h1>Login</h1>
        <form id="loginForm" action="LoginServlet" method="POST">
            <label for="email">Email:</label>
            <input type="email" id="email" name="user_email" required>

            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>

            <button type="submit">Login</button>

            <p id="message">
                <% String error=request.getParameter("error"); 
                if ("invalid".equals(error)) { 
                	out.print("Invalid email or password."); 
               	} else if ("empty".equals(error)) { 
               		out.print("Please enter both email and password."); 
             	} else if ("db".equals(error)) { 
             		out.print("Database connection error."); 
             	} %>
            </p>

            <!-- Signup link -->
            <p style="margin-top: 20px;">
                Don't have an account?
                <a href="signup.jsp" style="color: #007bff; text-decoration: none;">Create one</a>
            </p>
        </form>
    </div>
    <script >
    
    document.addEventListener('DOMContentLoaded', function() {
        const loginForm = document.getElementById('loginForm');
        const emailInput = document.getElementById('email');
        const passwordInput = document.getElementById('password');
        const messageElement = document.getElementById('message');

        // Clear any existing message after 5 seconds
        if (messageElement.textContent.trim() !== '') {
            setTimeout(() => {
                messageElement.textContent = '';
            }, 5000);
        }

        loginForm.addEventListener('submit', function(e) {
            e.preventDefault();
            
            // Clear previous messages
            messageElement.textContent = '';
            messageElement.style.color = '#e74c3c';
            
            // Get form values
            const email = emailInput.value.trim();
            const password = passwordInput.value.trim();
            
            // Simple client-side validation
            if (!email || !password) {
                messageElement.textContent = 'Please enter both email and password.';
                return;
            }
            
            if (!isValidEmail(email)) {
                messageElement.textContent = 'Please enter a valid email address.';
                return;
            }
            
            // If validation passes, submit the form
            this.submit();
        });
        
        // Helper function to validate email format
        function isValidEmail(email) {
            const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            return re.test(email);
        }
        
        // Add animation class when inputs are focused
        const inputs = [emailInput, passwordInput];
        inputs.forEach(input => {
            input.addEventListener('focus', function() {
                this.parentElement.classList.add('focused');
            });
            
            input.addEventListener('blur', function() {
                this.parentElement.classList.remove('focused');
            });
        });
    });
    </script>
</body>

</html>