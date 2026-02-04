package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import dao.PackageDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Package;

@WebServlet("/PackageController")
public class PackageController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private PackageDAO packageDAO;

	@Override
	public void init() throws ServletException {
		try {
			packageDAO = new PackageDAO();
		} catch (Exception e) {
			throw new ServletException("DAO Initialization failed", e);
		}
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			List<Package> packageList = packageDAO.getAll();
			request.setAttribute("packageList", packageList);
			request.getRequestDispatcher("manage-packages.jsp").forward(request, response);
		} catch (SQLException e) {
			e.printStackTrace();
			throw new ServletException("Error fetching package list", e);
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
				createPackage(request);
				break;
			case "update":
				updatePackage(request);
				break;
			case "delete":
				deletePackage(request);
				break;
			default:
				throw new IllegalArgumentException("Unknown action for package: " + action);
			}
			response.sendRedirect("PackageController");
		} catch (Exception e) {
			throw new ServletException(e);
		}
	}

	private void createPackage(HttpServletRequest request) throws SQLException {
		Package pack = new Package();
		pack.setPackage_name(request.getParameter("package_name"));
		pack.setAttendee_count(Integer.parseInt(request.getParameter("attendee_count")));
		pack.setPackage_venue(Integer.parseInt(request.getParameter("package_venue")));
		pack.setPackage_creator(Integer.parseInt(request.getParameter("package_creator")));
		pack.setPackage_cost(Double.parseDouble(request.getParameter("package_cost")));
		packageDAO.create(pack);
	}

	private void updatePackage(HttpServletRequest request) throws SQLException {
		Package pack = new Package();
		pack.setPackage_id(Integer.parseInt(request.getParameter("package_id")));
		pack.setPackage_name(request.getParameter("package_name"));
		pack.setAttendee_count(Integer.parseInt(request.getParameter("attendee_count")));
		pack.setPackage_venue(Integer.parseInt(request.getParameter("package_venue")));
		pack.setPackage_creator(Integer.parseInt(request.getParameter("package_creator")));
		pack.setPackage_cost(Double.parseDouble(request.getParameter("package_cost")));
		packageDAO.update(pack);
	}

	private void deletePackage(HttpServletRequest request) throws SQLException {
		String id = request.getParameter("package_id");
		packageDAO.delete(id);
	}
}
