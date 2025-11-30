package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import model.Venue;
import util.DatabaseConnection;

public class VenueDAO implements GenericDAO<Venue> {
	private final Connection connection;

	public VenueDAO() throws SQLException, ClassNotFoundException {
		this.connection = DatabaseConnection.getConnection();
	}

	@Override
	public boolean create(Venue venue) throws SQLException {
		String query = "INSERT INTO event_venue (venue_id, venue_name, venue_status, venue_capacity, venue_cost, venue_image) VALUES (?, ?, ?, ?, ?, ?)";
		try (PreparedStatement ps = connection.prepareStatement(query)) {
			ps.setInt(1, venue.getVenue_id());
			ps.setString(2, venue.getVenue_name());
			ps.setString(3, venue.getVenue_status());
			ps.setInt(4, venue.getVenue_capacity());
			ps.setDouble(5, venue.getVenue_cost());
			ps.setString(6, venue.getVenue_image());
			return ps.executeUpdate() > 0;
		}
	}

	@Override
	public Optional<Venue> getById(String id) throws SQLException {
		String query = "SELECT * FROM event_venue WHERE venue_id = ?";
		try (PreparedStatement ps = connection.prepareStatement(query)) {
			ps.setString(1, id);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				return Optional.of(mapResultSetToVenue(rs));
			}
		}
		return Optional.empty();
	}

	@Override
	public List<Venue> getAll() throws SQLException {
		List<Venue> venue = new ArrayList<>();
		String query = "SELECT * FROM event_venue";
		try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(query)) {
			while (rs.next()) {
				venue.add(mapResultSetToVenue(rs));
			}
		}
		return venue;
	}

	@Override
	public boolean update(Venue venue) throws SQLException {
		String query = "UPDATE event_venue SET venue_name = ?, venue_status = ?, venue_capacity = ?, venue_cost = ?, venue_image = ? WHERE venue_id = ?";
		try (PreparedStatement ps = connection.prepareStatement(query)) {
			ps.setString(1, venue.getVenue_name());
			ps.setString(2, venue.getVenue_status());
			ps.setInt(3, venue.getVenue_capacity());
			ps.setDouble(4, venue.getVenue_cost());
			ps.setString(5, venue.getVenue_image());
			ps.setInt(6, venue.getVenue_id());
			return ps.executeUpdate() > 0;
		}
	}

	@Override
	public boolean delete(String id) throws SQLException {
		String query = "DELETE FROM event_venue WHERE venue_id = ?";
		try (PreparedStatement ps = connection.prepareStatement(query)) {
			ps.setString(1, id);
			return ps.executeUpdate() > 0;
		}
	}

	private Venue mapResultSetToVenue(ResultSet rs) throws SQLException {
		Venue venue = new Venue();
		venue.setVenue_id(rs.getInt("venue_id"));
		venue.setVenue_name(rs.getString("venue_name"));
		venue.setVenue_status(rs.getString("venue_status"));
		venue.setVenue_capacity(rs.getInt("venue_capacity"));
		venue.setVenue_cost(rs.getDouble("venue_cost"));
		venue.setVenue_image(rs.getString("venue_image"));
		return venue;
	}
}