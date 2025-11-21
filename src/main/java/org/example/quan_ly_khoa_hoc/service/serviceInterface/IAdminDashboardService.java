package org.example.quan_ly_khoa_hoc.service.serviceInterface;

import org.example.quan_ly_khoa_hoc.dto.MonthlyStatsDTO;

import java.util.List;

public interface IAdminDashboardService {
    int getTotalStaffCount();
    int getTotalCourseCount();
    List<MonthlyStatsDTO> getMonthlyStudentEnrollmentStats();
}
