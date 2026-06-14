package controller;

import dal.CategoryDAO;
import dal.EventDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Event;

@WebServlet(name = "HomeServlet", urlPatterns = {"/home"})
public class HomeServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        String keyword = request.getParameter("search");
        String catIdStr = request.getParameter("categoryId");
        
        EventDAO edao = new EventDAO();
        CategoryDAO cdao = new CategoryDAO();
        
        List<Event> list;
        if (keyword != null && !keyword.isEmpty()) {
            list = edao.searchEvents(keyword);
        } else if (catIdStr != null && !catIdStr.isEmpty()) {
            list = edao.getEventsByCategory(Integer.parseInt(catIdStr));
        } else {
            list = edao.getAllEvents();
        }
        
        request.setAttribute("events", list);
        request.setAttribute("categories", cdao.getAllCategories());
        request.getRequestDispatcher("home.jsp").forward(request, response);
    }
}
