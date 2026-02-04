package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.UserData;

public class UserDashboardDAO implements DashboardDAO {
    private Connection conn;

    public UserDashboardDAO(Connection conn) {
        this.conn = conn;
    }

    @Override
    public List<UserData> getUserDashboardData(String email) {
        List<UserData> dataList = new ArrayList<>();

        String query = "SELECT * FROM user_details WHERE user_email = ?";

        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                UserData data = new UserData();

                data.setBookingId(rs.getInt("booking_id"));
                data.setEmail(rs.getString("user_email"));
                data.setBookingDate(rs.getString("booking_date"));
                data.setEventDate(rs.getString("event_date"));
                data.setPackageName(rs.getString("package_name"));
                data.setAttendeeCount(rs.getInt("attendee_count"));
                data.setVenueName(rs.getString("venue_name"));

                // Services may be null if no service is assigned
                data.setServiceName(rs.getString("services") != null ? rs.getString("services") : "No services");

                // Payment fields (may be null if not paid yet)
                data.setPaymentDate(rs.getString("payment_date"));
                data.setPaymentStatus(rs.getString("payment_status"));
                data.setPaymentAmount(rs.getDouble("payment_amount"));

                // Complaint reply details (may be null)
                data.setReplyText(rs.getString("reply_text"));
                data.setRepliedAt(rs.getString("replied_at"));

                dataList.add(data);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return dataList;
    }
}
