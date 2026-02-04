<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Manage Services</title>
    <link rel="stylesheet" href="style/manageStyle.css">
</head>

<body>
    <%@include file="admin-nav.jsp" %>
        <h2>EventPro Services</h2>
        <a href="create-service.jsp" class="create-btn">Create New Service</a>

        <div class="service-container">
            <c:forEach var="service" items="${serviceList}">
                <div class="service-card">
                    <div class="service-info">
                        <img src="${service.service_image}" alt="Venue Image" class="service-image" />
                        <p>
                            <span class="label">ID:</span> ${service.service_id}
                        </p>
                        <p>
                            <span class="label">Name:</span> ${service.service_name}
                        </p>
                        <p>
                            <span class="label">Description:</span>
                            ${service.service_description}
                        </p>
                        <p>
                            <span class="label">Price:</span> ${service.service_price}
                        </p>
                    </div>
                    <div class="actions">
                        <a
                            href="update-service.jsp?service_id=${service.service_id}&service_name=${service.service_name}&service_description=${service.service_description}&service_price=${service.service_price}">Edit</a>
                        <form action="ServiceController" method="post"
                            onsubmit="return confirm('Are you sure you want to delete this service?')">
                            <input type="hidden" name="action" value="delete"> <input type="hidden"
                                name="service_id" value="${service.service_id}">
                            <input type="submit" value="Delete">
                        </form>
                    </div>
                </div>
            </c:forEach>
        </div>
</body>

</html>