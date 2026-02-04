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
            background-color: #f8f9fa;
            color: #333;
            min-height: 100vh;
        }

        /* Top Navigation Bar */
        .top-nav {
            position: fixed;
            top: 0;
            width: 100%;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 15px 1%;
            box-shadow: 0 2px 15px rgba(0, 0, 0, 0.1);
            z-index: 1000;
            background: #ffffff;
            color: #2c3e50;
            transition: all 0.3s ease;
        }

        .top-nav.scrolled {
            box-shadow: 0 2px 15px rgba(0, 0, 0, 0.1);
            padding: 10px 2%;
        }

        .top-nav .brand {
            font-size: 1.8rem;
            font-weight: bold;
            color: #28a745;
        }

        .top-nav ul {
            display: flex;
            justify-content: center;
            list-style: none;
            flex: 1;
        }

        .top-nav ul li {
            margin: 0 10px;
        }

        .top-nav ul li a {
            text-decoration: none;
            font-size: 1rem;
            padding: 8px 16px;
            border-radius: 30px;
            transition: all 0.3s ease;
            color: #2c3e50;
            font-weight: 500;
        }

        .top-nav ul li a:hover {
            color: #28a745;
        }

        .top-nav ul li a.active {
            background-color: #28a745;
            color: #ffffff;
        }

        .icons {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .icons i {
            cursor: pointer;
            font-size: 1.2rem;
            transition: all 0.3s ease;
            color: #2c3e50;
        }

        .icons i:hover {
            color: #28a745;
            transform: scale(1.1);
        }

        /* Mobile Menu Button */
        .menu-button {
            display: none;
            background: none;
            border: none;
            font-size: 1.5rem;
            cursor: pointer;
            color: #2c3e50;
            transition: all 0.3s ease;
        }

        .menu-button:hover {
            color: #28a745;
        }

        /* Search Form */
        .search-form {
            position: fixed;
            right: 10px;
            margin-top: 70px;
            background: #ffffff;
            padding: 5px;
            display: flex;
            align-items: center;
            border-radius: 30px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
            transform: scale(0);
            transform-origin: top right;
            transition: transform 0.3s ease;
            z-index: 1000;
            border: 1px solid #eee;
        }

        .search-form.active {
            transform: scale(1);
        }

        .search-form input[type="search"] {
            border: none;
            outline: none;
            padding: 10px 15px;
            font-size: 1rem;
            width: 200px;
            border-radius: 30px 0 0 30px;
            background: #ffffff;
            color: #333;
        }

        .search-form label {
            background: #28a745;
            color: #ffffff;
            padding: 10px 15px;
            border-radius: 0 30px 30px 0;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        .search-form label:hover {
            background: #218838;
        }

        /* Dropdown card */
        .dropdown-card {
            position: absolute;
            right: 10px;
            margin-top: 70px;
            width: 220px;
            background: #ffffff;
            border-radius: 8px;
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.12);
            padding: 16px;
            opacity: 0;
            pointer-events: none;
            transform: translateY(-10px);
            transition: opacity 0.2s ease, transform 0.2s ease;
        }

        /* Show dropdown */
        .dropdown-card.show {
            opacity: 1;
            pointer-events: auto;
            transform: translateY(0);
        }

        .card-btn {
            padding: 8px 16px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-weight: 500;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
        }

        /* Right Sidebar (Mobile) */
        .mobile-sidebar {
            position: fixed;
            top: 0;
            right: -100%;
            width: 280px;
            height: 100vh;
            background-color: #ffffff;
            box-shadow: -5px 0 15px rgba(0, 0, 0, 0.05);
            transition: right 0.4s ease;
            padding: 80px 20px 20px;
            z-index: 1000;
            overflow-y: auto;
        }

        .mobile-sidebar.open {
            right: 0;
        }

        .mobile-sidebar ul {
            list-style: none;
        }

        .mobile-sidebar ul li {
            margin-bottom: 15px;
        }

        .mobile-sidebar ul li a {
            text-decoration: none;
            padding: 12px 15px;
            display: block;
            border-radius: 5px;
            transition: all 0.3s ease;
            color: #333;
            font-weight: 500;
        }

        .mobile-sidebar ul li a:hover {
            background: #f0f4f8;
            color: #28a745;
        }

        .mobile-sidebar ul li a i {
            margin-right: 10px;
            width: 20px;
            text-align: center;
        }

        /* Responsive Styles */
        @media (max-width : 992px) {
            .top-nav {
                padding: 15px 20px;
            }

            .top-nav ul {
                display: none;
            }

            .icons {
                gap: 15px;
            }

            .menu-button {
                display: block;
            }
        }

        @media (max-width : 768px) {
            .search-form {
                right: 20px;
                top: 65px;
            }
        }

        @media (max-width : 480px) {
            .brand {
                font-size: 1.5rem;
            }

            .icons i {
                font-size: 1.1rem;
            }
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" />
</head>

<body>
    <header>
        <nav class="top-nav" id="topNav">
            <div class="brand">EventPro</div>

            <ul>
                <li><a href="${pageContext.request.contextPath}/UserDashboardServlet" class="active"><i
                            class="fas fa-home"></i> Dashboard</a></li>
                <li><a href="${pageContext.request.contextPath}/PackageServlet"><i class="fas fa-star"></i>
                        Events</a></li>
                <li><a href="${pageContext.request.contextPath}/TransactionController"><i class="fas fa-tags"></i>
                        Payments</a></li>
                <li><a href="${pageContext.request.contextPath}/contact-us.jsp"><i class="fas fa-envelope"></i>
                        Contact</a></li>
            </ul>


            <div class="icons">
                <button class="menu-button" id="mobile-menu-btn" aria-label="Toggle Mobile Menu">
                    <i class="fas fa-bars"></i>
                </button>
                <i class="fas fa-user" id="user-btn" title="Profile"></i>
                <i class="fas fa-search" id="search-btn" title="Search"></i>
            </div>
        </nav>

        <form action="#" class="search-form" id="search-form">
            <input type="search" placeholder="Search events..." id="search-box">
            <label for="search-box" class="fas fa-search"></label>
        </form>

        <div class="dropdown-card" id="dropdownCard" role="menu" aria-hidden="true">
            <c:if test="${not empty sessionScope.user_email}">
                <a href="logout"><button id="logout" class="card-btn logout"><i class="fas fa-sign-out-alt"></i>Log
                        Out</button></a>
            </c:if>
            <button id="profile" class="card-btn profile"><i class="fas fa-user-cog"></i>Profile</button>
        </div>

        <div class="mobile-sidebar" id="mobile-sidebar">
            <ul>
                <li><a href="#" id="close-mobile-sidebar"><i class="fas fa-times"></i> Close</a></li>
                <li><a href="${pageContext.request.contextPath}/index.jsp"><i class="fas fa-home"></i> Home</a></li>
                <li><a href="${pageContext.request.contextPath}/package.jsp"><i class="fas fa-calendar-alt"></i>
                        Events</a></li>
                <li><a href="${pageContext.request.contextPath}/package.jsp"><i class="fas fa-star"></i>
                        Features</a></li>
                <li><a href="${pageContext.request.contextPath}/pricing.jsp"><i class="fas fa-tag"></i> Payments</a>
                </li>
                <li><a href="${pageContext.request.contextPath}/contact-us.jsp"><i class="fas fa-envelope"></i>
                        Contact</a></li>
                <li><a href="${pageContext.request.contextPath}/UserProfile.jsp"><i class="fas fa-user"></i>
                        Profile</a></li>
            </ul>
        </div>
    </header>
    <script>
        const profile = document.getElementById('profile');
        profile.addEventListener("click", function () {
            window.location.href = 'http://localhost:8080/OnlineEventManagementSystem/UserProfile.jsp';
        });

        const userIconBtn = document.getElementById('user-btn');
        const dropdownCard = document.getElementById('dropdownCard');

        // Toggle dropdown visibility
        userIconBtn.addEventListener('click', () => {
            const isOpen = dropdownCard.classList.contains('show');
            if (isOpen) {
                dropdownCard.classList.remove('show');
                dropdownCard.setAttribute('aria-hidden', 'true');
            } else {
                dropdownCard.classList.add('show');
                dropdownCard.setAttribute('aria-hidden', 'false');
            }
        });

        // Close dropdown if clicking outside
        document.addEventListener('click', (event) => {
            if (!dropdownCard.contains(event.target) && !userIconBtn.contains(event.target)) {
                dropdownCard.classList.remove('show');
                dropdownCard.setAttribute('aria-hidden', 'true');
            }
        });

        // Optional: Close dropdown on Escape key
        document.addEventListener('keydown', (event) => {
            if (event.key === 'Escape') {
                dropdownCard.classList.remove('show');
                dropdownCard.setAttribute('aria-hidden', 'true');
            }
        });

        // Mobile menu toggle
        const mobileMenuBtn = document.getElementById('mobile-menu-btn');
        const mobileSidebar = document.getElementById('mobile-sidebar');
        const closeMobileSidebar = document.getElementById('close-mobile-sidebar');

        mobileMenuBtn.addEventListener('click', () => {
            mobileSidebar.classList.toggle('open');
        });

        closeMobileSidebar.addEventListener('click', (e) => {
            e.preventDefault();
            mobileSidebar.classList.remove('open');
        });

        // Search form toggle
        const searchBtn = document.getElementById('search-btn');
        const searchForm = document.getElementById('search-form');

        searchBtn.addEventListener('click', () => {
            searchForm.classList.toggle('active');
        });

        document.addEventListener('click', (e) => {
            if (!searchForm.contains(e.target) && e.target !== searchBtn) {
                searchForm.classList.remove('active');
            }
        });

        // Header scroll effect
        const topNav = document.getElementById('topNav');
        window.addEventListener('scroll', () => {
            if (window.scrollY > 50) {
                topNav.classList.add('scrolled');
            } else {
                topNav.classList.remove('scrolled');
            }
        });

        // Set active nav item
        const navItems = document.querySelectorAll('.top-nav ul li a');
        navItems.forEach(item => {
            item.addEventListener('click', () => {
                navItems.forEach(nav => nav.classList.remove('active'));
                item.classList.add('active');
            });
        });
    </script>
</body>

</html>