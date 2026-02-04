package controller;

import java.io.IOException;
import java.util.List;

import dao.AdminDAO;
import dao.BookingDetailsDAO;
import dao.ComplaintReplyDAO;
import dao.OrganizerDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.BookingDetails;
import model.ComplaintReply;
import model.PaymentDetails;

@WebServlet("/AdminController")
public class AdminController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private AdminDAO adminDAO;
	private OrganizerDAO organizerDAO;
	private BookingDetailsDAO bookingDAO;
	private ComplaintReplyDAO complaintReplyDAO;

	@Override
	public void init() throws ServletException {
		try {
			adminDAO = new AdminDAO();
			organizerDAO = new OrganizerDAO();
			bookingDAO = new BookingDetailsDAO();
			complaintReplyDAO = new ComplaintReplyDAO();

		} catch (Exception e) {
			throw new ServletException("DAO Initialization failed", e);
		}
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		String email = (String) session.getAttribute("user_email");

		if (email == null) {
			response.sendRedirect("login.jsp?error=Session expired. Please login again.");
			return;
		}
		try {
			int serviceCount = adminDAO.getCount("event_service");
			int packageCount = adminDAO.getCount("event_package");
			int venueCount = adminDAO.getCount("event_venue");
			int userCount = adminDAO.getCount("users");
			int complaintCount = adminDAO.getCount("complaints");

			List<BookingDetails> booking = bookingDAO.getAllBookings();
			List<ComplaintReply> complaintreply = complaintReplyDAO.getAllComplaintReplies();
			List<PaymentDetails> payments = organizerDAO.getAllPayments();

			request.setAttribute("complaintCount", complaintCount);
			request.setAttribute("serviceCount", serviceCount);
			request.setAttribute("packageCount", packageCount);
			request.setAttribute("venueCount", venueCount);
			request.setAttribute("userCount", userCount);
			request.setAttribute("booking", booking);
			request.setAttribute("payments", payments);
			request.setAttribute("complaintreply", complaintreply);

			RequestDispatcher dispatcher = request.getRequestDispatcher("admin-dashboard.jsp");
			dispatcher.forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
			response.sendError(500, "Error loading admin dashboard");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {

		} catch (Exception e) {
			e.printStackTrace();
			response.sendError(500, "Error loading admin dashboard");
		}
	}
}
