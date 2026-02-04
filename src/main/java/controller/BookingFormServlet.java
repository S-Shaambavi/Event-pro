package controller;

import java.io.IOException;

import dao.PackagesDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.PackageView; // ✅ Import your actual model class

@WebServlet("/BookingFormServlet")
public class BookingFormServlet extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		int packageId = Integer.parseInt(request.getParameter("package_id")); // Get the package_id from request

		PackagesDAO packageDAO = new PackagesDAO(); // Create PackageDAO instance
		PackageView selectedPackage = packageDAO.getPackageById(packageId); // Retrieve package by ID

		request.setAttribute("selectedPackage", selectedPackage); // Set the package as request attribute
		request.getRequestDispatcher("booking.jsp").forward(request, response); // Forward to booking page
	}
}
