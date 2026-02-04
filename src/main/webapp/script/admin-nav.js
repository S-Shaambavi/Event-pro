// Left sidebar toggle
const leftSidebarToggle = document.getElementById('left-sidebar-toggle');
const leftSidebar = document.getElementById('left-sidebar');

leftSidebarToggle.addEventListener('click', () => {
	leftSidebar.classList.toggle('open');
	leftSidebarToggle.classList.toggle('open');
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

// Close search when clicking outside
document.addEventListener('click', (e) => {
	if (!searchForm.contains(e.target) && e.target !== searchBtn) {
		searchForm.classList.remove('active');
	}
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

// Header scroll effect
const topNav = document.getElementById('topNav');
const leftsidebar = document.getElementById('left-sidebar');
window.addEventListener('scroll', () => {
	if (window.scrollY > 50) {
		topNav.classList.add('scrolled');
		leftsidebar.classList.add('scrolled');
	} else {
		topNav.classList.remove('scrolled');
		leftsidebar.classList.remove('scrolled');
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
let scrollTimeout;
window.addEventListener('scroll', () => {
	clearTimeout(scrollTimeout);
	scrollTimeout = setTimeout(() => {
		if (window.scrollY > 50) {
			topNav.classList.add('scrolled');
			leftsidebar.classList.add('scrolled');
		} else {
			topNav.classList.remove('scrolled');
			leftsidebar.classList.remove('scrolled');
		}
	}, 50);
});

document.addEventListener('DOMContentLoaded', function() {
    // Get all navigation links
    const navLinks = document.querySelectorAll('nav a');
    const currentPath = window.location.pathname;

    // Iterate through each nav link
    navLinks.forEach(link => {
        // Check if the href of the link matches the current URL
        if (link.getAttribute('href') === currentPath) {
            // Add the active class if it's the current page
            link.classList.add('active');
        } else {
            // Remove the active class if it's not the current page
            link.classList.remove('active');
        }
    });
});
