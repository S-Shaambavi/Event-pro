<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        footer {
            background-color: #2c3e50;
            color: #ffffff;
            padding: 60px 5% 30px;
            position: relative;
        }

        .footer-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            gap: 40px;
            max-width: 1200px;
            margin: 0 auto;
        }

        .footer-column {
            flex: 1 1 250px;
            min-width: 200px;
        }

        .footer-column h3 {
            margin-bottom: 25px;
            font-size: 1.3rem;
            position: relative;
            padding-bottom: 10px;
        }

        .footer-column h3::after {
            content: '';
            position: absolute;
            left: 0;
            bottom: 0;
            width: 50px;
            height: 2px;
            background-color: #28a745;
        }

        .footer-column p {
            line-height: 1.6;
            margin-bottom: 20px;
            color: rgba(255, 255, 255, 0.8);
        }

        .footer-column ul {
            list-style: none;
            padding: 0;
        }

        .footer-column ul li {
            margin-bottom: 12px;
            transition: transform 0.3s ease;
        }

        .footer-column ul li:hover {
            transform: translateX(5px);
        }

        .footer-column ul li a {
            color: rgba(255, 255, 255, 0.8);
            text-decoration: none;
            transition: color 0.3s;
            display: flex;
            align-items: center;
        }

        .footer-column ul li a:hover {
            color: #28a745;
        }

        .footer-column ul li a i {
            margin-right: 10px;
            width: 20px;
            text-align: center;
            color: #28a745;
        }

        .footer-contact p {
            display: flex;
            align-items: flex-start;
            margin-bottom: 15px;
        }

        .footer-contact p i {
            margin-right: 15px;
            color: #28a745;
            margin-top: 3px;
        }

        .footer-social {
            text-align: center;
            margin: 40px 0;
        }

        .footer-social a {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 40px;
            height: 40px;
            background-color: rgba(255, 255, 255, 0.1);
            color: #ffffff;
            border-radius: 50%;
            margin: 0 8px;
            font-size: 18px;
            transition: all 0.3s ease;
        }

        .footer-social a:hover {
            background-color: #28a745;
            transform: translateY(-5px);
        }

        .footer-bottom {
            text-align: center;
            font-size: 14px;
            padding-top: 20px;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            color: rgba(255, 255, 255, 0.7);
        }

        @media (max-width : 768px) {
            .footer-container {
                flex-direction: column;
                gap: 30px;
            }

            .footer-column {
                text-align: center;
            }

            .footer-column h3::after {
                left: 50%;
                transform: translateX(-50%);
            }

            .footer-column ul li a {
                justify-content: center;
            }

            .footer-contact p {
                justify-content: center;
            }
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" />
</head>

<body>
    <footer>
        <div class="footer-container">
            <div class="footer-column">
                <h3>About EventPro</h3>
                <p>EventPro is your all-in-one event management solution. We
                    help you create, manage, and promote unforgettable events with our
                    powerful platform and expert support.</p>
            </div>

            <div class="footer-column">
                <h3>Quick Links</h3>
                <ul>
                    <li><a href="#"><i class="fas fa-chevron-right"></i> Home</a></li>
                    <li><a href="#"><i class="fas fa-chevron-right"></i>
                            Features</a></li>
                    <li><a href="#"><i class="fas fa-chevron-right"></i>
                            Pricing</a></li>
                    <li><a href="#testimonials"><i class="fas fa-chevron-right"></i> Testimonials</a></li>
                    <li><a href="contact-us.jsp"><i class="fas fa-chevron-right"></i> Contact</a></li>
                </ul>
            </div>

            <div class="footer-column">
                <h3>Event Types</h3>
                <ul>
                    <li><a href="#"><i class="fas fa-chevron-right"></i>
                            Conferences</a></li>
                    <li><a href="#"><i class="fas fa-chevron-right"></i>
                            Workshops</a></li>
                    <li><a href="#"><i class="fas fa-chevron-right"></i>
                            Corporate Events</a></li>
                    <li><a href="#"><i class="fas fa-chevron-right"></i>
                            Social Gatherings</a></li>
                    <li><a href="#"><i class="fas fa-chevron-right"></i>
                            Virtual Events</a></li>
                </ul>
            </div>

            <div class="footer-column footer-contact">
                <h3>Contact Us</h3>
                <p>
                    <i class="fas fa-map-marker-alt"></i> 123 Event Street, Jaffna, Sri
                    Lanka
                </p>
                <p>
                    <i class="fas fa-phone-alt"></i> +94 76 123 4567
                </p>
                <p>
                    <i class="fas fa-envelope"></i> info@eventpro.com
                </p>
                <p>
                    <i class="fas fa-clock"></i> Mon-Fri: 9AM - 6PM
                </p>
            </div>
        </div>

        <div class="footer-social">
            <a href="#" title="Facebook"><i class="fab fa-facebook-f"></i></a> <a href="#" title="Twitter"><i
                    class="fab fa-twitter"></i></a> <a href="#" title="Instagram"><i
                    class="fab fa-instagram"></i></a> <a href="#" title="LinkedIn"><i
                    class="fab fa-linkedin-in"></i></a> <a href="#" title="YouTube"><i
                    class="fab fa-youtube"></i></a>
        </div>

        <div class="footer-bottom">
            &copy; 2025 EventPro. All Rights Reserved. | <a href="#" style="color: #28a745;">Privacy Policy</a> | <a
                href="#" style="color: #28a745;">Terms of Service</a>
        </div>
    </footer>
</body>

</html>