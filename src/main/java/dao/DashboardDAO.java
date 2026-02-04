package dao;

import java.util.List;

import model.UserData;

public interface DashboardDAO {
    List<UserData> getUserDashboardData(String email);
}
