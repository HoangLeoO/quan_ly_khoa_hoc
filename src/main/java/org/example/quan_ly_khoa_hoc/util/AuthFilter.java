package org.example.quan_ly_khoa_hoc.util;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.quan_ly_khoa_hoc.entity.User;

import java.io.IOException;

import jakarta.servlet.*;

@WebFilter("/*")
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;
        String uri = req.getRequestURI();

        if (isPublicUri(uri)) {
            chain.doFilter(request, response);
            return;
        }

        HttpSession session = req.getSession(false);
        User user = session != null ? (User) session.getAttribute("currentUser") : null;
        String role = session != null ? (String) session.getAttribute("role") : null;

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        if (!hasAccess(uri, role)) {
            resp.sendRedirect(req.getContextPath() + "/no-permission");
            return;
        }

        chain.doFilter(request, response);
    }

    private boolean isPublicUri(String uri) {
        return uri.endsWith("/login") || uri.endsWith("/register") || uri.contains("/assets/");
    }

    private boolean hasAccess(String uri, String role) {
        if (role == null) return false;
        switch (role) {
            case "Admin": return true;
            case "Teacher": return uri.startsWith("/students") || uri.startsWith("/common") || true;
            case "Student": return uri.startsWith("/teacher") || uri.startsWith("/common")  || true;
            case "Academic_Staff": return uri.startsWith("/Academic-Staff") || uri.startsWith("/common")  || true;
            default: return false;
        }
    }
}