package controller;

import dal.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "RegisterServlet", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        
        String user = request.getParameter("username");
        String pass = request.getParameter("password");
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        
        UserDAO dao = new UserDAO();
        if (dao.checkExists(user)) {
            request.setAttribute("error", "Tên đăng nhập đã tồn tại!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        } else {
            boolean success = dao.register(user, pass, fullName, email);
            if (success) {
                response.sendRedirect("login.jsp");
            } else {
                request.setAttribute("error", "Có lỗi xảy ra, vui lòng thử lại!");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            }
        }
    }
}
