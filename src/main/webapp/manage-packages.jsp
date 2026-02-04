<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Manage Packages</title>
    <link rel="stylesheet" href="style/manageStyle.css">
</head>

<body>
    <%@include file="admin-nav.jsp" %>
        <h2>EventPro Packages</h2>

        <c:if test="${not empty message}">
            <div class="success-msg">${message}</div>
        </c:if>

        <a href="create-package.jsp" class="create-btn">Create New Package</a>

        <div class="package-container">
            <c:forEach var="pack" items="${packageList}">
                <div class="package-card">
                    <div class="package-info">
                        <p><span class="label">Package ID:</span>
                            <c:out value="${pack.package_id}" />
                        </p>
                        <p><span class="label">Package Name:</span>
                            <c:out value="${pack.package_name}" />
                        </p>
                        <p><span class="label">Package Attendees:</span>
                            <c:out value="${pack.attendee_count}" />
                        </p>
                        <p><span class="label">Package Creator:</span>
                            <c:out value="${pack.package_creator}" />
                        </p>
                        <p><span class="label">Package Venue:</span>
                            <c:out value="${pack.package_venue}" />
                        </p>
                        <p><span class="label">Package Cost:</span>
                            <c:out value="${pack.package_cost}" />
                        </p>
                    </div>
                    <div class="actions">
                        <a
                            href="update-package.jsp?package_id=${pack.package_id}&package_name=${pack.package_name}&attendee_count=${pack.attendee_count}&package_cost=${pack.package_cost}&package_creator=${pack.package_creator}">Edit</a>
                        <form action="PackageController" method="post"
                            onsubmit="return confirm('Are you sure you want to delete this package?')">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="package_id" value="${pack.package_id}">
                            <input type="submit" value="Delete">
                        </form>
                    </div>
                </div>
            </c:forEach>
        </div>
</body>

</html>