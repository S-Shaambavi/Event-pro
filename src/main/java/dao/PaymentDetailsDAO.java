package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import model.PaymentDetails;

public class PaymentDetailsDAO {
    private Connection conn;

    public PaymentDetailsDAO(Connection conn) {
        this.conn = conn;
    }

    public List<PaymentDetails> getAllPayments() throws SQLException { 
        List<PaymentDetails> payments = new ArrayList<>();  

        String sql = "SELECT " +
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
                "ORDER BY p.payment_date DESC";
        
        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                PaymentDetails pd = new PaymentDetails(); 
                pd.setPaymentId(rs.getInt("payment_id"));
                pd.setEventName(rs.getString("event_name"));
                pd.setBookingDate(rs.getString("booking_date"));
                pd.setPaymentDate(rs.getString("payment_date"));
                pd.setPaymentStatus(rs.getString("payment_status"));
                pd.setPaymentAmount(rs.getDouble("payment_amount"));
                pd.setCardNumber(rs.getString("card_number"));
                pd.setExpiryDate(rs.getString("expiry_date"));
                pd.setCardCvv(rs.getString("card_cvv"));
                payments.add(pd);
            }
        }

        return payments;
    }
}