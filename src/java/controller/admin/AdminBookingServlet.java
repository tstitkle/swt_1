package controller.admin;

import dal.BookingDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "AdminBookingServlet", urlPatterns = {"/admin/bookings"})
public class AdminBookingServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        BookingDAO dao = new BookingDAO();
        request.setAttribute("bookings", dao.getAllBookings());
        request.getRequestDispatcher("/admin/booking-list.jsp").forward(request, response);
    }
}
