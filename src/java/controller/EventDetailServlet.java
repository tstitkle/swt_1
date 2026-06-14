package controller;

import dal.EventDAO;
import dal.VenueDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Event;

@WebServlet(name = "EventDetailServlet", urlPatterns = {"/event-detail"})
public class EventDetailServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            EventDAO dao = new EventDAO();
            Event e = dao.getEventById(id);
            if (e != null) {
                VenueDAO vdao = new VenueDAO();
                if ("past".equals(request.getParameter("error"))) {
                    request.setAttribute("error", "Sự kiện đã diễn ra rồi, hãy đặt sự kiện khác.");
                }
                request.setAttribute("event", e);
                request.setAttribute("venue", vdao.getVenueById(e.getVenueId()));
                request.getRequestDispatcher("event-detail.jsp").forward(request, response);
            } else {
                response.sendRedirect("home");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("home");
        }
    }
}
