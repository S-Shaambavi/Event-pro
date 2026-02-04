<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" />
    <link rel="stylesheet" href="style/admin-nav.css">
</head>

<body>
    <header>
        <!-- Top Navigation Bar -->
        <nav class="top-nav" id="topNav">
            <div class="brand">EventPro</div>

            <ul class="nav-links">

                <li><a href="${pageContext.request.contextPath}/AdminController" class="active"><i
                            class="fas fa-home"></i> Dashboard</a></li>
                <li><a href="${pageContext.request.contextPath}/UserController"><i class="fas fa-users"></i> Users</a>
                </li>
                <li><a href="${pageContext.request.contextPath}/PackageController"><i class="fas fa-box"></i>
                        Packages</a></li>
                <li><a href="${pageContext.request.contextPath}/VenueController"><i class="fas fa-map-marker-alt"></i>
                        Venues</a></li>
                <li><a href="${pageContext.request.contextPath}/ServiceController"><i class="fas fa-concierge-bell"></i>
                        Services</a></li>
            </ul>

            <div class="icons">
                <button class="menu-button" id="mobile-menu-btn" aria-label="Toggle Mobile Menu">
                    <i class="fas fa-bars"></i>
                </button>
                <i class="fas fa-user" id="user-btn" title="Profile"></i>
                <i class="fas fa-search" id="search-btn" title="Search"></i>
            </div>
        </nav>

        <!-- Search Form -->
        <form action="#" class="search-form" id="search-form">
            <input type="search" placeholder="Search events..." id="search-box" />
            <label for="search-box" class="fas fa-search"></label>
        </form>

        <div class="dropdown-card" id="dropdownCard" role="menu" aria-hidden="true">
            <p>
            	Welcome back ${sessionScope.user_fname}
            	<span>${sessionScope.user_email}</span>
            </p>
        </div>

        <!-- Sidebar (Desktop) -->
        <div class="left-sidebar" id="left-sidebar">
            <div class="tabs">
                <h3>Event Management</h3>
                <ul>
                    <li><a href="${pageContext.request.contextPath}/UserController"><i class="fas fa-users"></i>
                            Users</a></li>
                    <li><a href="${pageContext.request.contextPath}/PackageController"><i class="fas fa-box"></i>
                            Packages</a></li>
                    <li><a href="${pageContext.request.contextPath}/VenueController"><i
                                class="fas fa-map-marker-alt"></i> Venues</a></li>
                    <li><a href="${pageContext.request.contextPath}/ServiceController"><i
                                class="fas fa-concierge-bell"></i> Services</a></li>
                </ul>
            </div>
            <div class="settings">
                <h3>Account</h3>
                <ul>
                    <li><a href="UserProfile.jsp"><i class="fas fa-user-cog"></i> Profile</a></li>
                    <li><a href=""><i class="fas fa-cog"></i> Settings</a></li>
                    <li>
                        <%-- Check if user is logged in --%>
                            <c:if test="${not empty sessionScope.user_email}">
                                <a href="logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
                            </c:if>
                    </li>
                </ul>
            </div>
        </div>

        <!-- Sidebar Toggle (Desktop) -->
        <div class="toggle-btn" id="left-sidebar-toggle">
            <i class="fas fa-bars"></i>
        </div>

        <!-- Mobile Sidebar Menu -->
        <div class="mobile-sidebar" id="mobile-sidebar">
            <ul>
                <li><a href="#" id="close-mobile-sidebar"><i class="fas fa-times"></i> Close Menu</a></li>
                <li><a href="${pageContext.request.contextPath}/AdminController"><i class="fas fa-home"></i>
                        Dashboard</a></li>
                <li><a href="#"><i class="fas fa-user-cog"></i> Profile</a></li>
                <li><a href="${pageContext.request.contextPath}/UserController"><i class="fas fa-users"></i> Users</a>
                </li>
                <li><a href="${pageContext.request.contextPath}/PackageController"><i class="fas fa-box"></i>
                        Packages</a></li>
                <li><a href="${pageContext.request.contextPath}/VenueController"><i class="fas fa-map-marker-alt"></i>
                        Venues</a></li>
                <li><a href="${pageContext.request.contextPath}/ServiceController"><i class="fas fa-concierge-bell"></i>
                        Services</a></li>
            </ul>
        </div>
    </header>

    <script src="script/admin-nav.js">
    </script>
</body>

</html>