package controller;

import model.UserProfile;
import dao.UserProfileDAO;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/DeleteAccount")
public class DeleteAccount extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession(false);

		if (session != null) {
			UserProfile user = (UserProfile) session.getAttribute("User");

			if (user != null) {
				boolean deleted = UserProfileDAO.deleteUser(user.getEmail());

				if (deleted) {
					session.invalidate(); // Logout user
					response.sendRedirect("login.jsp"); // Redirect to goodbye page or login
				} else {
					response.sendRedirect("profile.jsp?error=deletionFailed");
				}
			} else {
				response.sendRedirect("login.jsp");
			}
		} else {
			response.sendRedirect("login.jsp");
		}
	}
}
