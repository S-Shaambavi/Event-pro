package controller;

import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;

@WebServlet("/UserController")
public class UserController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserDAO userDao;

	public void init() {
		try {
			userDao = new UserDAO();
		} catch (Exception e) {
			throw new RuntimeException("Error initializing DAO", e);
		}
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			List<User> userList = userDao.getAll();
			request.setAttribute("userList", userList);
			request.getRequestDispatcher("/manage-users.jsp").forward(request, response);
		} catch (SQLException e) {
			e.printStackTrace();
			throw new ServletException("Error fetching user list", e);
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
				createUser(request);
				break;
			case "update":
				updateUser(request);
				break;
			case "delete":
				deleteUser(request);
				break;
			case "view":
				viewUser(request, response);
				break;
			default:
				throw new ServletException("Unknown action: " + action);
			}
			response.sendRedirect("manage-users.jsp");
		} catch (Exception e) {
			throw new ServletException(e);
		}
	}

	private void createUser(HttpServletRequest request) throws SQLException {
		User user = new User();
		user.setUser_fName(request.getParameter("user_fName"));
		user.setUser_lName(request.getParameter("user_lName"));
		user.setUser_dob(Date.valueOf(request.getParameter("user_dob")));
		user.setUser_email(request.getParameter("user_email"));
		user.setUser_phone(request.getParameter("user_phone"));
		user.setUser_address(request.getParameter("user_address"));
		user.setUser_gender(request.getParameter("user_gender"));
		user.setPassword(request.getParameter("password"));
		user.setUser_role(request.getParameter("user_role"));
		user.setCreated_at(LocalDateTime.now().toString());
		user.setUser_profile(request.getParameter("user_profile"));

		userDao.create(user);
	}

	private void updateUser(HttpServletRequest request) throws SQLException {
		User user = new User();
		user.setUser_id(Integer.parseInt(request.getParameter("user_id")));
		user.setUser_fName(request.getParameter("user_fName"));
		user.setUser_lName(request.getParameter("user_lName"));
		user.setUser_dob(Date.valueOf(request.getParameter("user_dob")));
		user.setUser_email(request.getParameter("user_email"));
		user.setUser_phone(request.getParameter("user_phone"));
		user.setUser_address(request.getParameter("user_address"));
		user.setUser_gender(request.getParameter("user_gender"));
		user.setPassword(request.getParameter("password"));
		user.setUser_role(request.getParameter("user_role"));
		user.setCreated_at(request.getParameter("created_at"));
		user.setUser_profile(request.getParameter("user_profile"));

		userDao.update(user);
	}

	private void deleteUser(HttpServletRequest request) throws SQLException {
		String userId = request.getParameter("user_id");
		userDao.delete(userId);
	}

	private void viewUser(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		String userId = request.getParameter("user_id");
		Optional<User> user = userDao.getById(userId);
		request.setAttribute("user", user);
		request.getRequestDispatcher("update-user.jsp").forward(request, response);
	}

}
