package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import model.Payment;
import model.TransactionModel;
import util.DatabaseConnection; 

public class PaymentDAO {
    private final Connection connection;

    public PaymentDAO() throws SQLException, ClassNotFoundException { 
        this.connection = DatabaseConnection.getConnection();
    }

    public void updatePayment(Payment payment) throws SQLException {
        String query = "UPDATE payment SET card_number = ?, expiry_date = ?, card_cvv = ?, payment_status = 'Complete', payment_date = ? WHERE booking_id = ?";
        
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, payment.getCardNumber());
            stmt.setString(2, payment.getExpiryDate());
            stmt.setString(3, payment.getCardCvv());
            stmt.setTimestamp(4, new Timestamp(System.currentTimeMillis())); // Update payment date to now
            stmt.setInt(5, payment.getBookingId());
            stmt.executeUpdate();
        }
    }
    
    public TransactionModel getTransactionByBookingId(int bookingId) throws SQLException {
        TransactionModel transaction = null;
        String query = "SELECT b.booking_id, ep.package_name, ep.package_cost " +
                       "FROM booking b " +
                       "JOIN event_package ep ON b.package_id = ep.package_id " +
                       "WHERE b.booking_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, bookingId);
            try (var rs = stmt.executeQuery()) {
                if (rs.next()) {
                    transaction = new TransactionModel();
                    transaction.setBookingId(rs.getInt("booking_id"));
                    transaction.setPackageName(rs.getString("package_name"));
                    transaction.setPackageCost(rs.getDouble("package_cost"));
                }
            }
        }
        return transaction;
    }
    
  }
