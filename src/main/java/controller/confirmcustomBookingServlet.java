package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import util.DatabaseConnection;
import model.EventPackage;
import dao.EventPackageDAO;
import model.Service;
import model.Venue;

@WebServlet("/confirmcustomBookingServlet")
public class confirmcustomBookingServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			HttpSession session = request.getSession();

			// Retrieve session attributes

			Integer attendeeCount = (Integer) session.getAttribute("attendeeCount");
			String eventType = (String) session.getAttribute("eventType");
			Venue selectedVenue = (Venue) session.getAttribute("selectedVenue");
			List<Service> selectedServices = (List<Service>) session.getAttribute("selectedServices");
			Double totalCost = (Double) session.getAttribute("totalCost");
			Integer userId = (Integer) session.getAttribute("userId"); // Must be set during login

			// Debug missing session attributes
			if (attendeeCount == null || eventType == null || selectedVenue == null || selectedServices == null
					|| totalCost == null || userId == null) {

				System.out.println("Session attribute missing:");
				if (attendeeCount == null)
					System.out.println("attendeeCount is null");
				if (eventType == null)
					System.out.println("eventType is null");
				if (selectedVenue == null)
					System.out.println("selectedVenue is null");
				if (selectedServices == null)
					System.out.println("selectedServices is null");
				if (totalCost == null)
					System.out.println("totalCost is null");
				if (userId == null)
					System.out.println("userId is null");

				response.sendRedirect("error.jsp?msg=Missing+booking+details");
				return;
			}

			// Get and validate event date
			String eventDateStr = request.getParameter("event_date");
			if (eventDateStr == null || eventDateStr.isEmpty()) {
				response.sendRedirect("error.jsp?msg=Event+date+is+required");
				return;
			}

			Date eventDate = Date.valueOf(eventDateStr); // Converts to java.sql.Date

			// DB connection and DAO
			Connection conn = DatabaseConnection.getConnection();
			EventPackageDAO dao = new EventPackageDAO(conn);

			// Step 1: Create the custom Event Package

			// Step 2: Link selected services
			if (selectedServices.isEmpty()) {
				response.sendRedirect("error.jsp?msg=No+services+selected");
				return;
			}

			List<Integer> serviceIds = new ArrayList<>();
			for (Service s : selectedServices) {
				if (s != null) {
					try {
						serviceIds.add(s.getService_id());
					} catch (NumberFormatException nfe) {
						System.out.println("Invalid serviceId: " + s.getService_id());
					}
				} else {
					System.out.println("Null service object found");
				}
			}
			Integer packageId = (Integer) session.getAttribute("packageId");

			if (packageId == null) {
				response.sendRedirect("error.jsp?msg=Package+ID+missing");
				return;
			}

			// Step 3: Create the booking
			dao.createBooking(userId, packageId, eventDate);

			// Step 4: Clean up session attributes
			session.removeAttribute("attendeeCount");
			session.removeAttribute("eventType");
			session.removeAttribute("selectedVenue");
			session.removeAttribute("selectedServices");
			session.removeAttribute("totalCost");

			// Step 5: Redirect to success page
			response.sendRedirect("PackageServlet");

		} catch (Exception e) {
			e.printStackTrace();
			throw new ServletException("Booking process failed", e);
		}
	}
}
