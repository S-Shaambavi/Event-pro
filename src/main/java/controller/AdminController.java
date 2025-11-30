package controller;

import java.io.IOException;

import dao.AdminDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/AdminController")
public class AdminController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private AdminDAO adminDAO;

	@Override
	public void init() throws ServletException {
		try {
			adminDAO = new AdminDAO();
		} catch (Exception e) {
			throw new ServletException("DAO Initialization failed", e);
		}
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			int serviceCount = adminDAO.getCount("event_service");
			int packageCount = adminDAO.getCount("event_package");
			int venueCount = adminDAO.getCount("event_venue");
			int userCount = adminDAO.getCount("users");

			request.setAttribute("serviceCount", serviceCount);
			request.setAttribute("packageCount", packageCount);
			request.setAttribute("venueCount", venueCount);
			request.setAttribute("userCount", userCount);

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
