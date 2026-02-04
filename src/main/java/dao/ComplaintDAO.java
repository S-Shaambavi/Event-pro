package dao;

import model.Complaint;
import util.DatabaseConnection;

import java.sql.*;

public class ComplaintDAO {

    public boolean addComplaint(Complaint complaint) {
        String sql = "INSERT INTO complaints (user_id, booking_id, complaint_text, status) VALUES (?, ?, ?, ?)";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setInt(1, complaint.getUserId());
            stmt.setInt(2, complaint.getBookingId());
            stmt.setString(3, complaint.getComplaintText());
            stmt.setString(4, complaint.getStatus());

            int affectedRows = stmt.executeUpdate();

            if (affectedRows > 0) {
                try (ResultSet rs = stmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        complaint.setComplaintId(rs.getInt(1));
                    }
                }
                return true;
            }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        return false;
    }

    public Complaint getBookingDetailsForComplaint(int bookingId) {
        String sql = "SELECT ep.package_name AS event_name, b.event_date " +
                     "FROM booking b " +
                     "JOIN event_package ep ON b.package_id = ep.package_id " +
                     "WHERE b.booking_id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, bookingId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Complaint complaint = new Complaint();
                complaint.setBookingId(bookingId);
                complaint.setEventName(rs.getString("event_name"));
                complaint.setEventDate(rs.getDate("event_date"));
                return complaint;
            }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        return null;
    }
}
