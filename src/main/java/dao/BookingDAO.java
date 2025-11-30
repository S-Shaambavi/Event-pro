package dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import model.Booking;
import util.DatabaseConnection;

public class BookingDAO {
	private final Connection connection;

	public BookingDAO() throws SQLException, ClassNotFoundException {
		this.connection = DatabaseConnection.getConnection();
	}

	public List<Booking> getAllBookings() throws SQLException {
		List<Booking> bookings = new ArrayList<>();
		String query = "SELECT * FROM booking_details";
		try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(query)) {

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
}
