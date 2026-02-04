package dao;

import java.sql.SQLException;
import java.util.List;

import model.Service;

public interface serviceDetailsDAO {
    List<Service> getAllServices() throws SQLException;
    Service getServiceById(int serviceId) throws SQLException;
}