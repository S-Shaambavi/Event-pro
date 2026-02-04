<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>EventPro-Home</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
    <link rel="stylesheet" href="style/home.css" />
</head>

<body>
    <%@include file="header.jsp" %>
        <section class="hero">
            <h1>Transform Your Event Planning Experience</h1>
            <p>The most comprehensive event management platform that helps you
                create unforgettable experiences while saving time and resources.</p>
            <a href="login.jsp" class="hero-button">Login Here</a>
        </section>
        <section id="features">
            <div class="container">
                <div class="features">
                    <div class="feature-card">
                        <i class="fas fa-calendar-alt"></i>
                        <h3>Easy Scheduling</h3>
                        <p>Create and manage events with our intuitive calendar and
                            smart reminders.</p>
                    </div>
                    <div class="feature-card">
                        <i class="fas fa-ticket-alt"></i>
                        <h3>Online Ticketing</h3>
                        <p>Sell tickets, track registrations, and handle payments
                            securely.</p>
                    </div>
                    <div class="feature-card">
                        <i class="fas fa-bullhorn"></i>
                        <h3>Promotion Tools</h3>
                        <p>Send invites, automate emails, and boost attendance with
                            built-in marketing tools.</p>
                    </div>
                    <div class="feature-card">
                        <i class="fas fa-chart-line"></i>
                        <h3>Analytics</h3>
                        <p>Monitor registrations, revenue, and engagement with
                            real-time dashboards.</p>
                    </div>
                </div>
            </div>
        </section>
        <section class="how-it-works">
            <h2>How It Works</h2>
            <div class="steps">
                <div class="step">
                    <div class="step-number">1</div>
                    <h3>Create Your Event</h3>
                    <p>Set up your event details, dates, venue information, and
                        ticket options with our easy-to-use wizard.</p>
                </div>

                <div class="step">
                    <div class="step-number">2</div>
                    <h3>Customize & Brand</h3>
                    <p>Add your logo, brand colors, and customize every aspect of
                        your event page to match your identity.</p>
                </div>

                <div class="step">
                    <div class="step-number">3</div>
                    <h3>Promote & Manage</h3>
                    <p>Use our marketing tools to promote your event and manage
                        attendees with our comprehensive dashboard.</p>
                </div>
            </div>
        </section>
        <section class="services" id="services">
            <div class="container">
                <div class="services-grid">
                    <div class="service-card">
                        <i class="fas fa-glass-cheers"></i>
                        <h3>Wedding Planning</h3>
                        <p>From intimate ceremonies to grand celebrations, we handle
                            every detail to make your special day perfect.</p>
                    </div>
                    <div class="service-card">
                        <i class="fas fa-briefcase"></i>
                        <h3>Corporate Events</h3>
                        <p>Professional management for conferences, product launches,
                            and corporate gatherings that impress.</p>
                    </div>
                    <div class="service-card">
                        <i class="fas fa-birthday-cake"></i>
                        <h3>Private Parties</h3>
                        <p>Birthdays, anniversaries, or any celebration - we create
                            memorable experiences for you and your guests.</p>
                    </div>
                    <div class="service-card">
                        <i class="fas fa-map-marked-alt"></i>
                        <h3>Venue Selection</h3>
                        <p>We have partnerships with the best venues to match your
                            event's style, size, and budget requirements.</p>
                    </div>
                    <div class="service-card">
                        <i class="fas fa-utensils"></i>
                        <h3>Catering Services</h3>
                        <p>Customized menus from top caterers to satisfy all tastes and
                            dietary requirements.</p>
                    </div>
                    <div class="service-card">
                        <i class="fas fa-photo-video"></i>
                        <h3>Media Production</h3>
                        <p>Professional photography, videography, and live streaming
                            services to capture your event.</p>
                    </div>
                </div>
            </div>
        </section>
        <section class="testimonials" id="testimonials">
            <div class="container">
                <h2 class="section-title text-center">What Our Clients Say</h2>
                <div class="testimonial-grid">
                    <div class="testimonial-card">
                        <i class="fas fa-quote-right"></i>
                        <div class="testimonial-content">
                            <p>"EventPro transformed our company retreat into an
                                unforgettable experience. Their attention to detail and creative
                                solutions exceeded all our expectations."</p>
                        </div>
                        <div class="testimonial-author">
                            <img src="https://randomuser.me/api/portraits/women/45.jpg" alt="Sarah Johnson" />
                            <div class="author-info">
                                <h4>Sarah Johnson</h4>
                                <p>CEO, TechSolutions Inc.</p>
                            </div>
                        </div>
                    </div>
                    <div class="testimonial-card">
                        <i class="fas fa-quote-right"></i>
                        <div class="testimonial-content">
                            <p>"Our wedding was absolutely perfect thanks to EventPro.
                                They handled everything seamlessly, allowing us to truly enjoy
                                our special day without any stress."</p>
                        </div>
                        <div class="testimonial-author">
                            <img src="https://randomuser.me/api/portraits/men/32.jpg" alt="Michael Chen" />
                            <div class="author-info">
                                <h4>Michael &amp; Emily Chen</h4>
                                <p>Wedding Clients</p>
                            </div>
                        </div>
                    </div>
                    <div class="testimonial-card">
                        <i class="fas fa-quote-right"></i>
                        <div class="testimonial-content">
                            <p>"The product launch EventPro organized for us generated
                                more buzz than we could have imagined. Their media connections
                                and creative staging were exceptional."</p>
                        </div>
                        <div class="testimonial-author">
                            <img src="https://randomuser.me/api/portraits/women/68.jpg" alt="Lisa Rodriguez" />
                            <div class="author-info">
                                <h4>Lisa Rodriguez</h4>
                                <p>Marketing Director, NovaCosmetics</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <section class="about-section">
            <div class="about-content">
                <h2>About Our Event Management System</h2>
                <p>Founded in 2020, our platform was created by event
                    professionals who understood the challenges of organizing successful
                    events. We've combined years of industry experience with
                    cutting-edge technology to deliver a solution that simplifies every
                    aspect of event planning.</p>
                <p>Our mission is to empower event organizers of all sizes - from
                    small community gatherings to large corporate conferences - with
                    tools that save time, reduce stress, and create better experiences
                    for attendees.</p>
                <p>With over 5,000 successful events powered by our platform,
                    we're proud to be the fastest growing event management solution in
                    the market.</p>
            </div>
            <div class="about-image">
                <img src="assets/event-about.avif" alt="Team planning an event" />
            </div>
        </section>
        <%@include file="footer.jsp" %>
</body>

</html>