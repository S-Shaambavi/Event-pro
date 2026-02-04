<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>About Us - Online Event Management System</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" />
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;600&display=swap" rel="stylesheet" />
  <style>
    /* Base Styles */
    * {
      box-sizing: border-box;
      margin: 0;
      padding: 0;
    }
    
    body {
      font-family: 'Poppins', sans-serif;
      background: linear-gradient(to bottom, #e0e7ff, white);
      min-height: 100vh;
      display: flex;
      flex-direction: column;
      color: #312e81;
    }
    
    main {
      flex-grow: 1;
      width: 100%;
      max-width: 1200px;
      margin: 0 auto;
      padding: 3rem 1.5rem;
    }
    
    section {
      margin-bottom: 3rem;
    }
    
    h2, h3 {
      font-weight: 600;
      color: #4338ca;
    }
    
    h2 {
      font-size: 2.25rem;
      margin-bottom: 1.5rem;
    }
    
    h3 {
      font-size: 1.25rem;
      margin-bottom: 0.5rem;
    }
    
    p {
      line-height: 1.6;
      margin-bottom: 1rem;
    }
    
    img {
      max-width: 100%;
      height: auto;
    }
    
    /* About Section */
    .about-section {
      text-align: center;
      max-width: 800px;
      margin: 0 auto 4rem;
    }
    
    .about-section h2 {
      font-size: 2.5rem;
      font-weight: 800;
      margin-bottom: 1rem;
    }
    
    /* Card Grid */
    .card-grid {
      display: grid;
      grid-template-columns: 1fr;
      gap: 1.5rem;
      max-width: 1200px;
      margin: 0 auto;
    }
    
    @media (min-width: 640px) {
      .card-grid {
        grid-template-columns: repeat(2, 1fr);
      }
    }
    
    @media (min-width: 1024px) {
      .card-grid {
        grid-template-columns: repeat(3, 1fr);
      }
    }
    
    .card {
      position: relative;
      overflow: hidden;
      border-radius: 0.75rem;
      box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
      background: white;
      transition: transform 0.3s ease, box-shadow 0.3s ease;
    }
    
    .card:hover {
      transform: translateY(-5px);
      box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
    }
    
    .card img {
      width: 100%;
      height: 16rem;
      object-fit: cover;
      transition: transform 0.3s ease;
    }
    
    .card:hover img {
      transform: scale(1.05);
    }
    
    .card-content {
      padding: 1.5rem;
    }
    
    /* Services Section */
    .services-section {
      max-width: 1200px;
      margin: 5rem auto 0;
      padding: 0 1.5rem;
      text-align: center;
    }
    
    .services-grid {
      display: grid;
      grid-template-columns: 1fr;
      gap: 2rem;
      margin-top: 2rem;
    }
    
    @media (min-width: 640px) {
      .services-grid {
        grid-template-columns: repeat(2, 1fr);
      }
    }
    
    @media (min-width: 768px) {
      .services-grid {
        grid-template-columns: repeat(3, 1fr);
      }
    }
    
    .service-card {
      background: white;
      padding: 1.5rem;
      border-radius: 0.75rem;
      box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
      cursor: pointer;
      transition: box-shadow 0.3s ease;
    }
    
    .service-card:hover {
      box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
    }
    
    .service-card img {
      width: 100%;
      height: 10rem;
      object-fit: cover;
      border-radius: 0.5rem;
      margin-bottom: 1rem;
    }
    
    /* Values Section */
    .values-section {
      max-width: 800px;
      margin: 5rem auto 0;
      text-align: center;
    }
    
    .values-grid {
      display: grid;
      grid-template-columns: 1fr;
      gap: 2.5rem;
      margin-top: 1.5rem;
    }
    
    @media (min-width: 640px) {
      .values-grid {
        grid-template-columns: repeat(3, 1fr);
      }
    }
    
    .value-item {
      padding: 1rem;
    }
    
    .value-item i {
      color: #6366f1;
      font-size: 3rem;
      margin-bottom: 1rem;
    }
    
    /* Modal Styles */
    .modal {
      position: fixed;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
      background: rgba(0, 0, 0, 0.5);
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 1rem;
      z-index: 1000;
      opacity: 0;
      visibility: hidden;
      transition: opacity 0.3s ease, visibility 0.3s ease;
    }
    
    .modal.active {
      opacity: 1;
      visibility: visible;
    }
    
    .modal-content {
      background: white;
      border-radius: 0.75rem;
      max-width: 42rem;
      width: 100%;
      max-height: 90vh;
      overflow-y: auto;
    }
    
    .modal-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 1rem;
      padding: 1.5rem 1.5rem 0;
    }
    
    .modal-header h3 {
      font-size: 1.5rem;
      font-weight: 700;
    }
    
    .modal-header button {
      color: #6b7280;
      background: none;
      border: none;
      font-size: 1.5rem;
      cursor: pointer;
    }
    
    .modal-header button:hover {
      color: #374151;
    }
    
    .modal-body {
      padding: 0 1.5rem 1.5rem;
    }
    
    .modal-body img {
      width: 100%;
      height: 12rem;
      object-fit: cover;
      border-radius: 0.5rem;
      margin-bottom: 1rem;
    }
    
    .modal-footer {
      padding: 1.5rem;
      text-align: right;
    }
    
    .modal-footer button {
      padding: 0.5rem 1.5rem;
      background: #4f46e5;
      color: white;
      border: none;
      border-radius: 0.5rem;
      cursor: pointer;
      transition: background 0.3s ease;
    }
    
    .modal-footer button:hover {
      background: #4338ca;
    }
    
    ul {
      list-style-position: inside;
      margin-bottom: 1rem;
    }
    
    li {
      margin-bottom: 0.5rem;
    }
    
    .text-center {
      text-align: center;
    }
    
    .mx-auto {
      margin-left: auto;
      margin-right: auto;
    }
  </style>
</head>
<body>

  <main>
    <!-- About Section -->
    <section class="about-section">
      <h2>About Eventify</h2>
      <p>
        At Eventify, we don't just plan events - we craft unforgettable experiences. From corporate summits to vibrant celebrations, our mission is to turn your vision into reality with precision, creativity, and care.
      </p>
    </section>

    <!-- Our Work Showcase -->
    <section>
      <div class="card-grid">
        <!-- Each card uses online image URLs; replace with local ones later -->
        <div class="card">
          <img src="images/CreativeTeam.jpg" alt="Creative Team" class="zoom-img" />
          <div class="card-content">
            <h3>Creative Team</h3>
            <p>Meet the heart of Eventify - a team fueled by creativity and passion.</p>
          </div>
        </div>

        <div class="card">
          <img src="images/eventExecution.jpg" alt="Event Execution" class="zoom-img" />
          <div class="card-content">
            <h3>Event Execution</h3>
            <p>From setup to final applause - smooth, stress-free experiences.</p>
          </div>
        </div>

        <div class="card">
          <img src="images/corporate.jpg" alt="Corporate Events" class="zoom-img" />
          <div class="card-content">
            <h3>Corporate Events</h3>
            <p>Professional, inspiring, and engaging business events tailored for growth.</p>
          </div>
        </div>

        <div class="card">
          <img src="images/entertainment.jpg" alt="Entertainment Events" class="zoom-img" />
          <div class="card-content">
            <h3>Entertainment Events</h3>
            <p>Concerts, parties, festivals - all delivered with energy and style.</p>
          </div>
        </div>

        <div class="card">
          <img src="images/community.jpg" alt="Community Events" class="zoom-img" />
          <div class="card-content">
            <h3>Community Events</h3>
            <p>Events that bring people together and strengthen community bonds.</p>
          </div>
        </div>

        <div class="card">
          <img src="images/technology.jpeg" alt="Technology Driven" class="zoom-img" />
          <div class="card-content">
            <h3>Technology Driven</h3>
            <p>Smart planning tools and real-time coordination powered by tech.</p>
          </div>
        </div>
      </div>
    </section>

    <!-- Our Services -->
    <section class="services-section">
      <h2>Our Services</h2>
      <div class="services-grid">
        <!-- Catering Service -->
        <div class="service-card" onclick="openModal('cateringModal')">
          <img src="images/Pic 1.jpeg" alt="Catering">
          <h3>Catering</h3>
          <p>Delicious menus tailored to your event, served with excellence.</p>
        </div>

        <!-- Photography Service -->
        <div class="service-card" onclick="openModal('photographyModal')">
          <img src="images/pic 11.jpeg" alt="Photography">
          <h3>Photography</h3>
          <p>Capture the magic with professional photography and videography.</p>
        </div>

        <!-- Hall Booking Service -->
        <div class="service-card" onclick="openModal('hallBookingModal')">
          <img src="images/pic 10.jpg" alt="Hall Booking">
          <h3>Hall Booking</h3>
          <p>Perfect venues that match your event's tone and size.</p>
        </div>

        <!-- Decorations Service -->
        <div class="service-card" onclick="openModal('decorationsModal')">
          <img src="images/pic 8.png" alt="Decorations">
          <h3>Decorations</h3>
          <p>Themes, flowers, lights — all designed to reflect your story.</p>
        </div>

        <!-- Entertainment Service -->
        <div class="service-card" onclick="openModal('entertainmentModal')">
          <img src="images/pic 7.jpg" alt="Entertainment">
          <h3>Entertainment</h3>
          <p>Live music, DJs, performers — unforgettable fun for every crowd.</p>
        </div>

        <!-- Transportation Service -->
        <div class="service-card" onclick="openModal('transportationModal')">
          <img src="images/pic 13.jpeg" alt="Transportation">
          <h3>Transportation</h3>
          <p>Reliable transport arrangements for guests, crew, and equipment.</p>
        </div>
      </div>
    </section>

    <!-- Our Values -->
    <section class="values-section">
      <h2>Our Values</h2>
      <div class="values-grid">
        <div class="value-item">
          <i class="fas fa-heart"></i>
          <h3>Passion</h3>
          <p>Every event is a story told with creativity, energy, and heart.</p>
        </div>
        <div class="value-item">
          <i class="fas fa-handshake"></i>
          <h3>Trust</h3>
          <p>We deliver on promises and build relationships based on trust and consistency.</p>
        </div>
        <div class="value-item">
          <i class="fas fa-lightbulb"></i>
          <h3>Innovation</h3>
          <p>We lead with creativity and embrace modern tools to elevate your event.</p>
        </div>
      </div>
    </section>

    <!-- Service Modals -->

    <!-- Catering Modal -->
    <div id="cateringModal" class="modal">
      <div class="modal-content">
        <div class="modal-header">
          <h3>Catering Services</h3>
          <button onclick="closeModal('cateringModal')">
            <i class="fas fa-times"></i>
          </button>
        </div>
        <div class="modal-body">
          <img src="images/Pic 1.jpeg" alt="Catering">
          <div>
            <p>Our catering service transforms your event into a culinary experience. We offer:</p>
            <ul>
              <li>Customized menus tailored to your event theme and guest preferences</li>
              <li>Gourmet cuisine prepared by professional chefs</li>
              <li>Options for all dietary requirements (vegetarian, vegan, gluten-free, etc.)</li>
              <li>Full-service catering with professional wait staff</li>
              <li>Beverage services including bar setup and cocktail specialists</li>
              <li>Hygienic food preparation and serving standards</li>
            </ul>
            <p style="font-weight: 600;">From corporate luncheons to wedding banquets, we'll make sure your guests remember the food as much as the occasion.</p>
          </div>
        </div>
        <div class="modal-footer">
          <button onclick="closeModal('cateringModal')">Close</button>
        </div>
      </div>
    </div>

    <!-- Photography Modal -->
    <div id="photographyModal" class="modal">
      <div class="modal-content">
        <div class="modal-header">
          <h3>Photography & Videography</h3>
          <button onclick="closeModal('photographyModal')">
            <i class="fas fa-times"></i>
          </button>
        </div>
        <div class="modal-body">
          <img src="images/pic 11.jpeg" alt="Photography">
          <div>
            <p>Capture every special moment with our professional photography and videography services:</p>
            <ul>
              <li>High-resolution photography by experienced event photographers</li>
              <li>4K videography with cinematic editing</li>
              <li>Drone photography for unique aerial perspectives</li>
              <li>Live event streaming services</li>
              <li>Photo booths with custom backdrops and props</li>
              <li>Same-day editing and slideshow presentations</li>
              <li>Digital galleries with high-quality downloads</li>
            </ul>
            <p style="font-weight: 600;">We preserve your memories so you can relive your special event for years to come.</p>
          </div>
        </div>
        <div class="modal-footer">
          <button onclick="closeModal('photographyModal')">Close</button>
        </div>
      </div>
    </div>

    <!-- Hall Booking Modal -->
    <div id="hallBookingModal" class="modal">
      <div class="modal-content">
        <div class="modal-header">
          <h3>Venue & Hall Booking</h3>
          <button onclick="closeModal('hallBookingModal')">
            <i class="fas fa-times"></i>
          </button>
        </div>
        <div class="modal-body">
          <img src="images/pic 10.jpg" alt="Hall Booking">
          <div>
            <p>Find the perfect venue for your event with our extensive network and booking services:</p>
            <ul>
              <li>Access to premium venues across the city</li>
              <li>Indoor and outdoor venue options</li>
              <li>Capacity from intimate (20 guests) to large-scale (1000+ guests)</li>
              <li>Venue scouting based on your specific requirements</li>
              <li>Negotiation of rental terms and contracts</li>
              <li>Logistics planning including parking and accessibility</li>
              <li>Coordination with venue staff and management</li>
            </ul>
            <p style="font-weight: 600;">We handle all the details so you can focus on your event, not the location logistics.</p>
          </div>
        </div>
        <div class="modal-footer">
          <button onclick="closeModal('hallBookingModal')">Close</button>
        </div>
      </div>
    </div>

    <!-- Decorations Modal -->
    <div id="decorationsModal" class="modal">
      <div class="modal-content">
        <div class="modal-header">
          <h3>Event Decorations</h3>
          <button onclick="closeModal('decorationsModal')">
            <i class="fas fa-times"></i>
          </button>
        </div>
        <div class="modal-body">
          <img src="images/pic 8.png" alt="Decorations">
          <div>
            <p>Transform any space into a magical setting with our decoration services:</p>
            <ul>
              <li>Complete theme development and execution</li>
              <li>Floral arrangements and centerpieces</li>
              <li>Lighting design including LED, uplighting, and special effects</li>
              <li>Stage and backdrop design</li>
              <li>Table settings and linen selection</li>
              <li>Custom signage and branding elements</li>
              <li>Balloon artistry and installations</li>
              <li>Special effects like fog machines and confetti cannons</li>
            </ul>
            <p style="font-weight: 600;">Our designers will work with you to create a visually stunning environment that perfectly matches your vision.</p>
          </div>
        </div>
        <div class="modal-footer">
          <button onclick="closeModal('decorationsModal')">Close</button>
        </div>
      </div>
    </div>

    <!-- Entertainment Modal -->
    <div id="entertainmentModal" class="modal">
      <div class="modal-content">
        <div class="modal-header">
          <h3>Entertainment Services</h3>
          <button onclick="closeModal('entertainmentModal')">
            <i class="fas fa-times"></i>
          </button>
        </div>
        <div class="modal-body">
          <img src="images/pic 7.jpg" alt="Entertainment">
          <div>
            <p>Elevate your event with our diverse entertainment options:</p>
            <ul>
              <li>Live bands and musical performers for all genres</li>
              <li>Professional DJs with complete sound systems</li>
              <li>Celebrity and keynote speakers</li>
              <li>Comedians and MCs for corporate events</li>
              <li>Dance troupes and performance artists</li>
              <li>Interactive entertainment like magicians and caricaturists</li>
              <li>Cultural performers for themed events</li>
              <li>Audio-visual technical support</li>
            </ul>
            <p style="font-weight: 600;">We'll match the perfect entertainment to your event's tone and audience for maximum engagement.</p>
          </div>
        </div>
        <div class="modal-footer">
          <button onclick="closeModal('entertainmentModal')">Close</button>
        </div>
      </div>
    </div>

    <!-- Transportation Modal -->
    <div id="transportationModal" class="modal">
      <div class="modal-content">
        <div class="modal-header">
          <h3>Transportation Services</h3>
          <button onclick="closeModal('transportationModal')">
            <i class="fas fa-times"></i>
          </button>
        </div>
        <div class="modal-body">
          <img src="images/pic 13.jpeg" alt="Transportation">
          <div>
            <p>Ensure smooth arrivals and departures with our transportation solutions:</p>
            <ul>
              <li>Luxury vehicle rentals for VIP guests</li>
              <li>Shuttle services for large groups</li>
              <li>Airport transfers for out-of-town attendees</li>
              <li>Charter bus services for corporate outings</li>
              <li>Valet parking coordination</li>
              <li>Equipment and stage transport</li>
              <li>Accessible transportation options</li>
              <li>Real-time tracking and dispatch services</li>
            </ul>
            <p style="font-weight: 600;">We handle all the logistics so your guests arrive comfortably and on time.</p>
          </div>
        </div>
        <div class="modal-footer">
          <button onclick="closeModal('transportationModal')">Close</button>
        </div>
      </div>
    </div>
  </main>

  <script>
    // Modal functions
    function openModal(modalId) {
      document.getElementById(modalId).classList.add('active');
      document.body.style.overflow = 'hidden';
    }
    
    function closeModal(modalId) {
      document.getElementById(modalId).classList.remove('active');
      document.body.style.overflow = 'auto';
    }
    
    // Close modal when clicking outside of it
    window.addEventListener('click', function(event) {
      if (event.target.classList.contains('modal')) {
        event.target.classList.remove('active');
        document.body.style.overflow = 'auto';
      }
    });
  </script>

</body>
</html>