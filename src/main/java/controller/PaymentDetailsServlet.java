package controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.PaymentDetails;
import util.DatabaseConnection;
import dao.PaymentDetailsDAO;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/paymentDetails")
public class PaymentDetailsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		Connection conn = null;
		try {
			// Step 1: Get a database connection
			conn = DatabaseConnection.getConnection();

			// Step 2: Use DAO to fetch payment details
			PaymentDetailsDAO paymentDetailsDAO = new PaymentDetailsDAO(conn);
			List<PaymentDetails> payments = paymentDetailsDAO.getAllPayments();

			// Step 3: Store result in request scope
			request.setAttribute("payments", payments);

			// Step 4: Forward to JSP
			RequestDispatcher dispatcher = request.getRequestDispatcher("/PaymentDetails.jsp");
			dispatcher.forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
			// More specific error handling
			String errorMessage;
			if (e instanceof SQLException) {
				errorMessage = "Database error occurred: " + e.getMessage();
			} else {
				errorMessage = "An unexpected error occurred: " + e.getMessage();
			}

			request.setAttribute("error", errorMessage);
			request.getRequestDispatcher("/PaymentDetails.jsp").forward(request, response);
		} finally {
			// Step 5: Close connection
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException ex) {
					ex.printStackTrace();
					// Log this error but don't propagate it further
					System.err.println("Error closing database connection: " + ex.getMessage());
				}
			}
		}
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// If you need to handle POST requests in the future
		doGet(request, response);
	}
}