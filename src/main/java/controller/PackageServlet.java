package controller;

import java.io.IOException;
import java.util.List;

import dao.PackagesDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.PackageView;

@WebServlet("/PackageServlet")
public class PackageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user_email") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            // Use DAO to fetch package list
            List<PackageView> packageList = PackagesDAO.getPredefinedPackages();

            // Attach list to request and forward to JSP
            request.setAttribute("packages", packageList);
            request.getRequestDispatcher("package.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            // You can forward to an error page
            request.setAttribute("errorMessage", "Unable to load packages at the moment.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}