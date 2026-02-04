package controller;

import java.io.IOException;
import java.util.List;

import dao.ComplaintReplyDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ComplaintReply;

@WebServlet("/ViewComplaintReply")
public class ComplaintReplyController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private ComplaintReplyDAO complaintreplyDAO;

	@Override
	public void init() throws ServletException {
		try {
			complaintreplyDAO = new ComplaintReplyDAO();
		} catch (Exception e) {
			throw new ServletException("ComplaintReplyDAO initialization failed", e);
		}
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			List<ComplaintReply> complaintreplies = complaintreplyDAO.getAllComplaintReplies();
			System.out.println("Loaded " + complaintreplies.size() + " complaint replies"); // Debug line
			request.setAttribute("complaintreplies", complaintreplies);
			RequestDispatcher dispatcher = request.getRequestDispatcher("viewpage.jsp");
			dispatcher.forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
			response.sendError(500, "Failed to load complaint replies: " + e.getMessage());
		}
	}
}
