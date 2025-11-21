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
import java.time.LocalDate;
import java.util.List;

@WebServlet(name = "AdminDashboardController", value = "/admin/dashboard")
public class AdminDashboardController extends HttpServlet {
    private final IAdminDashboardService adminDashboardService = new AdminDashboardService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Get total counts
        int totalStaff = adminDashboardService.getTotalStaffCount();
        int totalCourses = adminDashboardService.getTotalCourseCount();
        int totalStudents = adminDashboardService.getTotalStudentCount();
        int totalClasses = adminDashboardService.getTotalClassCount();

        // Get monthly enrollment stats
        LocalDate now = LocalDate.now();
        int currentMonth = now.getMonthValue();
        int currentYear = now.getYear();

        int prevMonth = now.minusMonths(1).getMonthValue();
        int prevYear = now.minusMonths(1).getYear();

        int currentMonthEnrollments = adminDashboardService.getStudentEnrollmentCountByMonth(currentYear, currentMonth);
        int prevMonthEnrollments = adminDashboardService.getStudentEnrollmentCountByMonth(prevYear, prevMonth);

        // Set attributes for JSP
        req.setAttribute("totalStaff", totalStaff);
        req.setAttribute("totalCourses", totalCourses);
        req.setAttribute("totalStudents", totalStudents);
        req.setAttribute("totalClasses", totalClasses);
        req.setAttribute("currentMonthEnrollments", currentMonthEnrollments);
        req.setAttribute("prevMonthEnrollments", prevMonthEnrollments);
        req.setAttribute("currentMonth", currentMonth);
        req.setAttribute("currentYear", currentYear);
        req.setAttribute("prevMonth", prevMonth);
        req.setAttribute("prevYear", prevYear);


        req.getRequestDispatcher("/views/admin/admin-dashboard.jsp").forward(req, resp);
    }
}
