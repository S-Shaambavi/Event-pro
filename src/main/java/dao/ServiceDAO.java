package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import model.Service;
import util.DatabaseConnection;

public class ServiceDAO implements GenericDAO<Service> {
	private final Connection connection;

	public ServiceDAO() throws SQLException, ClassNotFoundException {
		this.connection = DatabaseConnection.getConnection();
	}

	@Override
	public boolean create(Service service) throws SQLException {
		String query = "INSERT INTO event_service (service_id, service_name, service_description, service_price, service_image) VALUES (?, ?, ?, ?, ?)";
		try (PreparedStatement ps = connection.prepareStatement(query)) {
			ps.setString(1, service.getService_id());
			ps.setString(2, service.getService_name());
			ps.setString(3, service.getService_description());
			ps.setDouble(4, service.getService_price());
			ps.setString(5, service.getService_image());
			return ps.executeUpdate() > 0;
		}
	}

	@Override
	public Optional<Service> getById(String id) throws SQLException {
		String query = "SELECT * FROM event_service WHERE service_id = ?";
		try (PreparedStatement ps = connection.prepareStatement(query)) {
			ps.setString(1, id);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				Service service = mapResultSetToService(rs);
				return Optional.of(service);
			}
		}
		return Optional.empty();
	}

	@Override
	public List<Service> getAll() throws SQLException {
		List<Service> services = new ArrayList<>();
		String query = "SELECT * FROM event_service";
		try (Statement stmt = connection.createStatement()) {
			ResultSet rs = stmt.executeQuery(query);
			while (rs.next()) {
				services.add(mapResultSetToService(rs));
			}
		}
		return services;
	}

	@Override
	public boolean update(Service service) throws SQLException {
		String query = "UPDATE event_service SET service_name = ?, service_description = ?, service_price = ?, service_image = ? WHERE service_id = ?";
		try (PreparedStatement ps = connection.prepareStatement(query)) {
			ps.setString(1, service.getService_name());
			ps.setString(2, service.getService_description());
			ps.setDouble(3, service.getService_price());
			ps.setString(4, service.getService_image());
			ps.setString(5, service.getService_id());
			return ps.executeUpdate() > 0;
		}
	}

	@Override
	public boolean delete(String id) throws SQLException {
		String query = "DELETE FROM event_service WHERE service_id = ?";
		try (PreparedStatement ps = connection.prepareStatement(query)) {
			ps.setString(1, id);
			return ps.executeUpdate() > 0;
		}
	}

	private Service mapResultSetToService(ResultSet rs) throws SQLException {
		Service service = new Service();
		service.setService_id(rs.getString("service_id"));
		service.setService_name(rs.getString("service_name"));
		service.setService_description(rs.getString("service_description"));
		service.setService_price(rs.getDouble("service_price"));
		service.setService_image(rs.getString("service_image"));
		return service;
	}
}
