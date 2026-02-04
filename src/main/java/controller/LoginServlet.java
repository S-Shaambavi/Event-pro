package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Admin;
import model.Customer;
import model.Organizer;
import model.UserProfile;
import util.DatabaseConnection;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String email = request.getParameter("user_email");
		String password = request.getParameter("password");

		System.out.println("Login attempt - Email: " + email);

		try (Connection con = DatabaseConnection.getConnection()) {
			String sql = "SELECT * FROM users WHERE user_email=? AND password=?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, email);
			ps.setString(2, password);
			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				int userId = rs.getInt("user_id");
				String firstName = rs.getString("user_fname");
				String lastName = rs.getString("user_lname");
				String phone = rs.getString("user_phone");
				String address = rs.getString("user_address");
				Date dob = rs.getDate("user_dob");
				String profile = rs.getString("user_profile");
				String gender = rs.getString("user_gender");

				// Determine role based on email prefix
				String emailPrefix = email.toLowerCase();

				UserProfile user;
				if (emailPrefix.startsWith("admin")) {
					user = new Admin(userId, email, firstName, lastName, phone, address, password, dob, profile,
							gender);
				} else if (emailPrefix.startsWith("organizer") || emailPrefix.startsWith("event")) {
					user = new Organizer(userId, email, firstName, lastName, phone, address, password, dob, profile,
							gender);
				} else {
					user = new Customer(userId, email, firstName, lastName, phone, address, password, dob, profile,
							gender);
				}

				user.setProfile(profile);
				user.setGender(gender);

				HttpSession session = request.getSession();
				session.setAttribute("User", user);
				session.setAttribute("user_id", user.getUserId());
				session.setAttribute("user_email", email);
				session.setAttribute("user_fname", firstName + " " + lastName);
				session.setAttribute("userProfile", profile);

				// Redirect based on email prefix role
				if (emailPrefix.startsWith("admin")) {
					response.sendRedirect("AdminController");
				} else if (emailPrefix.startsWith("organizer") || emailPrefix.startsWith("event")) {
					response.sendRedirect("OrganizerController");
				} else {
					response.sendRedirect("UserDashboardServlet");
				}
			} else {
				System.out.println("Login failed for Email: " + email);
				response.sendRedirect("login.jsp?error=invalid");
			}

		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("login.jsp?error=server");
		}
	}
}
