<%@ page import="java.util.*, model.PackageView" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% String user=(String) session.getAttribute("username"); %>

<!DOCTYPE html>
<html>

<head>
    <title>Select Event Package</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f5f5f5;
            margin: 0;
        }

        .container {
            margin-top: 70px;
        }

        h1 {
            text-align: center;
            padding: 20px;
            color: #333;
        }

        .pack-container {

            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
            gap: 1.5rem;
            padding: 20px 40px;
        }

        .package-card {
            background-color: white;
            border-radius: 15px;
            padding: 1.5rem;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        .package-card h2 {
            margin-top: 0;
        }

        .package-card ul {
            padding-left: 18px;
        }

        .select-btn {
            margin-top: 1rem;
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }

        .select-btn:hover {
            background-color: #0056b3;
        }

        .custom-package-card {
            background-color: #17a2b8;
            color: white;
            text-align: center;
            padding: 2rem;
            border-radius: 15px;
        }

        .custom-package-card button {
            margin-top: 1rem;
            background-color: white;
            color: #17a2b8;
            border: none;
            padding: 10px 18px;
            border-radius: 6px;
            cursor: pointer;
            font-weight: bold;
        }

        .custom-package-card button:hover {
            background-color: #e2e6ea;
        }
    </style>
</head>

<body>
    <%@include file="header.jsp" %>
        <div class="container">
            <h1>Select Your Event Package</h1>
            <div class="pack-container">

                <!-- Loop through predefined packages -->
                <c:forEach var="pkg" items="${packages}">
                    <div class="package-card">
                        <h2>${pkg.packageName}</h2>
                        <p><strong>Venue:</strong> ${pkg.venueName} (Capacity: ${pkg.venueCapacity})</p>
                        <p><strong>Cost:</strong> Rs. ${pkg.venueCost}</p>
                        <p><strong>Attendees:</strong> ${pkg.attendeeCount}</p>
                        <p><strong>Services Included:</strong></p>
                        <ul>
                            <c:forEach var="service" items="${pkg.services}">
                                <li>${service}</li>
                            </c:forEach>
                        </ul>
                        <form action="${pageContext.request.contextPath}/BookingFormServlet" method="post">
                            <input type="hidden" name="package_id" value="${pkg.packageId}">
                            <button type="submit" class="select-btn">Book Now</button>
                        </form>

                    </div>
                </c:forEach>

                <!-- Custom Package Card -->
                <div class="custom-package-card">
                    <h2>Create Your Own Custom Package</h2>
                    <p>Design an event the way you want—pick your venue, services, and budget!</p>
                    <a href="CustomPackageFormServlet">
                        <button>Create Custom Package</button>
                    </a>
                </div>
            </div>
        </div>
        <%@include file="footer.jsp" %>
</body>

</html>