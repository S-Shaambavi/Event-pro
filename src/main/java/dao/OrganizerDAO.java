package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.BookingDetails;
import model.PaymentDetails;
import model.Team;
import util.DatabaseConnection;

public class OrganizerDAO {
    private final Connection connection;

	public OrganizerDAO() throws SQLException, ClassNotFoundException {
		this.connection = DatabaseConnection.getConnection();
	}

    public List<BookingDetails> getAllBookings() throws SQLException {
        List<BookingDetails> bookings = new ArrayList<>();
        String query = "SELECT * FROM booking_details"; // corrected table name

        try (PreparedStatement ps = connection.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                BookingDetails booking = new BookingDetails();
                booking.setBookingId(rs.getInt("booking_id"));
                booking.setCustomer_name(rs.getString("customer_name"));
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
    
    public List<PaymentDetails> getAllPayments() throws SQLException {
        List<PaymentDetails> payments = new ArrayList<>();
        String query = "SELECT " +
                "p.payment_id, " +
                "ep.package_name AS event_name, " +
                "b.booking_date, " +
                "p.payment_date, " +
                "p.payment_amount, " +
                "p.payment_status, " +
                "p.card_number, " +
                "p.expiry_date, " +
                "p.card_cvv " +
                "FROM payment p " +
                "JOIN booking b ON p.booking_id = b.booking_id " +
                "JOIN event_package ep ON b.package_id = ep.package_id " +
                "JOIN users u ON b.customer_id = u.user_id " +
                "ORDER BY p.payment_date DESC"; // corrected table name

        try (PreparedStatement ps = connection.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
            	PaymentDetails payment = new PaymentDetails();
            	payment.setPaymentId(rs.getInt("payment_id"));
            	payment.setEventName(rs.getString("event_name"));
            	payment.setBookingDate(rs.getString("booking_date"));
            	payment.setPaymentDate(rs.getString("payment_date"));
            	payment.setPaymentStatus(rs.getString("payment_status"));
            	payment.setPaymentAmount(rs.getDouble("payment_amount"));
            	payment.setCardNumber(rs.getString("card_number"));
            	payment.setExpiryDate(rs.getString("expiry_date"));
            	payment.setCardCvv(rs.getString("card_cvv"));
                payments.add(payment);
            }
        }
        return payments;
    }
}
