package dao;

import model.Venue;
import model.PackageView;
import model.Service;
import util.DatabaseConnection;

import java.sql.*;
import java.util.*;

public class PackagesDAO {

    public static List<Venue> getAvailableVenues() {
        List<Venue> venues = new ArrayList<>();
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement("SELECT * FROM event_venue WHERE venue_status = 'Available'")) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Venue v = new Venue(
                		rs.getInt("venue_id"),
                        rs.getString("venue_name"),
                        rs.getString("venue_status"),
                        rs.getInt("venue_capacity"),
                        rs.getDouble("venue_cost"),
                        rs.getString("venue_image")
                    );
               
                venues.add(v);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return venues;
    }

    public static List<Service> getAllServices() {
        List<Service> services = new ArrayList<>();
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement("SELECT * FROM event_service")) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Service s = new Service(
                    rs.getInt("service_id"),
                    rs.getString("service_name"),
                    rs.getString("service_description"),
                    rs.getDouble("service_price"),
                    rs.getString("service_image")
                );
                services.add(s);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return services;
    }
    
    public static List<PackageView> getPredefinedPackages() throws SQLException, ClassNotFoundException {
        List<PackageView> packages = new ArrayList<>();

        String query = "SELECT p.package_id, p.package_name, p.attendee_count,\r\n"
        		+ "       v.venue_name, v.venue_capacity, v.venue_cost\r\n"
        		+ "FROM event_package p\r\n"
        		+ "JOIN event_venue v ON p.venue_id = v.venue_id";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
            	int packageId = rs.getInt("package_id");


                PackageView pkg = new PackageView();
                pkg.setPackageId(packageId);
                pkg.setPackageName(rs.getString("package_name"));
                pkg.setAttendeeCount(rs.getInt("attendee_count"));
                pkg.setVenueName(rs.getString("venue_name"));
                pkg.setVenueCapacity(rs.getInt("venue_capacity"));
                pkg.setVenueCost(rs.getDouble("venue_cost"));

                // Fetch services for this package
                List<String> services = new ArrayList<>();
                PreparedStatement serviceStmt = conn.prepareStatement(
                    "SELECT s.service_name FROM event_service s " +
                    "JOIN package_services ps ON ps.service_id = s.service_id " +
                    "WHERE ps.package_id = ?");
                serviceStmt.setInt(1, packageId);
                ResultSet serviceRs = serviceStmt.executeQuery();

                while (serviceRs.next()) {
                    services.add(serviceRs.getString("service_name"));
                }

                pkg.setServices(services);
                packages.add(pkg);

                serviceRs.close();
                serviceStmt.close();
            }
        }

        return packages;
    }
 // In getPackageById method
    public static PackageView getPackageById(int packageId) {
        PackageView pkg = null;

        try (Connection conn = DatabaseConnection.getConnection()) {

            // 1. Main package and venue
            String mainQuery = "SELECT ep.package_id, ep.package_name, ep.attendee_count, ep.package_cost, " +
                               "ev.venue_name, ev.venue_capacity, ev.venue_cost " +
                               "FROM event_package ep " +
                               "JOIN event_venue ev ON ep.venue_id = ev.venue_id " +
                               "WHERE ep.package_id = ?";

            try (PreparedStatement stmt = conn.prepareStatement(mainQuery)) {
                stmt.setInt(1, packageId);
                ResultSet rs = stmt.executeQuery();

                if (rs.next()) {
                    pkg = new PackageView();
                    pkg.setPackageId(rs.getInt("package_id"));
                    pkg.setPackageName(rs.getString("package_name"));
                    pkg.setAttendeeCount(rs.getInt("attendee_count"));
                    pkg.setPackageCost(rs.getDouble("package_cost"));
                    pkg.setVenueName(rs.getString("venue_name"));
                    pkg.setVenueCapacity(rs.getInt("venue_capacity"));
                    pkg.setVenueCost(rs.getDouble("venue_cost"));

                    // 2. Get services
                    String serviceQuery = "SELECT es.service_name " +
                                          "FROM package_services ps " +
                                          "JOIN event_service es ON ps.service_id = es.service_id " +
                                          "WHERE ps.package_id = ?";
                    try (PreparedStatement serviceStmt = conn.prepareStatement(serviceQuery)) {
                        serviceStmt.setInt(1, packageId);
                        ResultSet serviceRs = serviceStmt.executeQuery();

                        List<String> services = new ArrayList<>();
                        while (serviceRs.next()) {
                            services.add(serviceRs.getString("service_name"));
                        }
                        pkg.setServices(services);
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return pkg;
    }


}