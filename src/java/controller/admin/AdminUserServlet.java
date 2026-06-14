package controller.admin;

import dal.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;

@WebServlet(name = "AdminUserServlet", urlPatterns = {"/admin/users"})
public class AdminUserServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        UserDAO dao = new UserDAO();
        String action = request.getParameter("action");

        if ("toggle".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            boolean active = "1".equals(request.getParameter("active"));
            dao.setUserActive(id, active);
            response.sendRedirect("users");
            return;
        }

        if ("edit".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            request.setAttribute("editingUser", dao.getUserById(id));
        }

        request.setAttribute("users", dao.getAllUsers());
        request.getRequestDispatcher("/admin/user-list.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        UserDAO dao = new UserDAO();
        String action = request.getParameter("action");

        if ("edit".equals(action)) {
            User u = new User();
            u.setUserId(Integer.parseInt(request.getParameter("id")));
            u.setFullName(request.getParameter("fullName"));
            u.setEmail(request.getParameter("email"));
            u.setRoleId(Integer.parseInt(request.getParameter("roleId")));
            dao.updateUserByAdmin(u);
        } else {
            User u = new User();
            u.setUsername(request.getParameter("username"));
            u.setPassword(request.getParameter("password"));
            u.setFullName(request.getParameter("fullName"));
            u.setEmail(request.getParameter("email"));
            u.setRoleId(Integer.parseInt(request.getParameter("roleId")));
            dao.addUser(u);
        }

        response.sendRedirect("users");
    }
}
