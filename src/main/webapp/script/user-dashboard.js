// Slideshow functionality
let slideIndex = 0;
showSlides();

function showSlides() {
	let i;
	let slides = document.getElementsByClassName("slides");
	for (i = 0; i < slides.length; i++) {
		slides[i].style.display = "none";
	}
	slideIndex++;
	if (slideIndex > slides.length) { slideIndex = 1 }
	slides[slideIndex - 1].style.display = "block";
	setTimeout(showSlides, 5000); // Change image every 5 seconds
}

// Calendar functionality
let currentMonth = new Date().getMonth();
let currentYear = new Date().getFullYear();

function generateCalendar(month, year) {
	const monthNames = ["January", "February", "March", "April", "May", "June",
		"July", "August", "September", "October", "November", "December"];

	document.getElementById("monthYear").textContent = monthNames[month] + " " + year;

	const firstDay = new Date(year, month, 1).getDay();
	const daysInMonth = new Date(year, month + 1, 0).getDate();
	const daysInLastMonth = new Date(year, month, 0).getDate();

	let calendarGrid = document.getElementById("calendarGrid");
	calendarGrid.innerHTML = "";

	// Create day headers
	const dayNames = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
	dayNames.forEach(day => {
		const dayElement = document.createElement("div");
		dayElement.className = "calendar-day-header";
		dayElement.textContent = day;
		calendarGrid.appendChild(dayElement);
	});

	// Fill in previous month's days
	for (let i = 0; i < firstDay; i++) {
		const dayElement = document.createElement("div");
		dayElement.className = "calendar-day other-month";
		dayElement.textContent = daysInLastMonth - firstDay + i + 1;
		calendarGrid.appendChild(dayElement);
	}

	// Fill in current month's days
	const today = new Date();
	for (let i = 1; i <= daysInMonth; i++) {
		const dayElement = document.createElement("div");
		dayElement.className = "calendar-day";
		dayElement.textContent = i;

		if (i === today.getDate() && month === today.getMonth() && year === today.getFullYear()) {
			dayElement.classList.add("today");
		}

		calendarGrid.appendChild(dayElement);
	}

	// Calculate remaining cells
	const remainingCells = 42 - (firstDay + daysInMonth); // 6 rows x 7 days
	for (let i = 1; i <= remainingCells; i++) {
		const dayElement = document.createElement("div");
		dayElement.className = "calendar-day other-month";
		dayElement.textContent = i;
		calendarGrid.appendChild(dayElement);
	}
}

function changeMonth(step) {
	currentMonth += step;
	if (currentMonth < 0) {
		currentMonth = 11;
		currentYear--;
	} else if (currentMonth > 11) {
		currentMonth = 0;
		currentYear++;
	}
	generateCalendar(currentMonth, currentYear);
}

// Clock functionality
function updateClock() {
	const now = new Date();
	const clock = document.getElementById("clock");
	const date = document.getElementById("date");

	const timeString = now.toLocaleTimeString();
	const dateString = now.toLocaleDateString('en-US', {
		weekday: 'long',
		year: 'numeric',
		month: 'long',
		day: 'numeric'
	});

	clock.textContent = timeString;
	date.textContent = dateString;
}

// Initialize
document.addEventListener("DOMContentLoaded", function() {
	generateCalendar(currentMonth, currentYear);
	updateClock();
	setInterval(updateClock, 1000);
});