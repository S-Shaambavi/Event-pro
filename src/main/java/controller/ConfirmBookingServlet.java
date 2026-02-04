package controller;

import java.io.IOException;
import java.sql.Date;

import dao.BookingDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Booking;

@SuppressWarnings("serial")
@WebServlet("/ConfirmBookingServlet")
public class ConfirmBookingServlet extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// Get the package ID and event date from the form
		int packageId = Integer.parseInt(request.getParameter("package_id"));
		String eventDate = request.getParameter("event_date");

		// Get the customer ID from the session
		HttpSession session = request.getSession();
		int customerId = (int) session.getAttribute("user_id");

		// Create a Booking object with the provided information
		Booking booking = new Booking(customerId, packageId, Date.valueOf(eventDate));

		// Create an instance of BookingDAO to insert the booking into the database
		BookingDAO bookingDAO = new BookingDAO();
		try {
			bookingDAO.insertBooking(booking);
		} catch (Exception e) {
			// Handle exception if necessary (for example, logging the error)
			e.printStackTrace();
		}

		// Redirect to the PackageServlet to show updated package list
		response.sendRedirect("PackageServlet");
	}
}
