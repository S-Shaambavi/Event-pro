package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import model.Team;
import util.DatabaseConnection; // Ensure this exists and returns a Connection

public class TeamDAO implements GenericDAO<Team> {
	private final Connection connection;

	public TeamDAO() throws SQLException, ClassNotFoundException {
		this.connection = DatabaseConnection.getConnection();
	}
	
	@Override
	public boolean create(Team team) throws SQLException {
		String query = "INSERT INTO teams (team_id, team_name, no_of_workers, booking_id, assigned_by) VALUES (?, ?, ?, ?, ?)";
		try (PreparedStatement stmt = connection.prepareStatement(query)) {

			stmt.setInt(1, team.getTeamId());
			stmt.setString(2, team.getTeamName());
			stmt.setInt(3, team.getNoOfWorkers());
			stmt.setInt(4, team.getBooking_id());
			stmt.setInt(5, team.getAssigned_by());

			return stmt.executeUpdate() > 0;
		}
	}

	@Override
	public Optional<Team> getById(String id) throws SQLException {
		String query = "SELECT * FROM teams WHERE team_id = ?";
		try (PreparedStatement stmt = connection.prepareStatement(query)) {

			stmt.setInt(1, Integer.parseInt(id));
			ResultSet rs = stmt.executeQuery();

			if (rs.next()) {
				Team team = extractTeamFromResultSet(rs);
				return Optional.of(team);
			}
		}
		return Optional.empty();
	}

	@Override
	public List<Team> getAll() throws SQLException {
		String query = "SELECT * FROM teams";
		List<Team> teams = new ArrayList<>();

		try (Statement stmt = connection.createStatement()) {
			ResultSet rs = stmt.executeQuery(query);

			while (rs.next()) {
				teams.add(extractTeamFromResultSet(rs));
			}
		}
		return teams;
	}

	@Override
	public boolean update(Team team) throws SQLException {
		String query = "UPDATE teams SET team_name = ?, no_of_workers = ?, booking_id = ?, assigned_by = ? WHERE team_id = ?";
		try (PreparedStatement stmt = connection.prepareStatement(query)) {

			stmt.setString(1, team.getTeamName());
			stmt.setInt(2, team.getNoOfWorkers());
			stmt.setInt(3, team.getBooking_id());
			stmt.setInt(4, team.getAssigned_by());
			stmt.setInt(5, team.getTeamId());

			return stmt.executeUpdate() > 0;
		}
	}

	@Override
	public boolean delete(String id) throws SQLException {
		String query = "DELETE FROM teams WHERE team_id = ?";
		try (PreparedStatement stmt = connection.prepareStatement(query)) {

			stmt.setInt(1, Integer.parseInt(id));
			return stmt.executeUpdate() > 0;
		}
	}

	private Team extractTeamFromResultSet(ResultSet rs) throws SQLException {
		Team team = new Team();
		team.setTeamId(rs.getInt("team_id"));
		team.setTeamName(rs.getString("team_name"));
		team.setNoOfWorkers(rs.getInt("no_of_workers"));
		team.setBooking_id(rs.getInt("booking_id"));
		team.setAssigned_by(rs.getInt("assigned_by"));
		return team;
	}
}
