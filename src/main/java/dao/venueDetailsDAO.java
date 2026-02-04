package dao;

import java.sql.SQLException;
import java.util.List;

import model.Venue;

public interface venueDetailsDAO {
    List<Venue> getAllAvailableVenues() throws SQLException;
    Venue getVenueById(String venueId) throws SQLException;
}