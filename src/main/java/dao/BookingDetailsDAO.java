package dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import model.BookingDetails;
import util.DatabaseConnection;

public class BookingDetailsDAO {
	private final Connection connection;

	public BookingDetailsDAO() throws SQLException, ClassNotFoundException {
		this.connection = DatabaseConnection.getConnection();
	}

	public List<BookingDetails> getAllBookings() throws SQLException {
		List<BookingDetails> bookings = new ArrayList<>();
		String query = "SELECT * FROM booking_details";
		try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(query)) {

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
}
