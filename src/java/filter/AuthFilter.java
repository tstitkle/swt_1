package filter;

import java.io.IOException;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

@WebFilter(filterName = "AuthFilter", urlPatterns = {"/*"})
public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);
        String uri = req.getRequestURI();

        // Allow static resources and public pages
        if (uri.endsWith(".css") || uri.endsWith(".js") || uri.endsWith(".png") || uri.endsWith(".jpg") || uri.endsWith(".svg")) {
            chain.doFilter(request, response);
            return;
        }

        // Public URLs
        boolean isPublicUrl = uri.endsWith("login.jsp") || uri.endsWith("register.jsp") || uri.endsWith("home") 
                            || uri.endsWith("login") || uri.endsWith("register") || uri.endsWith("index.html") || uri.equals(req.getContextPath() + "/");

        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (isPublicUrl) {
            // If already logged in, redirect home instead of showing login/register
            if (user != null && (uri.endsWith("login.jsp") || uri.endsWith("register.jsp"))) {
                res.sendRedirect(req.getContextPath() + "/home");
            } else {
                chain.doFilter(request, response);
            }
        } else {
            // Protected URLs
            if (user == null) {
                res.sendRedirect(req.getContextPath() + "/login.jsp");
            } else {
                // Check Admin access
                if (uri.contains("/admin/") && user.getRoleId() != 1) {
                    res.sendRedirect(req.getContextPath() + "/home");
                } else {
                    chain.doFilter(request, response);
                }
            }
        }
    }

    @Override
    public void destroy() {}
}
