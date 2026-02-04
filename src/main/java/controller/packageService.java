package controller;

import dao.EventPackageDAO;
import dao.serviceDetailsDAO;
import dao.serviceDAOImpl;
import dao.venueDetailsDAO;
import dao.venueDAOImpl;
import model.EventPackage;
import model.Service;
import model.Venue;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

public class packageService {
	private final venueDetailsDAO venueDAO;
	private final serviceDetailsDAO serviceDAO;
	private final EventPackageDAO packageDAO;
	private final Connection conn;

	public packageService(Connection conn) {
		this.conn = conn;
		this.venueDAO = new venueDAOImpl(conn);
		this.serviceDAO = new serviceDAOImpl(conn);
		this.packageDAO = new EventPackageDAO(conn);
	}

	// ✅ NEW: Create and link custom package
	public int createCustomPackage(EventPackage ep, List<Integer> serviceIds) throws SQLException {
		EventPackageDAO dao = new EventPackageDAO(conn);
		int packageId = dao.createPackage(ep); // Save package and get ID
		dao.insertPackageServices(packageId, serviceIds); // Link services
		return packageId;
	}

	public void deletePackageServiceMappings(int packageId) throws SQLException {
		packageDAO.deletePackageServices(packageId);
	}

	// ✅ Delete package by ID
	public void deletePackageById(int packageId) throws SQLException {
		packageDAO.deletePackage(packageId);
	}

	public List<Venue> getAvailableVenues() throws SQLException {
		return venueDAO.getAllAvailableVenues();
	}

	public List<Service> getAllServices() throws SQLException {
		return serviceDAO.getAllServices();
	}

	public Venue getVenueById(String venueId) throws SQLException {
		return venueDAO.getVenueById(venueId);
	}

	public Service getServiceById(int serviceId) throws SQLException {
		return serviceDAO.getServiceById(serviceId);
	}

	public double calculateTotalCost(Venue venue, List<Service> services) {
		double total = 0.0;
		if (venue != null) {
			total += venue.getVenue_cost();
		}
		if (services != null) {
			for (Service service : services) {
				if (service != null) {
					total += service.getService_price();
				}
			}
		}
		return total;
	}

}
