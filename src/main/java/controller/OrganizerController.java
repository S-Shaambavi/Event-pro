package controller;

import java.io.IOException;
import java.util.List;

import dao.OrganizerDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Booking;
import model.Complaint;
import model.Team;

@WebServlet("/OrganizerController")
public class OrganizerController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private OrganizerDAO organizerDAO;

    @Override
    public void init() throws ServletException {
        try {
            organizerDAO = new OrganizerDAO();
        } catch (Exception e) {
            throw new ServletException("DAO Initialization failed", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<Complaint> complaints = organizerDAO.getAllComplaints();
            List<Booking> bookings = organizerDAO.getAllBookings();
            List<Team> teams = organizerDAO.getAllTeams();

            request.setAttribute("complaints", complaints);
            request.setAttribute("bookings", bookings);
            request.setAttribute("teams", teams);

            RequestDispatcher dispatcher = request.getRequestDispatcher("organizer.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
    	    e.printStackTrace();
    	    request.setAttribute("errorMessage", e.getMessage());
    	    request.getRequestDispatcher("/error.jsp").forward(request, response);
    	}
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if (action == null) {
                response.sendRedirect("OrganizerController");
                return;
            }

            switch (action) {
                case "replyComplaints":
                    handleReplyComplaint(request, response);
                    break;
                case "assignTeams":
                    handleAssignTeams(request, response);
                    break;
                default:
                    response.sendRedirect("OrganizerController");
                    break;
            }
        } catch (Exception e) {
        	    e.printStackTrace();
        	    request.setAttribute("errorMessage", e.getMessage());
        	    request.getRequestDispatcher("/error.jsp").forward(request, response);
        	}
    }

    private void handleReplyComplaint(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("Replying to complaint...");
        response.sendRedirect("OrganizerController");
    }

    private void handleAssignTeams(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("Assigning team...");
        response.sendRedirect("OrganizerController");
    }

}
