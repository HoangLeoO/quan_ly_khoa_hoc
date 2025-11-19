package org.example.quan_ly_khoa_hoc.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.quan_ly_khoa_hoc.entity.Role;
import org.example.quan_ly_khoa_hoc.entity.User;
import org.example.quan_ly_khoa_hoc.service.RoleService;
import org.example.quan_ly_khoa_hoc.service.UserService;
import org.example.quan_ly_khoa_hoc.service.serviceInterface.IRoleService;
import org.example.quan_ly_khoa_hoc.service.serviceInterface.IUserService;
import org.mindrot.jbcrypt.BCrypt;

import java.io.IOException;


@WebServlet(name = "LoginController", value = "/login")
public class LoginController extends HttpServlet {

    private IUserService userService = new UserService();
    private IRoleService roleService = new RoleService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/views/auth/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException { // <-- THÊM throws ở đây

        String email = req.getParameter("email");
        String password = req.getParameter("password");

        try {
            User user = userService.findByEmail(email);

            // 1. Kiểm tra User tồn tại, mật khẩu, và tài khoản KHÔNG bị xóa
            if (user != null && BCrypt.checkpw(password, user.getPasswordHash()) && !user.isDelete()) {

                // Lấy roleName từ DB
                Role role = roleService.getRoleNameById(user.getRoleId());

                HttpSession session = req.getSession();
                session.setAttribute("currentUser", user);
                session.setAttribute("role", role.getRoleName());
                switch (role.getRoleName()) {
                    case "Admin" -> resp.sendRedirect(req.getContextPath() + "/admins");
                    case "Teacher" -> resp.sendRedirect(req.getContextPath() + "/teacher");
                    case "Student" -> resp.sendRedirect(req.getContextPath() + "/students");
                    case "Academic Staff" -> resp.sendRedirect(req.getContextPath() + "/acedemic-affairs");
                }

            } else {
                // 2. Thêm kiểm tra cho trường hợp tài khoản bị vô hiệu hóa
                if (user != null && user.isDelete()) {
                    req.setAttribute("error", "Tài khoản của bạn đã bị vô hiệu hóa.");
                } else {
                    req.setAttribute("error", "Email hoặc mật khẩu không đúng.");
                }
                req.getRequestDispatcher("/views/auth/login.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            e.printStackTrace();
            // 3. Xử lý lỗi hệ thống thân thiện hơn
            req.setAttribute("error", "Đã xảy ra lỗi hệ thống trong quá trình đăng nhập.");
            req.getRequestDispatcher("/views/auth/login.jsp").forward(req, resp);
        }
    }
}
