package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class CustomPackageDAO {

    // Method to get the venue cost based on the venue ID
    public double getVenueCost(Connection conn, int venueId) throws SQLException {
        String sql = "SELECT venue_cost FROM event_venue WHERE venue_id=?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, venueId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getDouble("venue_cost");
            }
        }
        return 0.0;
    }

    // Method to calculate the total service cost for selected services
    public double calculateServiceCost(Connection conn, String[] serviceIds) throws SQLException {
        double total = 0.0;
        String sql = "SELECT service_price FROM event_service WHERE service_id=?";
        for (String id : serviceIds) {
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, Integer.parseInt(id));
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    total += rs.getDouble("service_price");
                }
            }
        }
        return total;
    }

    // Method to insert a custom package into the event_package table
    public int insertCustomPackage(Connection conn, String packageName, int attendeeCount, int venueId, int userId, double totalCost) throws SQLException {
        String sql = "INSERT INTO event_package (package_name, attendee_count, venue_id, created_by, package_cost) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, packageName);
            stmt.setInt(2, attendeeCount);
            stmt.setInt(3, venueId);
            stmt.setInt(4, userId);
            stmt.setDouble(5, totalCost);
            stmt.executeUpdate();

            // Retrieve the generated package ID
            ResultSet rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1); // Return the generated package ID
            }
        }
        return 0; // Return 0 if insertion fails
    }

    // Method to insert services into the package_services table
    public void insertPackageServices(Connection conn, int packageId, String[] serviceIds) throws SQLException {
        String sql = "INSERT INTO package_services (package_id, service_id) VALUES (?, ?)";
        for (String id : serviceIds) {
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, packageId);
                stmt.setInt(2, Integer.parseInt(id));
                stmt.executeUpdate();
            }
        }
    }
}
