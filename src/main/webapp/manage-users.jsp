<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Manage Users</title>
    <link rel="stylesheet" href="style/manageStyle.css">
</head>

<body>
    <%@include file="admin-nav.jsp" %>
        <h2>EventPro Users</h2>
        <a href="create-user.jsp" class="create-btn">Create New User</a>

        <div class="user-container">
            <c:forEach var="user" items="${userList}">
                <div class="user-card">
                    <div class="user-info">
                        <img src="${user.user_profile}" alt="Profile">
                        <p><span class="label">ID:</span> ${user.user_id}</p>

                        <p><span class="label">First Name:</span> ${user.user_fName}</p>
                        <p><span class="label">Last Name:</span> ${user.user_lName}</p>
                        <p><span class="label">Email:</span> ${user.user_email}</p>
                        <p><span class="label">Phone:</span> ${user.user_phone}</p>
                        <p><span class="label">Address:</span> ${user.user_address}</p>
                        <p><span class="label">Gender:</span> ${user.user_gender}</p>
                        <p><span class="label">Created At:</span> ${user.created_at}</p>
                        <p><span class="label">Role:</span> ${user.user_role}</p>
                    </div>

                    <div class="actions">
                        <a href="update-user.jsp?user_id=${user.user_id}
                &user_fName=${user.user_fName}
                &user_lName=${user.user_lName}
                &user_dob=${user.user_dob}
                &user_email=${user.user_email}
                &user_phone=${user.user_phone}
                &user_address=${user.user_address}
                &user_gender=${user.user_gender}
                &user_role=${user.user_role}
                &created_at=${user.created_at}
                &user_profile=${user.user_profile}">
                            Edit
                        </a>

                        <form action="UserController" method="post"
                            onsubmit="return confirm('Are you sure you want to delete this user?')">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="user_id" value="${user.user_id}">
                            <input type="submit" value="Delete">
                        </form>
                    </div>

                </div>
            </c:forEach>
        </div>
</body>

</html>