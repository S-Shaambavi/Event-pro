package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import model.Reply;
import util.DatabaseConnection;

public class ReplyDAO implements GenericDAO<Reply> {
    private final Connection connection;

    public ReplyDAO() throws SQLException, ClassNotFoundException {
        this.connection = DatabaseConnection.getConnection();
    }

    @Override
    public boolean create(Reply reply) throws SQLException {
        String query = "INSERT INTO complaint_replies (complaint_id, replier_id, reply_text, replied_at) VALUES (?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, reply.getComplaint_id());
            ps.setInt(2, reply.getReplier_id());
            ps.setString(3, reply.getReply_text());
            ps.setTimestamp(4, reply.getReplied_at());
            return ps.executeUpdate() > 0;
        }
    }

    @Override
    public Optional<Reply> getById(String id) throws SQLException {
        String query = "SELECT * FROM complaint_replies WHERE reply_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, Integer.parseInt(id));
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return Optional.of(mapResultSetToReply(rs));
            }
        }
        return Optional.empty();
    }

    @Override
    public List<Reply> getAll() throws SQLException {
        List<Reply> replies = new ArrayList<>();
        String query = "SELECT * FROM complaint_replies";
        try (Statement stmt = connection.createStatement()) {
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()) {
                replies.add(mapResultSetToReply(rs));
            }
        }
        return replies;
    }

    @Override
    public boolean update(Reply reply) throws SQLException {
        String query = "UPDATE complaint_replies SET complaint_id = ?, replier_id = ?, reply_text = ?, replied_at = ? WHERE reply_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, reply.getComplaint_id());
            ps.setInt(2, reply.getReplier_id());
            ps.setString(3, reply.getReply_text());
            ps.setTimestamp(4, reply.getReplied_at());
            ps.setInt(5, reply.getReply_id());
            return ps.executeUpdate() > 0;
        }
    }

    @Override
    public boolean delete(String id) throws SQLException {
        String query = "DELETE FROM complaint_replies WHERE reply_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, Integer.parseInt(id));
            return ps.executeUpdate() > 0;
        }
    }

    private Reply mapResultSetToReply(ResultSet rs) throws SQLException {
        Reply reply = new Reply();
        reply.setReply_id(rs.getInt("reply_id"));
        reply.setComplaint_id(rs.getInt("complaint_id"));
        reply.setReplier_id(rs.getInt("replier_id"));
        reply.setReply_text(rs.getString("reply_text"));
        reply.setReplied_at(rs.getTimestamp("replied_at"));
        return reply;
    }
    
    public String getComplaintTextById(int complaintId) throws SQLException {
        String query = "SELECT complaint_text FROM complaints WHERE complaint_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, complaintId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("complaint_text");
            }
        }
        return null;
    }

}
