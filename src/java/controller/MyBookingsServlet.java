package controller;

import dal.BookingDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

@WebServlet(name = "MyBookingsServlet", urlPatterns = {"/my-bookings"})
public class MyBookingsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        BookingDAO dao = new BookingDAO();
        String bookingIdRaw = request.getParameter("id");

        if (bookingIdRaw != null && !bookingIdRaw.isEmpty()) {
            try {
                int bookingId = Integer.parseInt(bookingIdRaw);
                request.setAttribute("booking", dao.getBookingByIdAndUserId(bookingId, user.getUserId()));
                request.setAttribute("items", dao.getBookingDetailItems(bookingId, user.getUserId()));
                request.getRequestDispatcher("customer/booking-detail.jsp").forward(request, response);
                return;
            } catch (NumberFormatException ex) {
                response.sendRedirect("my-bookings");
                return;
            }
        }

        request.setAttribute("bookings", dao.getBookingsByUserId(user.getUserId()));
        request.getRequestDispatcher("customer/my-bookings.jsp").forward(request, response);
    }
}
