package dao;

import model.EventPackage;

import java.sql.*;
import java.util.List;
import java.util.ArrayList;
import java.util.Collections;

public class EventPackageDAO {
    private Connection conn;

    public EventPackageDAO(Connection conn) {
        this.conn = conn;
    }

    // Get venue cost by venue ID
    public double getVenueCost(int venueId) throws SQLException {
        String sql = "SELECT venue_cost FROM event_venue WHERE venue_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, venueId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getDouble("venue_cost");
                }
            }
        }
        return 0.0;
    }

    // Get service cost by service ID
    public double getServiceCost(int serviceId) throws SQLException {
        String sql = "SELECT service_price FROM event_service WHERE service_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, serviceId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getDouble("service_price");
                }
            }
        }
        return 0.0;
    }

    // Calculate total cost of the package (venue + all services)
    public double calculateTotalCost(int venueId, List<Integer> serviceIds) throws SQLException {
        double total = getVenueCost(venueId);
        for (int id : serviceIds) {
            total += getServiceCost(id);
        }
        return total;
    }

    // Create a new event package and return generated package ID
    public int createPackage(EventPackage ep) throws SQLException {
        String sql = "INSERT INTO event_package (package_name, attendee_count, venue_id, created_by, package_cost) " +
                     "VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, ep.getName());
            ps.setInt(2, ep.getAttendeeCount());
            ps.setInt(3, ep.getVenueId());
            ps.setInt(4, ep.getCreatedBy());
            ps.setDouble(5, ep.getTotalCost());

            int affectedRows = ps.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Creating package failed, no rows affected.");
            }

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1);
                } else {
                    throw new SQLException("Creating package failed, no ID obtained.");
                }
            }
        }
    }

    // Link services to the package
    public void insertPackageServices(int packageId, List<Integer> serviceIds) throws SQLException {
        String sql = "INSERT INTO package_services (package_id, service_id) VALUES (?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            for (int serviceId : serviceIds) {
                ps.setInt(1, packageId);
                ps.setInt(2, serviceId);
                ps.addBatch();
            }
            ps.executeBatch();
        }
    }

    // Create a booking for a given customer and package on a specific date
    public void createBooking(int customerId, int packageId, java.sql.Date eventDate) throws SQLException {
        String sql = "INSERT INTO booking (customer_id, package_id, event_date) VALUES (?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, customerId);
            ps.setInt(2, packageId);
            ps.setDate(3, eventDate);
            ps.executeUpdate();
        }
    }

    // Get venue name by venue ID
    public String getVenueNameById(int venueId) throws SQLException {
        String sql = "SELECT venue_name FROM event_venue WHERE venue_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, venueId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("venue_name");
                }
            }
        }
        return "Unknown Venue";
    }

    // Get list of service names by service IDs
    public List<String> getServiceNamesByIds(List<Integer> serviceIds) throws SQLException {
        List<String> serviceNames = new ArrayList<>();
        if (serviceIds == null || serviceIds.isEmpty()) return serviceNames;

        String placeholders = String.join(",", Collections.nCopies(serviceIds.size(), "?"));
        String sql = "SELECT service_name FROM event_service WHERE service_id IN (" + placeholders + ")";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            for (int i = 0; i < serviceIds.size(); i++) {
                ps.setInt(i + 1, serviceIds.get(i));
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    serviceNames.add(rs.getString("service_name"));
                }
            }
        }
        return serviceNames;
    }
    public void deletePackageServices(int packageId) throws SQLException {
        String sql = "DELETE FROM package_services WHERE package_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, packageId);
            stmt.executeUpdate();
        }
    }

    public void deletePackage(int packageId) throws SQLException {
        String sql = "DELETE FROM event_package WHERE package_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, packageId);
            stmt.executeUpdate();
        }
    }

}
