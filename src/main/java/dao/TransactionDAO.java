package dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import model.TransactionModel;
import util.DatabaseConnection;

public class TransactionDAO {
    private final Connection connection;

    public TransactionDAO() throws SQLException, ClassNotFoundException {
        this.connection = DatabaseConnection.getConnection();
    }

    public List<TransactionModel> getTransactionsByUserId(int userId) throws SQLException {
        List<TransactionModel> transactions = new ArrayList<>();
        String query = "SELECT * FROM transaction_details WHERE booking_id IN (SELECT booking_id FROM booking WHERE customer_id = " + userId + ")";
        
        try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                TransactionModel transaction = new TransactionModel(); 
                transaction.setBookingId(rs.getInt("booking_id"));            
                transaction.setPackageName(rs.getString("package_name"));    
                transaction.setBookingDate(rs.getDate("booking_date"));
                transaction.setPackageCost(rs.getDouble("package_cost"));
                transaction.setPaymentStatus(rs.getString("payment_status"));
                transactions.add(transaction);
            }
        }
        return transactions;
    }
}
