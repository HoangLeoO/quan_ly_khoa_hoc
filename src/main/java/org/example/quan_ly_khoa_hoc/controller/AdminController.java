package org.example.quan_ly_khoa_hoc.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.quan_ly_khoa_hoc.dto.UserDTO;
import org.example.quan_ly_khoa_hoc.service.RoleService;
import org.example.quan_ly_khoa_hoc.service.UserService;
import org.example.quan_ly_khoa_hoc.service.serviceInterface.IRoleService;
import org.example.quan_ly_khoa_hoc.service.serviceInterface.IUserService;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

@WebServlet(name = "AdminController", value = "/admin/users")
public class AdminController extends HttpServlet {
    private static final IUserService userService = new UserService();

    private IRoleService roleService = new RoleService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }
        switch (action) {
            case "delete":
                deleteUser(req, resp);
                break;
            case "update":
                showUpdateForm(req, resp);
                break;
            case "search":
                search(req, resp);
                break;
            default:
                getAllRoles(req, resp);
                getAllUser(req, resp);
                req.getRequestDispatcher("/views/admin/admin.jsp").forward(req, resp);
                break;
        }
    }

    private void getAllUser(HttpServletRequest req, HttpServletResponse resp) {
        req.setAttribute("userList", userService.getAllUser());
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }
        switch (action) {
            case "update":
                updateUser(req, resp);
                break;
            case "add":
                addUser(req, resp);
                break;
            default:
                resp.sendRedirect("/admins");
                break;
        }
    }

    private void deleteUser(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        userService.deleteUser(Integer.parseInt(req.getParameter("id")));
        resp.sendRedirect("/admin/users?message=delete_success");
    }

    private void addUser(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String fullName = req.getParameter("fullName");
        String email = req.getParameter("email");
        String password = req.getParameter("confirmPassword");
        int roleId = Integer.parseInt(req.getParameter("roleId"));
        String phone = req.getParameter("phone");
        LocalDate dob = LocalDate.parse(req.getParameter("dob"));
        String position = req.getParameter("position");
        String address = req.getParameter("address");
        UserDTO userDTO = new UserDTO(fullName, email, dob, position, roleId, LocalDate.now(), password, phone, address);
        userService.createUserWithProfile(userDTO);
        resp.sendRedirect("/admin/users?message=add_success");
    }

    private void updateUser(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Integer userId = Integer.parseInt(req.getParameter("userId"));
        UserDTO userDTO = userService.getUserById(userId);

        if (userDTO != null) {
            userDTO.setFullName(req.getParameter("fullName"));
            userDTO.setEmail(req.getParameter("email"));
            userDTO.setRoleId(Integer.parseInt(req.getParameter("roleId")));
            userDTO.setPhone(req.getParameter("phone"));
            userDTO.setDob(LocalDate.parse(req.getParameter("dob")));
            userDTO.setPosition(req.getParameter("position"));
            userDTO.setAddress(req.getParameter("address"));
            userService.updateUserWithProfile(userDTO);
        }
        resp.sendRedirect("/admin/users?message=update_success");
    }

    private void showUpdateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Integer userId = Integer.parseInt(req.getParameter("id"));
            UserDTO user = userService.getUserById(userId);

            if (user == null) {
                // User not found, redirect back to the list with an error message
                resp.sendRedirect(req.getContextPath() + "/admin/users?message=user_not_found");
                return; // Stop further execution
            }

            req.setAttribute("mode", "update");
            req.setAttribute("user", user);
            getAllUser(req, resp); // To repopulate the list in the background
            getAllRoles(req, resp); // To populate the filter dropdown
            req.getRequestDispatcher("/views/admin/admin.jsp").forward(req, resp);

        } catch (NumberFormatException e) {
            // Invalid ID format
            resp.sendRedirect(req.getContextPath() + "/admin/users?message=invalid_id");
        }
    }

    private void getAllRoles(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("roleList", roleService.getAllRoles());
    }

    private void search(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String keyword = req.getParameter("keyword");
        if (keyword == null) keyword = "";
        keyword = keyword.trim();

        String roleIdParam = req.getParameter("roleId");
        Integer roleId = null;
        if (roleIdParam != null && !roleIdParam.isEmpty()) {
            roleId = Integer.valueOf(roleIdParam);
        }

        List<UserDTO> userList = userService.search(keyword, roleId);

        req.setAttribute("userList", userList);
        req.setAttribute("keyword", keyword);
        req.setAttribute("roleId", roleId); // Pass roleId back to the view

        // Also need to pass the roleList again for the filter dropdown
        getAllRoles(req, resp);

        // Forward to the main admin page, which will include the user list table
        req.getRequestDispatcher("/views/admin/admin.jsp").forward(req, resp);
    }
}