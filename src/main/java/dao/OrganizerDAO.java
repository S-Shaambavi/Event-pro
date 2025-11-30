package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import model.Booking;
import model.Complaint;
import model.Team;
import util.DatabaseConnection;

public class OrganizerDAO {
    private final Connection connection;

	public OrganizerDAO() throws SQLException, ClassNotFoundException {
		this.connection = DatabaseConnection.getConnection();
	}

	public List<Complaint> getAllComplaints() throws SQLException {
		List<Complaint> complaints = new ArrayList<>();
		String query = "SELECT * FROM complaints";

		try (Statement stmt = connection.createStatement(); 
				ResultSet rs = stmt.executeQuery(query)) {
			while (rs.next()) {
				Complaint complaint = new Complaint();
				complaint.setComplaint_id(rs.getInt("complaint_id"));
				complaint.setUser_id(rs.getInt("user_id"));
				complaint.setComplaint_text(rs.getString("complaint_text"));
				complaint.setComplaint_status(rs.getString("status"));
				complaint.setComplaint_at(rs.getTimestamp("created_at"));

				complaints.add(complaint);
			}
		}
		return complaints;
	}

    public List<Booking> getAllBookings() throws SQLException {
        List<Booking> bookings = new ArrayList<>();
        String query = "SELECT * FROM booking_details"; // corrected table name

        try (PreparedStatement ps = connection.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Booking booking = new Booking();
                booking.setBookingId(rs.getInt("booking_id"));
                booking.setCustomerId(rs.getInt("customer_id"));
                booking.setPackageId(rs.getInt("package_id"));
                booking.setPackageName(rs.getString("package_name"));
                booking.setAttendeeCount(rs.getInt("attendee_count"));
                booking.setPackageVenue(rs.getString("package_venue"));
                booking.setPaymentStatus(rs.getString("payment_status"));
                booking.setBookingDate(rs.getTimestamp("booking_date"));
                bookings.add(booking);
            }
        }
        return bookings;
    }

    public List<Team> getAllTeams() throws SQLException {
        List<Team> teams = new ArrayList<>();
        String query = "SELECT * FROM teams";

        try (PreparedStatement ps = connection.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Team team = new Team();
                team.setTeamId(rs.getInt("team_id"));
                team.setTeamName(rs.getString("team_name"));
                team.setNoOfWorkers(rs.getInt("no_of_workers"));
                team.setBooking_id(rs.getInt("booking_id"));
                team.setAssigned_by(rs.getInt("assigned_by"));
                teams.add(team);
            }
        }
        return teams;
    }
}
