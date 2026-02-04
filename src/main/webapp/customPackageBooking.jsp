<%@ page import="java.sql.*, jakarta.servlet.*" %>
<% 
    Class.forName("com.mysql.cj.jdbc.Driver"); 
	Connection conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/event_management", "root" , "2002" ); 
	Statement venueStmt=conn.createStatement(); ResultSet venues=venueStmt.executeQuery("SELECT * FROM event_venue WHERE venue_status='Available'");
    Statement serviceStmt = conn.createStatement();
    ResultSet services = serviceStmt.executeQuery(" SELECT * FROM event_service"); 
%>

<!DOCTYPE html>
<html>
<head>
    <title>Create Custom Package</title>
    <style>
		       /* Reset and base styles */
		* {
		    margin: 0;
		    padding: 0;
		    box-sizing: border-box;
		}
		body {
		margin-top: 70px;
		    font-family: 'Segoe UI', sans-serif;
		    
		    background-color: #f9f9f9;
		    color: #333;
		    line-height: 1.6;
		}
		
		/* Page title */
		h1 {
		    text-align: center;
		    font-size: 2.2rem;
		    margin-bottom: 30px;
		    color: #2c3e50;
		}
		
		/* Section Titles */
		.section-title {
		    font-size: 1.5rem;
		    color: #2c3e50;
		    margin: 30px 0 15px;
		    border-left: 6px solid #007bff;
		    padding-left: 10px;
		}
		
		/* Form and Input Fields */
		form {
		    max-width: 1200px;
		    margin: 0 auto;
		    background-color: #ffffff;
		    padding: 30px;
		    border-radius: 12px;
		    box-shadow: 0 8px 20px rgba(0,0,0,0.1);
		}
		.form-group {
		    margin-bottom: 25px;
		}
		input[type="number"] {
		    width: 100%;
		    padding: 12px 15px;
		    font-size: 1rem;
		    border-radius: 8px;
		    border: 1px solid #ccc;
		    margin-top: 8px;
		    transition: border-color 0.3s;
		}
		input[type="number"]:focus {
		    border-color: #007bff;
		    outline: none;
		}
		
		/* Carousel Style */
		.carousel {
		    display: flex;
		    overflow-x: auto;
		    scroll-snap-type: x mandatory;
		    gap: 1.2rem;
		    padding: 15px 0;
		}
		.card {
		    scroll-snap-align: start;
		    min-width: 220px;
		    background-color: #ffffff;
		    padding: 1rem;
		    border-radius: 15px;
		    box-shadow: 0 6px 15px rgba(0,0,0,0.08);
		    text-align: center;
		    transition: transform 0.3s, box-shadow 0.3s;
		    cursor: pointer;
		    position: relative;
		}
		.card:hover {
		    transform: translateY(-5px);
		    box-shadow: 0 10px 25px rgba(0,0,0,0.12);
		}
		.card img {
		    width: 100%;
		    height: 150px;
		    object-fit: cover;
		    border-radius: 12px;
		}
		.card h4 {
		    margin: 10px 0 5px;
		    font-size: 1.1rem;
		}
		.card p {
		    font-size: 0.95rem;
		    color: #555;
		}
		
		/* Service Grid */
		.services-grid {
		    display: grid;
		    grid-template-columns: repeat(auto-fill, minmax(180px, 1fr));
		    gap: 1rem;
		}
		.service-card {
		    background-color: #fff;
		    border-radius: 12px;
		    padding: 15px;
		    text-align: center;
		    box-shadow: 0 4px 10px rgba(0,0,0,0.08);
		    transition: transform 0.3s;
		}
		.service-card:hover {
		    transform: translateY(-5px);
		}
		.service-card img {
		    width: 100%;
		    height: 100px;
		    object-fit: cover;
		    border-radius: 10px;
		}
		.service-card h5 {
		    margin: 10px 0 5px;
		    font-size: 1rem;
		}
		.service-card p {
		    font-size: 0.9rem;
		    color: #666;
		}
		.service-card input[type="checkbox"] {
		    margin-bottom: 8px;
		}
		
		/* Button */
		button {
		    display: block;
		    width: 100%;
		    padding: 14px;
		    background-color: #007bff;
		    color: white;
		    border-radius: 10px;
		    border: none;
		    cursor: pointer;
		    font-size: 1.1rem;
		    transition: background-color 0.3s;
		}
		button:hover {
		    background-color: #0056b3;
		}
		
		/* Radio Styling in Cards */
		.card input[type="radio"] {
		    display: none;
		}
		.card input[type="radio"]:checked + h4,
		.card input[type="radio"]:checked + p {
		    color: #007bff;
		    font-weight: bold;
		}
		.card input[type="radio"]:checked {
		    outline: 2px solid #007bff;
		}
		
		/* Responsive Tweak */
		@media (max-width: 768px) {
		    .carousel {
		        gap: 0.8rem;
		    }
		    .card, .service-card {
		        min-width: 180px;
		    }
		    h1 {
		        font-size: 1.7rem;
		    }
		}

    </style>
</head>
<body>
	<%@include file="header.jsp" %>
    <h1>Create Your Custom Package</h1>

    <form action="customPackageServlet" method="post" onsubmit="return validateCustomPackageForm()">
        <!-- Attendee Count -->
        <div class="form-group">
            <label for="attendees">Number of Attendees:</label><br>
            <input type="number" name="attendee_count" required min="10" placeholder="Enter expected number of attendees">
        </div>

        <!-- Event Type -->
        <div class="form-group">
    <div class="section-title">Select Event Type</div>
    <div class="carousel">
        <label class="card">
            <img src="https://www.m9.news/movienews/chay-sobhita-dhulipala-wedding-sparks-north-vs-south-debate/" alt="Wedding">
            <input type="radio" name="event_type" value="Wedding" required>
            <h4>Wedding</h4>
            <p>Celebrate your special day with elegance.</p>
        </label>

        <label class="card">
            <img src="https://www.filmibeat.com/tamil/news/2014/leaked-photos-simbu-nayantara-parties-trisha-birthday-138869-pg1.html" alt="Birthday">
            <input type="radio" name="event_type" value="Birthday" required>
            <h4>Birthday</h4>
            <p>Host the perfect birthday party!</p>
        </label>

        <label class="card">
            <img src="https://www.instagram.com/tsvigneswaransa/p/DGlKlBJzhKj/?locale=Hasilkan%2Buang%2Bsecara%2Bonline%2Bdengan%2Baman%E3%80%90777ONE.IN%E3%80%91.ngfk&hl=en" alt="Corporate">
            <input type="radio" name="event_type" value="Corporate" required>
            <h4>Corporate</h4>
            <p>Professional setups for business events.</p>
        </label>

        <label class="card">
            <img src="https://www.google.com/imgres?q=tamil%20celebrity%20engagement%20party%20%20photoshoots&imgurl=https%3A%2F%2Fimages.indianexpress.com%2F2019%2F03%2Fvishal-wedding-759.jpg&imgrefurl=https%3A%2F%2Findianexpress.com%2Farticle%2Fentertainment%2Ftamil%2Fvishal-anisha-alla-engagement-photos-5629710%2F&docid=14Xs0R8W0tP3kM&tbnid=teInDZH0FCkWMM&vet=12ahUKEwjywIHy3aCNAxUIXWwGHTfGBiQQM3oECE8QAA..i&w=759&h=422&hcb=2&ved=2ahUKEwjywIHy3aCNAxUIXWwGHTfGBiQQM3oECE8QAA" alt="Engagement">
            <input type="radio" name="event_type" value="Engagement" required>
            <h4>Engagement</h4>
            <p>Elegant events to announce your bond.</p>
        </label>

        <label class="card">
            <img src="images/anniversary.jpg" alt="Anniversary">
            <input type="radio" name="event_type" value="Anniversary" required>
            <h4>Anniversary</h4>
            <p>Mark your milestones in style.</p>
        </label>
    </div>
</div>

        <!-- Venue Selection -->
        <div class="form-group">
            <div class="section-title">Select Venue</div>
            <div class="carousel">
                <%
                    while (venues.next()) {
                %>
                <label class="card">
                    <img src="<%= venues.getString("venue_image") %>" alt="Venue_Image">
                    <input type="radio" name="venue_id" value="<%= venues.getString("venue_id") %>" required>
                    <h4><%= venues.getString("venue_name") %></h4>
                    <p>Capacity: <%= venues.getInt("venue_capacity") %> | Rs. <%= venues.getDouble("venue_cost") %></p>
                </label>
                <%
                    }
                %>
            </div>
        </div>

        <!-- Service Selection -->
        <div class="form-group">
            <div class="section-title">Select Services</div>
            <div class="services-grid">
                <%
                    while (services.next()) {
                %>
                <label class="service-card">
                    <img src="<%= services.getString("service_image") %>" alt="Service Image">
                    <input type="checkbox" name="service_id" value="<%= services.getString("service_id") %>">
                    <h5><%= services.getString("service_name") %></h5>
                    <p>Rs. <%= services.getDouble("service_price") %></p>
                </label>
                <%
                    }
                %>
            </div>
        </div>

        <!-- Submit -->
    <button type="submit">Create Custom Package</button>

    </form>

</body>

<script>
    function validateCustomPackageForm() {
        // Get attendee count
        const attendeeInput = document.querySelector('input[name="attendee_count"]');
        const attendeeCount = parseInt(attendeeInput.value.trim());

        // Check attendee count
        if (isNaN(attendeeCount) || attendeeCount < 10) {
            alert("Please enter a valid number of attendees (at least 10).");
            attendeeInput.focus();
            return false;
        }

        // Check event type selection
        const eventTypeSelected = document.querySelector('input[name="event_type"]:checked');
        if (!eventTypeSelected) {
            alert("Please select an event type.");
            return false;
        }

        // Check venue selection
        const venueSelected = document.querySelector('input[name="venue_id"]:checked');
        if (!venueSelected) {
            alert("Please select a venue.");
            return false;
        }

        // Check at least one service is selected
        const selectedServices = document.querySelectorAll('input[name="service_id"]:checked');
        if (selectedServices.length === 0) {
            alert("Please select at least one service.");
            return false;
        }

        // All validations passed
        return true;
    }
</script>
<%@include file="footer.jsp" %>
</html>

<%
    venues.close();
    services.close();
    conn.close();
%>