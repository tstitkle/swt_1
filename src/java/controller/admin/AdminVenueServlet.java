package controller.admin;

import dal.VenueDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Venue;

@WebServlet(name = "AdminVenueServlet", urlPatterns = {"/admin/venues"})
public class AdminVenueServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        VenueDAO dao = new VenueDAO();
        String action = request.getParameter("action");

        if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            dao.deleteVenue(id);
            response.sendRedirect("venues");
            return;
        }

        if ("edit".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            request.setAttribute("editingVenue", dao.getVenueById(id));
        }

        request.setAttribute("venues", dao.getAllVenues());
        request.getRequestDispatcher("/admin/venue-list.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        VenueDAO dao = new VenueDAO();
        String action = request.getParameter("action");

        Venue v = new Venue();
        v.setVenueName(request.getParameter("venueName"));
        v.setAddress(request.getParameter("address"));
        v.setCapacity(Integer.parseInt(request.getParameter("capacity")));

        if ("edit".equals(action)) {
            v.setVenueId(Integer.parseInt(request.getParameter("id")));
            dao.updateVenue(v);
        } else {
            dao.addVenue(v);
        }
        response.sendRedirect("venues");
    }
}
