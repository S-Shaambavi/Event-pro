package dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import model.Complaint;
import util.DatabaseConnection;

public class ComplaintDAO {
	private final Connection connection;

	public ComplaintDAO() throws SQLException, ClassNotFoundException {
		this.connection = DatabaseConnection.getConnection();
	}

	public List<Complaint> getAllComplaints() throws SQLException {
		List<Complaint> complaints = new ArrayList<>();
		String query = "SELECT * FROM complaints";

		try (Statement stmt = connection.createStatement(); 
				ResultSet rs = stmt.executeQuery(query)) {
			while (rs.next()) {
				Complaint complaint = new Complaint();
				complaint.setComplaint_id(rs.getInt("complaint_id"));
				complaint.setUser_id(rs.getInt("user_id"));
				complaint.setComplaint_text(rs.getString("complaint_text"));
				complaint.setComplaint_status(rs.getString("status"));
				complaint.setComplaint_at(rs.getTimestamp("created_at"));

				complaints.add(complaint);
			}
		}

		return complaints;
	}
}
