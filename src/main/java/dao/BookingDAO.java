package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import model.Booking;
import util.DatabaseConnection;

public class BookingDAO {

    // Method to insert a new booking into the database
    public void insertBooking(Booking booking) throws SQLException, ClassNotFoundException {
        String sql = "INSERT INTO booking (customer_id, package_id, event_date) VALUES (?, ?, ?)";
        
        try (Connection con = DatabaseConnection.getConnection();  // Automatically closes connection
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            // Set the parameters for the prepared statement
            ps.setInt(1, booking.getCustomerId());
            ps.setInt(2, booking.getPackageId());
            ps.setDate(3, booking.getEventDate());
            
            // Execute the update to insert the booking
            ps.executeUpdate();
            
        } catch (SQLException e) {
            // Print stack trace or log the error message
            System.err.println("Error inserting booking: " + e.getMessage());
            throw e;  // Rethrow the exception for further handling
        }
    }
}
