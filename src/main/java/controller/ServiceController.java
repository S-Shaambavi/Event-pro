package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import dao.ServiceDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Service;

@WebServlet("/ServiceController")
public class ServiceController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private ServiceDAO serviceDAO;

	@Override
	public void init() throws ServletException {
		try {
			serviceDAO = new ServiceDAO();
		} catch (Exception e) {
			throw new ServletException("DAO Initialization failed", e);
		}
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			System.out.println("Executing doGet() in UserController");
			List<Service> serviceList = serviceDAO.getAll();
			System.out.println("Retrieved " + serviceList.size() + " services");
			request.setAttribute("serviceList", serviceList);
			request.getRequestDispatcher("/manage-services.jsp").forward(request, response);
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
				createService(request);
				break;
			case "update":
				updateService(request);
				break;
			case "delete":
				deleteService(request);
				break;
			default:
				throw new IllegalArgumentException("Unknown action for service: " + action);
			}
			response.sendRedirect("manage-services.jsp");
		} catch (Exception e) {
			throw new ServletException(e);
		}
	}

	private void createService(HttpServletRequest request) throws SQLException {
		Service service = new Service();
		service.setService_name(request.getParameter("service_name"));
		service.setService_description(request.getParameter("service_description"));
		service.setService_price(Double.parseDouble(request.getParameter("service_price")));
		service.setService_image(request.getParameter("service_image"));
		serviceDAO.create(service);
	}

	private void updateService(HttpServletRequest request) throws SQLException {
		Service service = new Service();
		service.setService_id(Integer.parseInt(request.getParameter("service_id")));
		service.setService_name(request.getParameter("service_name"));
		service.setService_description(request.getParameter("service_description"));
		service.setService_price(Double.parseDouble(request.getParameter("service_price")));
		service.setService_image(request.getParameter("service_image"));
		serviceDAO.update(service);
	}

	private void deleteService(HttpServletRequest request) throws SQLException {
		String id = request.getParameter("service_id");
		serviceDAO.delete(id);
	}
}
