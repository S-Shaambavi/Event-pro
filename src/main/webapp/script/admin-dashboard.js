// Back button functionality with contextPath support
const contextPath = document.body.getAttribute("data-context-path") || ''; // fallback if not set

function goBack() {
	if (window.history.length > 1) {
		window.history.back();
	} else {
		window.location.href = contextPath + '/AdminController';
	}
}

// Truncate long text in table cells and preserve original in tooltip
document.addEventListener('DOMContentLoaded', function () {
	const truncateCells = document.querySelectorAll('.truncate');
	truncateCells.forEach(cell => {
		const fullText = cell.textContent.trim();
		if (fullText.length > 50) {
			cell.title = fullText; // show full text on hover
			cell.textContent = fullText.substring(0, 50) + '...';
		}
	});

	// Highlight active navigation link
	const navLinks = document.querySelectorAll('nav a');
	const currentPath = window.location.pathname;

	navLinks.forEach(link => {
		if (link.getAttribute('href') === currentPath) {
			link.classList.add('active');
		} else {
			link.classList.remove('active');
		}
	});
});
