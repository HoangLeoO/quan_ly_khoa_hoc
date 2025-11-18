package org.example.quan_ly_khoa_hoc.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.quan_ly_khoa_hoc.dto.UserDTO;
import org.example.quan_ly_khoa_hoc.service.UserService;
import org.example.quan_ly_khoa_hoc.service.serviceInterface.IUserService;

import java.io.IOException;
import java.time.LocalDate;

@WebServlet(name = "AdminController", value = "/admins")
public class AdminController extends HttpServlet {
    private static IUserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (req.getParameter("action") == null) {
            getAllUser(req, resp);
        }
        req.getRequestDispatcher("/views/admin/admin.jsp").forward(req, resp);
    }

    private void getAllUser(HttpServletRequest req, HttpServletResponse resp) {
        req.setAttribute("userList", userService.getAllUser());
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (req.getParameter("action").equals("add")) {
            addUser(req, resp);
        }
        resp.sendRedirect("/admins");
    }

    private void addUser(HttpServletRequest req, HttpServletResponse resp) {
        String fullName = req.getParameter("fullName");
        String email = req.getParameter("email");
        String password = req.getParameter("confirmPassword");
        int roleId = Integer.parseInt(req.getParameter("roleId"));
        String phone = req.getParameter("phone");
        LocalDate dob = LocalDate.parse(req.getParameter("dob"));
        String position = req.getParameter("position");
        String address = req.getParameter("address");
        UserDTO userDTO = new UserDTO(fullName, email, dob,position,roleId, LocalDate.now(), password, phone, address);
        userService.createUserWithProfile(userDTO);
    }
}
