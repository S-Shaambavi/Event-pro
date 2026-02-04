package controller;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;

import dao.DashboardDAO;
import dao.UserDashboardDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.UserData;
import util.DatabaseConnection;

@WebServlet("/UserDashboardServlet")
public class UserDashboardServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession();
		String email = (String) session.getAttribute("user_email");

		if (email == null) {
			response.sendRedirect("login.jsp?error=Session expired. Please login again.");
			return;
		}

		try {
			Connection conn = DatabaseConnection.getConnection();
			DashboardDAO dashboardDAO = new UserDashboardDAO(conn);
			List<UserData> dashboardData = dashboardDAO.getUserDashboardData(email);
			request.setAttribute("dashboardData", dashboardData);
			RequestDispatcher dispatcher = request.getRequestDispatcher("user-dashboard.jsp");
			dispatcher.forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("error.jsp?msg=Failed to load dashboard.");
		}
	}
}
