<%@ page import="model.*" %>
<%@ page session="true" %>
<% UserProfile user=(UserProfile) session.getAttribute("User"); if (user==null) {
response.sendRedirect("login.jsp"); return; } %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Profile</title>

    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <!-- CSS Styles -->
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f9;
        }

        .profile-container {
            max-width: 600px;
            margin: 50px auto;
            background: #ffffff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .profile-header {
            text-align: center;
            margin-bottom: 20px;
        }

        .name-highlight {
            color: #007bff;
            font-weight: bold;
        }

        .role-badge {
            display: inline-block;
            padding: 5px 10px;
            background-color: #007bff;
            color: #ffffff;
            border-radius: 12px;
            font-size: 0.9em;
        }

        .profile-form,
        #deleteForm {
            margin-top: 20px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
        }

        .animated-input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 1em;
        }

        .animated-input:focus {
            border-color: #007bff;
            outline: none;
            box-shadow: 0 0 4px rgba(0, 123, 255, 0.5);
        }

        .password-group {
            position: relative;
        }

        .password-wrapper {
            display: flex;
            align-items: center;
        }

        .toggle-password {
            background: none;
            border: none;
            color: #007bff;
            font-size: 1.2em;
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
        }

        .editable-wrapper {
            position: relative;
            display: flex;
            align-items: center;
        }

        .editable-wrapper input {
            flex: 1;
            padding-right: 35px;
        }

        .edit-icon {
            position: absolute;
            right: 10px;
            color: #aaa;
            cursor: pointer;
            transition: color 0.3s;
        }

        .editable-wrapper input.editing {
            border-color: #28a745;
            box-shadow: 0 0 4px rgba(40, 167, 69, 0.5);
        }

        .edit-icon.active {
            color: #28a745;
        }

        .update-btn,
        .delete-btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            background-color: #007bff;
            color: #ffffff;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 1em;
            margin-top: 10px;
            text-decoration: none;
            transition: background 0.3s;
        }

        .delete-btn {
            background-color: #dc3545;
        }

        .update-btn span,
        .delete-btn span {
            margin-right: 5px;
        }

        .update-btn:hover {
            background-color: #0056b3;
        }

        .delete-btn:hover {
            background-color: #c82333;
        }

        .fa-trash-alt,
        .fa-arrow-right {
            margin-left: 5px;
        }

        .back-btn {
            background-color: #7f8c8d;
            color: white;
            padding: 8px 16px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            margin: 20px;
            display: inline-block;
        }

        .back-btn:hover {
            background-color: #95a5a6;
        }
    </style>
</head>

<body>
	<button class="back-btn" onclick="goBack()">
        <i class="fas fa-arrow-left"></i> Back
    </button>
    
    <div class="profile-container">
        <div class="profile-header">
            <h1>Welcome, <span class="name-highlight">
                    <%= user.getFirstName() %>
                        <%= user.getLastName() %>
                </span>!</h1>
            <p class="role-badge">
                <%= user.getRole() %>
            </p>
        </div>

        <form action="UpdateProfile" method="POST" class="profile-form">
            <div class="form-group editable-group">
                <label>First Name</label>
                <div class="editable-wrapper">
                    <input type="text" name="firstName" value="<%= user.getFirstName() %>"
                        class="animated-input" readonly>
                    <i class="fas fa-pen edit-icon"></i>
                </div>
            </div>
            <div class="form-group editable-group">
                <label>Last Name</label>
                <div class="editable-wrapper">
                    <input type="text" name="lastName" value="<%= user.getLastName() %>"
                        class="animated-input" readonly>
                    <i class="fas fa-pen edit-icon"></i>
                </div>
            </div>
            <div class="form-group editable-group">
                <label>Phone</label>
                <div class="editable-wrapper">
                    <input type="text" name="phone" value="<%= user.getPhone() %>" class="animated-input"
                        readonly>
                    <i class="fas fa-pen edit-icon"></i>
                </div>
            </div>
            <div class="form-group editable-group">
                <label>Address</label>
                <div class="editable-wrapper">
                    <input type="text" name="address" value="<%= user.getAddress() %>"
                        class="animated-input" readonly>
                    <i class="fas fa-pen edit-icon"></i>
                </div>
            </div>
            <div class="form-group password-group editable-group">
                <label>Password</label>
                <div class="editable-wrapper password-wrapper">
                    <input type="password" name="password" value="<%= user.getPassword() %>"
                        class="animated-input" id="passwordField" readonly>
                    <button type="button" class="toggle-password"><i class="fas fa-eye"></i></button>
                    <i class="fas fa-pen edit-icon" style="right: 35px;"></i>
                </div>
            </div>

            <button type="submit" class="update-btn">
                <span>Update Profile</span>
                <i class="fas fa-arrow-right"></i>
            </button>
        </form>

        <form id="deleteForm" action="DeleteAccount" method="POST">
            <button type="button" class="delete-btn" onclick="return confirmDelete()">
                <span>Delete Account</span>
                <i class="fas fa-trash-alt"></i>
            </button>
        </form>
    </div>

    <!-- JavaScript -->
    <script>
        function goBack() {
            if (window.history.length > 1) {
                window.history.back();
            } else {
                window.location.href = '${pageContext.request.contextPath}/AdminController';
            }
        }
        document.querySelectorAll('.edit-icon').forEach(icon => {
            icon.addEventListener('click', () => {
                const input = icon.parentElement.querySelector('input');
                if (input.hasAttribute('readonly')) {
                    input.removeAttribute('readonly');
                    input.classList.add('editing');
                    icon.classList.add('active');
                    input.focus();
                } else {
                    input.setAttribute('readonly', true);
                    input.classList.remove('editing');
                    icon.classList.remove('active');
                }
            });
        });
        function confirmDelete() {
            if (confirm("Are you sure you want to delete your account? This action cannot be undone.")) {
                document.getElementById("deleteForm").submit();
            }
        }
    </script>

</body>

</html>