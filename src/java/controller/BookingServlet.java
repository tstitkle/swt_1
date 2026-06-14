package controller;

import dal.BookingDAO;
import dal.EventDAO;
import java.io.IOException;
import java.util.Date;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Booking;
import model.Event;
import model.User;

@WebServlet(name = "BookingServlet", urlPatterns = {"/booking"})
public class BookingServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int eventId = Integer.parseInt(request.getParameter("id"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            
            EventDAO edao = new EventDAO();
            Event e = edao.getEventById(eventId);
            
            if (e != null) {
                if (e.getEventDate() != null && e.getEventDate().before(new Date())) {
                    response.sendRedirect("event-detail?id=" + eventId + "&error=past");
                    return;
                }
                request.setAttribute("event", e);
                request.setAttribute("quantity", quantity);
                request.setAttribute("total", e.getPrice() * quantity);
                request.getRequestDispatcher("customer/checkout.jsp").forward(request, response);
            } else {
                response.sendRedirect("home");
            }
        } catch (Exception e) {
            response.sendRedirect("home");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            int eventId = Integer.parseInt(request.getParameter("eventId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            double total = Double.parseDouble(request.getParameter("total"));
            
            EventDAO edao = new EventDAO();
            Event e = edao.getEventById(eventId);
            
            Booking b = new Booking();
            b.setUserId(user.getUserId());
            b.setTotalAmount(total);
            
            BookingDAO bdao = new BookingDAO();
            boolean success = bdao.createBooking(b, eventId, quantity, e.getPrice());
            
            if (success) {
                response.sendRedirect("customer/success.jsp");
            } else {
                request.setAttribute("error", "Lỗi trong quá trình thanh toán!");
                request.getRequestDispatcher("customer/checkout.jsp").forward(request, response);
            }
        } catch (Exception ex) {
            response.sendRedirect("home");
        }
    }
}
