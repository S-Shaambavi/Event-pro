package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import controller.packageService;
import util.DatabaseConnection;

import java.io.IOException;
import java.sql.Connection;

import dao.EventPackageDAO;

@WebServlet("/CancelCustomPackageServlet")
public class CancelCustomPackageServlet extends HttpServlet {

    //private packageService packageService;
    private EventPackageDAO eventPackageDAO;


    @Override
    public void init() throws ServletException {
        try {
            Connection conn = util.DatabaseConnection.getConnection();
            eventPackageDAO = new EventPackageDAO(conn);
        } catch (Exception e) {
            throw new ServletException("Failed to initialize EventPackageDAO", e);
        }
    }    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String packageIdStr = request.getParameter("packageId");

            if (packageIdStr == null || packageIdStr.isEmpty()) {
                throw new IllegalArgumentException("Package ID is missing.");
            }

            int packageId = Integer.parseInt(packageIdStr);

            // Step 1: Delete package-service mappings
            eventPackageDAO.deletePackageServices(packageId);
            // Step 2: Delete the package itself
            eventPackageDAO.deletePackage(packageId);

            // Step 3: Clear session data
            HttpSession session = request.getSession();
            session.removeAttribute("attendeeCount");
            session.removeAttribute("eventType");
            session.removeAttribute("selectedVenue");
            session.removeAttribute("selectedServices");
            session.removeAttribute("totalCost");
            session.removeAttribute("packageId");

            // Step 4: Redirect to confirmation
            response.sendRedirect("user-dashboard.jsp");

        } catch (NumberFormatException e) {
            throw new ServletException("Invalid package ID format", e);
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Error cancelling custom package", e);
        }
    }

}