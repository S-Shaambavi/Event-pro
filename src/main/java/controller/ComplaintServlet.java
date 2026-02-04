package controller;

import dao.ComplaintDAO;
import model.Complaint;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@SuppressWarnings("serial")
@WebServlet("/ComplaintServlet")
public class ComplaintServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("user_id") == null) {
			response.sendRedirect("login.jsp");
			return;
		}

		int userId = (int) session.getAttribute("user_id");
		int bookingId = Integer.parseInt(request.getParameter("bookingId"));

		Complaint complaint = fetchEventDetails(bookingId);
		if (complaint != null) {
			complaint.setUserId(userId);
			request.setAttribute("complaint", complaint);
			request.getRequestDispatcher("complaint.jsp").forward(request, response);
		} else {
			response.sendRedirect("user_dashboard.jsp");
		}
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("user_id") == null) {
			response.sendRedirect("login.jsp");
			return;
		}

		int userId = (int) session.getAttribute("user_id");
		int bookingId = Integer.parseInt(request.getParameter("bookingId"));
		String complaintText = request.getParameter("complaintDescription");

		Complaint complaint = new Complaint(userId, bookingId, complaintText);

		ComplaintDAO dao = new ComplaintDAO();
		boolean isSaved = dao.addComplaint(complaint);

		// Fetch event name and date after saving to show them
		Complaint eventDetails = fetchEventDetails(bookingId);
		if (eventDetails != null) {
			complaint.setEventName(eventDetails.getEventName());
			complaint.setEventDate(eventDetails.getEventDate());
		}

		request.setAttribute("complaint", complaint);
		if (isSaved) {
			request.setAttribute("message", "Complaint submitted successfully!");
		} else {

		}

		request.getRequestDispatcher("complaint.jsp").forward(request, response);
	}

	/**
	 * Helper method to fetch event name and date using bookingId.
	 */
	private Complaint fetchEventDetails(int bookingId) {
		ComplaintDAO dao = new ComplaintDAO();
		return dao.getBookingDetailsForComplaint(bookingId);
	}
}
