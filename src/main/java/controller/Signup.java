package controller;

import dao.UserDAO;
import dao.UserProfileDAO;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Date;

@WebServlet("/Signup")
public class Signup extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String firstName = request.getParameter("firstName");
		String lastName = request.getParameter("lastName");
		String dobString = request.getParameter("dob");
		Date userDob = null;
		if (dobString != null && !dobString.isEmpty()) {
			userDob = Date.valueOf(dobString); // java.sql.Date
		}

		String phone = request.getParameter("phone");
		String address = request.getParameter("address");
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String confirmPassword = request.getParameter("confirmPassword");
		String gender = request.getParameter("gender");

		// Input Validation
		if (firstName == null || lastName == null || userDob == null || phone == null || address == null
				|| email == null || password == null || confirmPassword == null || gender == null || firstName.isEmpty()
				|| lastName.isEmpty() || phone.isEmpty() || address.isEmpty() || email.isEmpty() || password.isEmpty()
				|| confirmPassword.isEmpty() || gender.isEmpty()) {
			response.sendRedirect("signup.jsp?error=All fields are required");
			return;
		}

		if (!password.equals(confirmPassword)) {
			response.sendRedirect("signup.jsp?error=Passwords do not match");
			return;
		}

		if (!phone.matches("\\d{10}")) {
			response.sendRedirect("signup.jsp?error=Phone number must be 10 digits");
			return;
		}

		if (!email.matches("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$")) {
			response.sendRedirect("signup.jsp?error=Invalid email format");
			return;
		}

		// Create user object
		User user = new User();
		user.setUser_fName(firstName);
		user.setUser_lName(lastName);
		user.setUser_dob(userDob);
		user.setUser_phone(phone);
		user.setUser_address(address);
		user.setUser_email(email);
		user.setPassword(password);
		user.setUser_gender(gender);

		// Save user in DB
		int userId = UserProfileDAO.insertUser(user);

		if (userId > 0) {
			HttpSession session = request.getSession();
			session.setAttribute("userId", userId);
			session.setAttribute("firstName", firstName);
			session.setAttribute("lastName", lastName);

			response.sendRedirect("user-dashboard.jsp");
		} else {
			response.sendRedirect("signup.jsp?error=Signup failed. Try again.");
		}
	}
}
