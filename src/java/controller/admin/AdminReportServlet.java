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

@WebServlet(name = "AdminReportServlet", urlPatterns = {"/admin/reports"})
public class AdminReportServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        UserDAO udao = new UserDAO();
        EventDAO edao = new EventDAO();
        BookingDAO bdao = new BookingDAO();

        request.setAttribute("totalUsers", udao.getTotalUsers());
        request.setAttribute("totalEvents", edao.getTotalEvents());
        request.setAttribute("totalBookings", bdao.getTotalBookings());
        request.setAttribute("recentBookings", bdao.getRecentBookings(10));

        request.getRequestDispatcher("/admin/report.jsp").forward(request, response);
    }
}
