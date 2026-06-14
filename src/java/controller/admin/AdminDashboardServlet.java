package controller.admin;

import dal.BookingDAO;
import dal.EventDAO;
import dal.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "AdminDashboardServlet", urlPatterns = {"/admin/dashboard"})
public class AdminDashboardServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        UserDAO udao = new UserDAO();
        EventDAO edao = new EventDAO();
        BookingDAO bdao = new BookingDAO();
        
        request.setAttribute("totalUsers", udao.getTotalUsers());
        request.setAttribute("totalEvents", edao.getTotalEvents());
        request.setAttribute("totalBookings", bdao.getTotalBookings());
        request.setAttribute("recentBookings", bdao.getRecentBookings(5));
        
        request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
    }
}
