package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import model.Package;
import util.DatabaseConnection;

public class PackageDAO implements GenericDAO<Package> {
	private final Connection connection;

	public PackageDAO() throws SQLException, ClassNotFoundException {
		this.connection = DatabaseConnection.getConnection();
	}

	@Override
	public boolean create(Package pack) throws SQLException {
		String query = "INSERT INTO event_package (package_name, attendee_count, venue_id, created_by, package_cost) VALUES (?, ?, ?, ?, ?)";
		try (PreparedStatement ps = connection.prepareStatement(query)) {
			ps.setString(1, pack.getPackage_name());
			ps.setInt(2, pack.getAttendee_count());
			ps.setInt(3, pack.getPackage_venue());
			ps.setInt(4, pack.getPackage_creator());
			ps.setDouble(5, pack.getPackage_cost());
			return ps.executeUpdate() > 0;
		}
	}
	
	@Override
	public Optional<Package> getById(String id) throws SQLException {
		String query = "SELECT * FROM event_package WHERE package_id = ?";
		try (PreparedStatement ps = connection.prepareStatement(query)) {
			ps.setInt(1, Integer.parseInt(id));
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				return Optional.of(mapResultSetToPackage(rs));
			}
		}
		return Optional.empty();
	}

	@Override
	public List<Package> getAll() throws SQLException {
		List<Package> packages = new ArrayList<>();
		String query = "SELECT * FROM event_package";
		try (Statement stmt = connection.createStatement()) {
			ResultSet rs = stmt.executeQuery(query);
			while (rs.next()) {
				packages.add(mapResultSetToPackage(rs));
			}
		}
		return packages;
	}

	@Override
	public boolean update(Package pack) throws SQLException {
		String query = "UPDATE event_package SET package_name = ?, attendee_count = ?, venue_id = ?, created_by = ?, package_cost = ? WHERE package_id = ?";
		try (PreparedStatement ps = connection.prepareStatement(query)) {
			ps.setString(1, pack.getPackage_name());
			ps.setInt(2, pack.getAttendee_count());
			ps.setInt(3, pack.getPackage_venue());
			ps.setInt(4, pack.getPackage_creator());
			ps.setDouble(5, pack.getPackage_cost());
			ps.setInt(6, pack.getPackage_id());
			return ps.executeUpdate() > 0;
		}
	}

	@Override
	public boolean delete(String id) throws SQLException {
		String query = "DELETE FROM event_package WHERE package_id = ?";
		try (PreparedStatement ps = connection.prepareStatement(query)) {
			ps.setInt(1, Integer.parseInt(id));
			return ps.executeUpdate() > 0;
		}
	}

	private Package mapResultSetToPackage(ResultSet rs) throws SQLException {
		Package pack = new Package();
		pack.setPackage_id(rs.getInt("package_id"));
		pack.setPackage_name(rs.getString("package_name"));
		pack.setAttendee_count(rs.getInt("attendee_count"));
		pack.setPackage_venue(rs.getInt("venue_id")); 
		pack.setPackage_creator(rs.getInt("created_by"));
		pack.setPackage_cost(rs.getDouble("package_cost"));
		return pack;
	}

	public static List<Package> searchEvents(String query) throws ClassNotFoundException {
	    List<Package> resultList = new ArrayList<>();
	    String sql = "SELECT * FROM packages WHERE package_name LIKE ? OR description LIKE ? OR category LIKE ?";

	    try (Connection conn = DatabaseConnection.getConnection();
	         PreparedStatement stmt = conn.prepareStatement(sql)) {

	        String keyword = "%" + query + "%";
	        stmt.setString(1, keyword);
	        stmt.setString(2, keyword);
	        stmt.setString(3, keyword);

	        ResultSet rs = stmt.executeQuery();
	        while (rs.next()) {
	            Package pack = new Package();
	            pack.setPackage_id(rs.getInt("package_id"));
	    		pack.setPackage_name(rs.getString("package_name"));
	    		pack.setAttendee_count(rs.getInt("attendee_count"));
	    		pack.setPackage_venue(rs.getInt("venue_id")); 
	    		pack.setPackage_creator(rs.getInt("created_by"));
	    		pack.setPackage_cost(rs.getDouble("package_cost"));
	            // add other fields as needed
	            resultList.add(pack);
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return resultList;
	}

}
