package controller.admin;

import dal.CategoryDAO;
import dal.EventDAO;
import dal.VenueDAO;
import java.io.IOException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Event;

@WebServlet(name = "AdminEventServlet", urlPatterns = {"/admin/events"})
public class AdminEventServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        EventDAO edao = new EventDAO();
        CategoryDAO cdao = new CategoryDAO();
        VenueDAO vdao = new VenueDAO();

        if (action == null) {
            request.setAttribute("events", edao.getAllEvents());
            request.getRequestDispatcher("/admin/event-list.jsp").forward(request, response);
        } else if (action.equals("add")) {
            request.setAttribute("categories", cdao.getAllCategories());
            request.setAttribute("venues", vdao.getAllVenues());
            request.getRequestDispatcher("/admin/event-form.jsp").forward(request, response);
        } else if (action.equals("edit")) {
            int id = Integer.parseInt(request.getParameter("id"));
            request.setAttribute("event", edao.getEventById(id));
            request.setAttribute("categories", cdao.getAllCategories());
            request.setAttribute("venues", vdao.getAllVenues());
            request.getRequestDispatcher("/admin/event-form.jsp").forward(request, response);
        } else if (action.equals("delete")) {
            int id = Integer.parseInt(request.getParameter("id"));
            edao.deleteEvent(id);
            response.sendRedirect("events");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        EventDAO edao = new EventDAO();

        try {
            String title = request.getParameter("title");
            String desc = request.getParameter("description");
            String dateStr = request.getParameter("eventDate"); // yyyy-MM-dd'T'HH:mm
            double price = Double.parseDouble(request.getParameter("price"));
            int catId = Integer.parseInt(request.getParameter("categoryId"));
            int venueId = Integer.parseInt(request.getParameter("venueId"));

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
            java.util.Date parsedDate = sdf.parse(dateStr);
            Timestamp timestamp = new Timestamp(parsedDate.getTime());

            Event e = new Event();
            e.setTitle(title);
            e.setDescription(desc);
            e.setEventDate(timestamp);
            e.setPrice(price);
            e.setCategoryId(catId);
            e.setVenueId(venueId);

            if (action.equals("add")) {
                edao.addEvent(e);
            } else if (action.equals("edit")) {
                int id = Integer.parseInt(request.getParameter("id"));
                e.setEventId(id);
                edao.updateEvent(e);
            }
            response.sendRedirect("events");
        } catch (Exception ex) {
            response.sendRedirect("events");
        }
    }
}
