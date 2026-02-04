package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import dao.TeamDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Team;

@WebServlet("/TeamController")
public class TeamController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private TeamDAO teamDAO;

	@Override
	public void init() throws ServletException {
		try {
			teamDAO = new TeamDAO();
		} catch (Exception e) {
			throw new ServletException("TeamDAO initialization failed", e);
		}
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			System.out.println("Executing doGet() in TeamController");
			List<Team> teamList = teamDAO.getAll();
			request.setAttribute("teamList", teamList);
			request.getRequestDispatcher("/manage-teams.jsp").forward(request, response);
		} catch (SQLException e) {
			e.printStackTrace();
			throw new ServletException("Error fetching team list", e);
		}
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getParameter("action");
		if (action == null) {
			throw new ServletException("Action parameter is missing");
		}
		try {
			switch (action) {
			case "create":
				createTeam(request);
				break;
			case "update":
				updateTeam(request);
				break;
			case "delete":
				deleteTeam(request);
				break;
			default:
				throw new IllegalArgumentException("Unknown action for team: " + action);
			}
			response.sendRedirect("TeamController");
		} catch (Exception e) {
			throw new ServletException(e);
		}
	}

	private void createTeam(HttpServletRequest request) throws SQLException {
		Team team = new Team();
		team.setTeamName(request.getParameter("team_name"));
		team.setNoOfWorkers(Integer.parseInt(request.getParameter("no_of_workers")));
		team.setBooking_id(Integer.parseInt(request.getParameter("booking_id")));
		team.setAssigned_by(Integer.parseInt(request.getParameter("assigned_by")));
		teamDAO.create(team);
	}

	private void updateTeam(HttpServletRequest request) throws SQLException {
		Team team = new Team();
		team.setTeamId(Integer.parseInt(request.getParameter("team_id")));
		team.setTeamName(request.getParameter("team_name"));
		team.setNoOfWorkers(Integer.parseInt(request.getParameter("no_of_workers")));
		team.setBooking_id(Integer.parseInt(request.getParameter("booking_id")));
		team.setAssigned_by(Integer.parseInt(request.getParameter("assigned_by")));
		teamDAO.update(team);
	}

	private void deleteTeam(HttpServletRequest request) throws SQLException {
		String id = request.getParameter("team_id");
		teamDAO.delete(id);
	}
}
