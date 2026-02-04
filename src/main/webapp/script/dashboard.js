// Slideshow Logic
let slideIndex = 0;
function showSlides() {
	const slides = document.querySelectorAll(".slides");
	slides.forEach(s => s.style.display = "none");
	slideIndex = (slideIndex + 1 > slides.length) ? 1 : slideIndex + 1;
	slides[slideIndex - 1].style.display = "block";
	setTimeout(showSlides, 3000);
}
showSlides();

const monthNames = ["January", "February", "March", "April", "May", "June",
	"July", "August", "September", "October", "November", "December"];
let currentMonth = new Date().getMonth();
let currentYear = new Date().getFullYear();

function renderCalendar(month, year) {
	const firstDay = new Date(year, month, 1).getDay();
	const daysInMonth = 32 - new Date(year, month, 32).getDate();

	let calendar = "<table>";
	const days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];

	// Header row for days of week
	calendar += "<tr>";
	days.forEach(day => calendar += `<th>${day}</th>`);
	calendar += "</tr>";

	let date = 1;
	// 6 rows for weeks (max possible in a month view)
	for (let i = 0; i < 6; i++) {
		calendar += "<tr>";  // open row
		for (let j = 0; j < 7; j++) {
			if (i === 0 && j < firstDay) {
				calendar += "<td></td>";  // empty cell before first day
			} else if (date > daysInMonth) {
				calendar += "<td></td>";  // empty cells after last day
			} else {
				calendar += `<td>${date}</td>`;
				date++;
			}
		}
		calendar += "</tr>";  // close row
		if (date > daysInMonth) break;  // stop if all days rendered
	}

	calendar += "</table>";

	document.getElementById("calendarGrid").innerHTML = calendar;
	document.getElementById("monthYear").innerText = `${monthNames[month]} ${year}`;
}

function changeMonth(offset) {
	currentMonth += offset;
	if (currentMonth > 11) {
		currentMonth = 0;
		currentYear++;
	} else if (currentMonth < 0) {
		currentMonth = 11;
		currentYear--;
	}
	renderCalendar(currentMonth, currentYear);
}

// Initial render
renderCalendar(currentMonth, currentYear);

// Clock Logic
function updateClock() {
	document.getElementById("clock").innerText = new Date().toLocaleTimeString();
}
setInterval(updateClock, 1000);
updateClock();