package dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import model.ComplaintReply;
import util.DatabaseConnection;

public class ComplaintReplyDAO {
	private final Connection connection;

	public ComplaintReplyDAO() throws SQLException, ClassNotFoundException {
		this.connection = DatabaseConnection.getConnection();
	}
	
	public List<ComplaintReply> getAllComplaintReplies() throws SQLException {
		List<ComplaintReply> complaintreplies = new ArrayList<>();
		String query = "SELECT * FROM complaint_reply_details";

		try (Statement stmt = connection.createStatement(); 
				ResultSet rs = stmt.executeQuery(query)) {
			while (rs.next()) {
				ComplaintReply complaintreply = new ComplaintReply();
				complaintreply.setComplaint_id(rs.getInt("complaint_id"));
				complaintreply.setReply_id(rs.getInt("reply_id"));
				complaintreply.setComplaint_user(rs.getString("complaint_user"));
				complaintreply.setReplied_user(rs.getString("replied_user"));
				complaintreply.setComplaint_status(rs.getString("complaint_status"));
				complaintreply.setComplaint_text(rs.getString("complaint_text"));
				complaintreply.setReply_text(rs.getString("reply_text"));

				complaintreplies.add(complaintreply);
			}
		}

		return complaintreplies;
	}
}
