package controller;

import java.io.IOException;
import java.util.List;

import dao.PackagesDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Service;
import model.Venue;

@SuppressWarnings("serial")
@WebServlet("/CustomPackageFormServlet")
public class CustomPackageFormServlet extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			List<Venue> venues = PackagesDAO.getAvailableVenues();
			List<Service> services = PackagesDAO.getAllServices();

			request.setAttribute("venues", venues);
			request.setAttribute("services", services);

			RequestDispatcher dispatcher = request.getRequestDispatcher("customPackageBooking.jsp");
			dispatcher.forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error fetching data.");
		}
	}
}
