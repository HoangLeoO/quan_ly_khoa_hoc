package org.example.quan_ly_khoa_hoc.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.quan_ly_khoa_hoc.dto.MonthlyStatsDTO;
import org.example.quan_ly_khoa_hoc.service.AdminDashboardService;
import org.example.quan_ly_khoa_hoc.service.serviceInterface.IAdminDashboardService;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminDashboardController", value = "/admin/dashboard")
public class AdminDashboardController extends HttpServlet {
    private final IAdminDashboardService adminDashboardService = new AdminDashboardService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int totalStaff = adminDashboardService.getTotalStaffCount();
        int totalCourses = adminDashboardService.getTotalCourseCount();
        List<MonthlyStatsDTO> monthlyEnrollments = adminDashboardService.getMonthlyStudentEnrollmentStats();

        req.setAttribute("totalStaff", totalStaff);
        req.setAttribute("totalCourses", totalCourses);
        req.setAttribute("monthlyEnrollments", monthlyEnrollments);

        req.getRequestDispatcher("/views/admin/admin-dashboard.jsp").forward(req, resp);
    }
}
