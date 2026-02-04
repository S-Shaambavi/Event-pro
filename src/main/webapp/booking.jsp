<%@ page import="java.util.*, model.PackageView" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% PackageView pkg=(PackageView) request.getAttribute("selectedPackage"); %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Confirmation</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 900px;
            margin: 30px auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        h2 {
            color: #007bff;
            text-align: center;
        }

        .details {
            margin: 20px 0;
            font-size: 16px;
        }

        .details p {
            margin: 5px 0;
        }

        h3 {
            color: #28a745;
            margin-top: 20px;
        }

        .services-list {
            list-style-type: none;
            padding: 0;
        }

        .services-list li {
            background-color: #e9ecef;
            margin: 5px 0;
            padding: 10px;
            border-radius: 5px;
        }

        label {
            font-size: 16px;
            font-weight: bold;
            margin-top: 10px;
        }

        input[type="date"] {
            padding: 8px;
            margin-top: 5px;
            width: 100%;
            border: 1px solid #ddd;
            border-radius: 5px;
        }

        button {
            background-color: #007bff;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 20px;
            font-size: 16px;
        }

        button:hover {
            background-color: #0056b3;
        }

        .error {
            color: red;
            font-size: 14px;
            display: none;
        }
    </style>

    <script>
        // JavaScript Validation for Event Date
        function validateBookingForm() {
            var eventDate = document.forms["bookingForm"]["event_date"].value;
            var errorMsg = document.getElementById("error-message");

            // Check if the event date is in the future
            if (new Date(eventDate) < new Date()) {
                errorMsg.style.display = "block";
                errorMsg.textContent = "Event date must be in the future.";
                return false;
            } else {
                errorMsg.style.display = "none";
                return true;
            }
        }
    </script>

</head>

<body>

    <div class="container">
        <h2>Confirm Booking for Package: <%= pkg.getPackageName() %>
        </h2>

        <div class="details">
            <p><strong>Venue:</strong>
                <%= pkg.getVenueName() %>
            </p>
            <p><strong>Venue Capacity:</strong>
                <%= pkg.getVenueCapacity() %>
            </p>
            <p><strong>Package Cost:</strong> Rs. <%= pkg.getPackageCost() %>
            </p>
            <p><strong>Attendees:</strong>
                <%= pkg.getAttendeeCount() %>
            </p>
        </div>

        <h3>Services Included:</h3>
        <ul class="services-list">
            <% List<String> services = pkg.getServices(); // Get the services list
                if (services != null && !services.isEmpty()) {
                for (String service : services) {
                %>
                <li>
                    <%= service %>
                </li>
                <% } } else { %>
                    <li>No services available</li>
                    <% } %>
        </ul>

        <form name="bookingForm" action="ConfirmBookingServlet" method="post"
            onsubmit="return validateBookingForm()">
            <input type="hidden" name="package_id" value="<%= pkg.getPackageId() %>">
            <label for="event_date">Event Date:</label>
            <input type="date" name="event_date" required>
            <div id="error-message" class="error"></div>
            <button type="submit">Confirm Booking</button>
        </form>
    </div>

</body>

</html>