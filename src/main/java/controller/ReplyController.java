package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;

import dao.ReplyDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Reply;

@WebServlet("/ReplyController")
public class ReplyController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private ReplyDAO replyDAO;

	@Override
	public void init() throws ServletException {
		try {
			replyDAO = new ReplyDAO();
		} catch (Exception e) {
			throw new ServletException("DAO Initialization failed", e);
		}
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			List<Reply> replyList = replyDAO.getAll();
			request.setAttribute("replyList", replyList);
			request.getRequestDispatcher("/manage-replies.jsp").forward(request, response);
		} catch (SQLException e) {
			e.printStackTrace();
			throw new ServletException("Error fetching reply list", e);
		}
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getParameter("action");
		if (action == null) {
			throw new ServletException("Action parameter is missing");
		}

		try {
			switch (action) {
			case "create":
				createReply(request);
				break;
			case "update":
				updateReply(request);
				break;
			case "delete":
				deleteReply(request);
				break;
			default:
				throw new IllegalArgumentException("Unknown action for reply: " + action);
			}
			response.sendRedirect("manage-replies.jsp");
		} catch (Exception e) {
			throw new ServletException(e);
		}
	}

	private void createReply(HttpServletRequest request) throws SQLException {
		Reply reply = new Reply();
		reply.setComplaint_id(Integer.parseInt(request.getParameter("complaint_id")));
		reply.setReplier_id(Integer.parseInt(request.getParameter("replier_id")));
		reply.setReply_text(request.getParameter("reply_text"));
		reply.setReplied_at(new Timestamp(System.currentTimeMillis()));
		replyDAO.create(reply);
		System.out.println("Replier ID: " + reply.getReplier_id()); // debug
	}

	private void updateReply(HttpServletRequest request) throws SQLException {
		Reply reply = new Reply();
		reply.setReply_id(Integer.parseInt(request.getParameter("reply_id")));
		reply.setComplaint_id(Integer.parseInt(request.getParameter("complaint_id")));
		reply.setReplier_id(Integer.parseInt(request.getParameter("replier_id")));
		reply.setReply_text(request.getParameter("reply_text"));
		reply.setReplied_at(new Timestamp(System.currentTimeMillis()));
		replyDAO.update(reply);
	}

	private void deleteReply(HttpServletRequest request) throws SQLException {
		String id = request.getParameter("reply_id");
		replyDAO.delete(id);
	}
}
