package controller;

import java.io.IOException;
import java.util.List;

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
import model.Team;

@WebServlet("/OrganizerController")
public class OrganizerController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private OrganizerDAO organizerDAO;
	private ComplaintReplyDAO complaintReplyDAO;

	@Override
	public void init() throws ServletException {
		try {
			organizerDAO = new OrganizerDAO();
			complaintReplyDAO = new ComplaintReplyDAO();
		} catch (Exception e) {
			throw new ServletException("DAO Initialization failed", e);
		}
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		String email = (String) session.getAttribute("user_email");
		if (email == null) {
			response.sendRedirect("login.jsp?error=Session expired. Please login again.");
			return;
		}
		try {
			List<BookingDetails> bookings = organizerDAO.getAllBookings();
			List<Team> teams = organizerDAO.getAllTeams();
			List<ComplaintReply> complaintReplies = complaintReplyDAO.getAllComplaintReplies();
			List<PaymentDetails> payments = organizerDAO.getAllPayments();

			request.setAttribute("bookings", bookings);
			request.setAttribute("teams", teams);
			request.setAttribute("complaintReplies", complaintReplies);
			request.setAttribute("payments", payments);

			request.getRequestDispatcher("/organizer.jsp").forward(request, response);
			RequestDispatcher dispatcher = request.getRequestDispatcher("organizer.jsp");
			dispatcher.forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("errorMessage", e.getMessage());
			request.getRequestDispatcher("/error.jsp").forward(request, response);
		}
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getParameter("action");

		try {
			if (action == null) {
				response.sendRedirect("OrganizerController");
				return;
			}

			switch (action) {
			case "replyComplaints":
				handleReplyComplaint(request, response);
				break;
			case "assignTeams":
				handleAssignTeams(request, response);
				break;
			default:
				response.sendRedirect("OrganizerController");
				break;
			}
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("errorMessage", e.getMessage());
			request.getRequestDispatcher("/error.jsp").forward(request, response);
		}
	}

	private void handleReplyComplaint(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("Replying to complaint...");
		response.sendRedirect("OrganizerController");
	}

	private void handleAssignTeams(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("Assigning team...");
		response.sendRedirect("OrganizerController");
	}

}
