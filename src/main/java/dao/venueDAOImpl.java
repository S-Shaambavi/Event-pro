package dao;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import model.Venue;

public class venueDAOImpl implements venueDetailsDAO {
    private Connection conn;

    public venueDAOImpl(Connection conn) {
        this.conn = conn;
    }

    @Override
    public List<Venue> getAllAvailableVenues() throws SQLException {
        List<Venue> venues = new ArrayList<>();
        String sql = "SELECT * FROM event_venue WHERE venue_status = 'Available'";

        try (Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
            	Venue venue = new Venue(
                    rs.getInt("venue_id"),
                    rs.getString("venue_name"),
                    rs.getString("venue_status"),
                    rs.getInt("venue_capacity"),
                    rs.getDouble("venue_cost"),
                    rs.getString("venue_image")
                );
                venues.add(venue);
            }
        }

        return venues;
    }

    @Override
    public Venue getVenueById(String venueId) throws SQLException {
        String sql = "SELECT * FROM event_venue WHERE venue_id = ?";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, venueId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return new Venue(
                        rs.getInt("venue_id"),
                        rs.getString("venue_name"),
                        rs.getString("venue_status"),
                        rs.getInt("venue_capacity"),
                        rs.getDouble("venue_cost"),
                        rs.getString("venue_image")
                    );
                }
            }
        }

        return null;
    }
}
