package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import dao.VenueDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Venue;

@WebServlet("/VenueController")
public class VenueController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private VenueDAO venueDAO;

	@Override
	public void init() throws ServletException {
		try {
			venueDAO = new VenueDAO();
		} catch (Exception e) {
			throw new ServletException("DAO Initialization failed", e);
		}
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			System.out.println("Executing doGet() in VenueController");
			List<Venue> venueList = venueDAO.getAll();
			System.out.println("Retrieved " + venueList.size() + " venue");
			request.setAttribute("venueList", venueList);
			request.getRequestDispatcher("/manage-venues.jsp").forward(request, response);
		} catch (SQLException e) {
			e.printStackTrace();
			throw new ServletException("Error fetching venue list", e);
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
				createVenue(request);
				break;
			case "update":
				updateVenue(request);
				break;
			case "delete":
				deleteVenue(request);
				break;
			default:
				throw new IllegalArgumentException("Unknown action for venue: " + action);
			}

			response.sendRedirect("manage-venues.jsp");
		} catch (Exception e) {
			throw new ServletException(e);
		}
	}

	private void createVenue(HttpServletRequest request) throws SQLException {
		Venue venue = new Venue();
		venue.setVenue_name(request.getParameter("venue_name"));
		venue.setVenue_status(request.getParameter("venue_status"));
		venue.setVenue_capacity(Integer.parseInt(request.getParameter("venue_capacity")));
		venue.setVenue_cost(Double.parseDouble(request.getParameter("venue_cost")));
		venue.setVenue_image(request.getParameter("venue_image"));
		venueDAO.create(venue);
	}

	private void updateVenue(HttpServletRequest request) throws SQLException {
		Venue venue = new Venue();
		venue.setVenue_id(Integer.parseInt(request.getParameter("venue_id")));
		venue.setVenue_name(request.getParameter("venue_name"));
		venue.setVenue_status(request.getParameter("venue_status"));
		venue.setVenue_capacity(Integer.parseInt(request.getParameter("venue_capacity")));
		venue.setVenue_cost(Double.parseDouble(request.getParameter("venue_cost")));
		venue.setVenue_image(request.getParameter("venue_image"));
		venueDAO.update(venue);
	}

	private void deleteVenue(HttpServletRequest request) throws SQLException {
		String id = request.getParameter("venue_id");
		venueDAO.delete(id);
	}
}