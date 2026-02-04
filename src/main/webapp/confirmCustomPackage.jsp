<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.Venue, model.Service, java.util.List" %>

<% 
	Venue venue=(Venue) request.getAttribute("selectedVenue"); 
	List<Service> services = (List<Service>) request.getAttribute("selectedServices");
    Integer attendeeCount = (Integer) request.getAttribute("attendeeCount");
    String eventType = (String) request.getAttribute("eventType");
    Double totalCost = (Double) request.getAttribute("totalCost");
    Integer packageId = (Integer) request.getAttribute("packageId");
%>

<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Confirm Custom Package</title>
    <style>
    	@import url('https://fonts.googleapis.com/css2?family=Roboto&display=swap');

        body {
            margin: 0;
            font-family: 'Roboto', sans-serif;
            background-color: #121212;
            color: #f0f0f0;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            min-height: 100vh;
            padding: 30px;
        }

        .container {
            background-color: #1e1e1e;
            padding: 30px 40px;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
            max-width: 600px;
            width: 100%;
        }

        h2 {
            color: #ffffff;
            margin-bottom: 20px;
        }

        h4 {
            margin-top: 20px;
            color: #cccccc;
        }

        p, li {
            font-size: 16px;
            margin: 10px 0;
        }

        ul {
            list-style-type: disc;
            padding-left: 20px;
        }

        input[type="date"] {
            background-color: #2b2b2b;
            color: #f0f0f0;
            border: 1px solid #444;
            padding: 8px 10px;
            border-radius: 6px;
            margin-top: 10px;
            font-size: 14px;
        }

        input[type="submit"],
        button {
            background-color: #03dac5;
            color: #000;
            padding: 10px 18px;
            margin-top: 20px;
            margin-right: 10px;
            border: none;
            border-radius: 8px;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        input[type="submit"]:hover,
        button:hover {
            background-color: #00bfa5;
        }

        @media (max-width: 600px) {
            .container {
                padding: 20px;
            }
        }
    </style>
</head>

<body>

    <div class="container">
        <h2>Confirm Your Custom Package</h2>

        <p><strong>Event Type:</strong>
            <%= eventType != null ? eventType : "N/A" %>
        </p>
        <p><strong>Attendees:</strong>
            <%= attendeeCount != null ? attendeeCount : "N/A" %>
        </p>

        <% if (venue != null) { %>
            <p><strong>Venue:</strong>
                <%= venue.getVenue_name() %> - $<%= venue.getVenue_cost() %>
            </p>
        <% } else { %>
            <p><strong>Venue:</strong> Not selected</p>
        <% } %>

        <h4>Selected Services:</h4>
        <ul>
            <% if (services != null && !services.isEmpty()) { 
                for(Service s : services) { %>
                    <li><%= s.getService_name() %> - $<%= s.getService_price() %></li>
            <% } } else { %>
                <li>No services selected</li>
            <% } %>
        </ul>

        <p><strong>Total Cost:</strong> $<%= totalCost != null ? totalCost : 0.0 %></p>

        <form action="confirmcustomBookingServlet" method="post" id="bookingForm">
            <label for="event_date">Select Event Date:</label>
            <input type="date" name="event_date" id="event_date" required>
            <br><br>
            <input type="submit" value="Confirm Booking">
        </form>

        <form action="CancelCustomPackageServlet" method="post">
            <input type="hidden" name="packageId" value="<%= packageId %>">    
            <button type="submit">Cancel</button>
        </form>
    </div>

    <script>
    document.addEventListener("DOMContentLoaded", function () {
        const dateInput = document.getElementById("event_date");
        const form = document.getElementById("bookingForm");

        // Set min date to today + 1
        const today = new Date();
        today.setHours(0, 0, 0, 0); // Reset to midnight
        const minDate = new Date(today);
        minDate.setDate(minDate.getDate() + 1);

        // Set HTML input min attribute
        const yyyy = minDate.getFullYear();
        const mm = String(minDate.getMonth() + 1).padStart(2, '0');
        const dd = String(minDate.getDate()).padStart(2, '0');
        const formattedMinDate = `${yyyy}-${mm}-${dd}`;
        dateInput.setAttribute('min', formattedMinDate);

        // JS validation on form submit
        form.addEventListener("submit", function (e) {
            const selectedDate = new Date(dateInput.value);
            selectedDate.setHours(0, 0, 0, 0); // Reset to midnight for clean comparison

            if (selectedDate < minDate) {
                e.preventDefault();
                alert("Please select a future date (from tomorrow onward).");
            }
        });
    });
</script>
</body>
</html>
