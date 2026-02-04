package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import dao.TransactionDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.TransactionModel;

@WebServlet("/TransactionController")
public class TransactionController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private TransactionDAO transactionDAO;

	@Override
	public void init() throws ServletException {
		try {
			transactionDAO = new TransactionDAO();
		} catch (Exception e) {
			throw new ServletException("DAO Initialization failed", e);
		}

	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			System.out.println("Executing doGet() in TransactionController");

			// ✅ Retrieve userId from session
			Integer userId = (Integer) request.getSession().getAttribute("user_id");

			if (userId == null) {
				response.sendRedirect("login.jsp"); // If not logged in
				return;
			}

			List<TransactionModel> transactionList = transactionDAO.getTransactionsByUserId(userId);
			System.out.println("Retrieved " + transactionList.size() + " transactions");

			request.setAttribute("transactionList", transactionList);
			request.getRequestDispatcher("TransactionDetails.jsp").forward(request, response);
		} catch (SQLException e) {
			e.printStackTrace();
			throw new ServletException("Error fetching transaction list", e);
		}
	}

}
