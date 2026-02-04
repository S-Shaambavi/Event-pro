package controller  ;

import model.EventPackage;
import model.Service;
import model.Venue;
import util.DatabaseConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/customPackageServlet")
public class customPackageServlet extends HttpServlet {

    private packageService packageService;

    @Override
    public void init() throws ServletException {
        try {
            Connection conn = util.DatabaseConnection.getConnection();
            packageService = new packageService(conn);
        } catch (Exception e) {
            throw new ServletException("Failed to initialize PackageService", e);
        }
    }

    // 👉 Handle GET requests (to load booking form with venues/services)
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<Venue> venues = packageService.getAvailableVenues();
            List<Service> services = packageService.getAllServices();

            request.setAttribute("venues", venues);
            request.setAttribute("services", services);

            request.getRequestDispatcher("confirmCustomPackage.jsp").forward(request, response);

        } catch (SQLException e) {
            throw new ServletException("Error loading booking form data", e);
        }
    }

    // 👉 Handle POST requests (when user submits booking form)

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int attendeeCount = Integer.parseInt(request.getParameter("attendee_count"));
            String eventType = request.getParameter("event_type");
            int venueId = Integer.parseInt(request.getParameter("venue_id"));
            String[] serviceIdParams = request.getParameterValues("service_id");

            // Get customer ID from session (you must have stored it at login)
            int customerId = (int) request.getSession().getAttribute("user_id");

            Venue selectedVenue = packageService.getVenueById(String.valueOf(venueId));
            if (selectedVenue == null) {
                throw new ServletException("Invalid venue selected.");
            }

            List<Service> selectedServices = new java.util.ArrayList<>();
            List<Integer> serviceIds = new java.util.ArrayList<>();
            double totalCost = selectedVenue.getVenue_cost();

            if (serviceIdParams != null) {
                for (String serviceIdStr : serviceIdParams) {
                    int serviceId = Integer.parseInt(serviceIdStr);
                    Service service = packageService.getServiceById(serviceId);
                    if (service != null) {
                        selectedServices.add(service);
                        serviceIds.add(serviceId);
                        totalCost += service.getService_id();
                    }
                }
            }

            // Create EventPackage object
            EventPackage customPackage = new EventPackage();
            customPackage.setName("Custom Package - " + eventType); // unique name
            customPackage.setAttendeeCount(attendeeCount);
            customPackage.setVenueId(venueId);
            customPackage.setCreatedBy(customerId);
            customPackage.setTotalCost(totalCost);

            // Save package to DB
            int packageId = packageService.createCustomPackage(customPackage, serviceIds);
            request.getSession().setAttribute("packageId", packageId);
         // Set session attributes
            
            request.getSession().setAttribute("attendeeCount", attendeeCount);
            request.getSession().setAttribute("eventType", eventType);
            request.getSession().setAttribute("selectedVenue", selectedVenue);
            request.getSession().setAttribute("selectedServices", selectedServices);
            request.getSession().setAttribute("totalCost", totalCost);
            request.getSession().setAttribute("userId", customerId); // Optional: In case it's not set elsewhere
            // Set attributes for confirmation page
            request.setAttribute("packageId", packageId);
            request.setAttribute("attendeeCount", attendeeCount);
            request.setAttribute("eventType", eventType);
            request.setAttribute("selectedVenue", selectedVenue);
            request.setAttribute("selectedServices", selectedServices);
            request.setAttribute("totalCost", totalCost);

            request.getRequestDispatcher("confirmCustomPackage.jsp").forward(request, response);

        } catch (NumberFormatException | SQLException | NullPointerException e) {
            throw new ServletException("Error processing custom package booking", e);
        }
    }
    
    
    
    
}