package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import model.Service;

public class serviceDAOImpl implements serviceDetailsDAO {
    private Connection conn;

    public serviceDAOImpl(Connection conn) {
        this.conn = conn;
    }

    @Override
    public List<Service> getAllServices() throws SQLException {
        List<Service> services = new ArrayList<>();
        String sql = "SELECT * FROM event_service";

        try (Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
            	Service service = new Service(
                    rs.getInt("service_id"),
                    rs.getString("service_name"),
                    rs.getString("service_description"),
                    rs.getDouble("service_price"),
                    rs.getString("service_image")
                );
                services.add(service);
            }
        }

        return services;
    }

    @Override
    public Service getServiceById(int serviceId) throws SQLException {
        String sql = "SELECT * FROM event_service WHERE service_id = ?";
        
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, serviceId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return new Service(
                    		rs.getInt("service_id"),
                            rs.getString("service_name"),
                            rs.getString("service_description"),
                            rs.getDouble("service_price"),
                            rs.getString("service_image")
                    );
                }
            }
        }

        return null;
    }
}
