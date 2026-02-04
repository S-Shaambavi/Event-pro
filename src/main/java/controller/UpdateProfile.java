package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import model.UserProfile; // Use your abstract class
import util.DatabaseConnection;

@WebServlet("/UpdateProfile")
public class UpdateProfile extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession();
		UserProfile user = (UserProfile) session.getAttribute("User");

		if (user == null) {
			response.sendRedirect("login.jsp");
			return;
		}

		String firstName = request.getParameter("firstName");
		String lastName = request.getParameter("lastName");
		String phone = request.getParameter("phone");
		String address = request.getParameter("address");
		String password = request.getParameter("password");

		user.setFirstName(firstName);
		user.setLastName(lastName);
		user.setPhone(phone);
		user.setAddress(address);
		user.setPassword(password);

		try (Connection con = DatabaseConnection.getConnection()) {
			PreparedStatement ps = con.prepareStatement(
					"UPDATE users SET user_fname=?, user_lname=?, user_phone=?, user_address=?, password=? WHERE user_email=?");
			ps.setString(1, firstName);
			ps.setString(2, lastName);
			ps.setString(3, phone);
			ps.setString(4, address);
			ps.setString(5, password);
			ps.setString(6, user.getEmail());
			ps.executeUpdate();

			response.sendRedirect("UserProfile.jsp");

		} catch (Exception e) {
			e.printStackTrace();
			response.getWriter().println("Error updating profile.");
		}
	}
}
