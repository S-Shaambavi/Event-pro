package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import model.User;
import util.DatabaseConnection;

public class UserDAO implements GenericDAO<User> {
	private final Connection connection;

	public UserDAO() throws SQLException, ClassNotFoundException {
		this.connection = DatabaseConnection.getConnection();
	}

	@Override
	public boolean create(User user) throws SQLException {
		String query = "INSERT INTO users (user_id, user_fName, user_lName, user_dob, user_email, user_phone, user_address, user_gender, password, user_role, created_at, user_profile) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		try (PreparedStatement ps = connection.prepareStatement(query)) {
			ps.setInt(1, user.getUser_id());

			ps.setString(3, user.getUser_fName());
			ps.setString(4, user.getUser_lName());
			ps.setDate(5, user.getUser_dob());
			ps.setString(6, user.getUser_email());
			ps.setString(7, user.getUser_phone());
			ps.setString(8, user.getUser_address());
			ps.setString(9, user.getUser_gender());
			ps.setString(10, user.getPassword());
			ps.setString(11, user.getUser_role());
			ps.setString(12, user.getCreated_at());
			ps.setString(13, user.getUser_profile());
			return ps.executeUpdate() > 0;
		}
	}

	@Override
	public Optional<User> getById(String id) throws SQLException {
		String query = "SELECT * FROM users WHERE user_id = ?";
		try (PreparedStatement ps = connection.prepareStatement(query)) {
			ps.setInt(1, Integer.parseInt(id));
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					User user = mapResultSetToUser(rs);
					return Optional.of(user);
				}
				return Optional.empty();
			}
		}
	}

	@Override
	public List<User> getAll() throws SQLException {
		String query = "SELECT * FROM users";
		List<User> users = new ArrayList<>();
		try (PreparedStatement ps = connection.prepareStatement(query); ResultSet rs = ps.executeQuery()) {
			while (rs.next()) {
				User user = mapResultSetToUser(rs);
				users.add(user);
			}
		}
		return users;
	}

	@Override
	public boolean update(User user) throws SQLException {
		String query = "UPDATE users SET user_fName = ?, user_lName = ?, user_dob = ?, user_email = ?, user_phone = ?, user_address = ?, user_gender = ?, password = ?, user_role = ?, created_at = ?, user_profile = ? WHERE user_id = ?";
		try (PreparedStatement ps = connection.prepareStatement(query)) {

			ps.setString(2, user.getUser_fName());
			ps.setString(3, user.getUser_lName());
			ps.setDate(4, user.getUser_dob());
			ps.setString(5, user.getUser_email());
			ps.setString(6, user.getUser_phone());
			ps.setString(7, user.getUser_address());
			ps.setString(8, user.getUser_gender());
			ps.setString(9, user.getPassword());
			ps.setString(10, user.getUser_role());
			ps.setString(11, user.getCreated_at());
			ps.setString(12, user.getUser_profile());
			ps.setInt(13, user.getUser_id());
			return ps.executeUpdate() > 0;
		}
	}

	@Override
	public boolean delete(String id) throws SQLException {
		String query = "DELETE FROM users WHERE user_id = ?";
		try (PreparedStatement ps = connection.prepareStatement(query)) {
			ps.setInt(1, Integer.parseInt(id));
			return ps.executeUpdate() > 0;
		}
	}

	private User mapResultSetToUser(ResultSet rs) throws SQLException {
		User user = new User();
		user.setUser_id(rs.getInt("user_id"));

		user.setUser_fName(rs.getString("user_fName"));
		user.setUser_lName(rs.getString("user_lName"));
		user.setUser_dob(rs.getDate("user_dob"));
		user.setUser_email(rs.getString("user_email"));
		user.setUser_phone(rs.getString("user_phone"));
		user.setUser_address(rs.getString("user_address"));
		user.setUser_gender(rs.getString("user_gender"));
		user.setPassword(rs.getString("password"));
		user.setUser_role(rs.getString("user_role"));
		user.setCreated_at(rs.getString("created_at"));
		user.setUser_profile(rs.getString("user_profile"));
		return user;
	}
}
