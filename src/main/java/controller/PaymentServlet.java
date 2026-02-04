package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Date;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import dao.PaymentDAO;
import model.TransactionModel;
import model.Payment;

@WebServlet("/paymentServlet")
public class PaymentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private PaymentDAO paymentDAO;

	@Override
	public void init() throws ServletException {
		try {
			paymentDAO = new PaymentDAO();
		} catch (Exception e) {
			throw new ServletException("DAO Initialization failed", e);
		}
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			int bookingId = Integer.parseInt(request.getParameter("bookingId"));
			TransactionModel transaction = paymentDAO.getTransactionByBookingId(bookingId);
			if (transaction == null) {
				request.setAttribute("errorMessage", "Transaction not found.");
				request.getRequestDispatcher("error.jsp").forward(request, response);
				return;
			}
			request.setAttribute("transaction", transaction);
			request.getRequestDispatcher("payment.jsp").forward(request, response);
		} catch (SQLException e) {
			e.printStackTrace();
			throw new ServletException("Error fetching transaction", e);
		}
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			HttpSession session = request.getSession();
			Integer managedBy = (Integer) session.getAttribute("user_id");

			if (managedBy == null) {
				response.sendRedirect("login.jsp");
				return;
			}

			int bookingId = Integer.parseInt(request.getParameter("bookingId"));
			double amount = Double.parseDouble(request.getParameter("amount"));
			String eventName = request.getParameter("eventName");
			String cardNumber = request.getParameter("cardNumber").replaceAll("\\s", "");
			String expiryDate = request.getParameter("expiryDate");
			String cvv = request.getParameter("cardCvv");

			Payment payment = new Payment();
			payment.setBookingId(bookingId);
			payment.setPaymentAmount(amount);
			payment.setCardNumber(cardNumber);
			payment.setExpiryDate(expiryDate);
			payment.setCardCvv(cvv);
			payment.setPaymentDate(new Date());

			paymentDAO.updatePayment(payment);

			// Set session attributes for success page
			session.setAttribute("eventName", eventName);
			session.setAttribute("amount", amount);

			response.sendRedirect("paymentSuccess.jsp"); // Redirect to confirmation page
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("errorMessage", "Error processing payment: " + e.getMessage());
			request.getRequestDispatcher("payment.jsp").forward(request, response);
		}
	}
}