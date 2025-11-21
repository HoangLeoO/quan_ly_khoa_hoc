package org.example.quan_ly_khoa_hoc.service;

import org.example.quan_ly_khoa_hoc.dto.MonthlyStatsDTO;
import org.example.quan_ly_khoa_hoc.repository.ClassRepository;
import org.example.quan_ly_khoa_hoc.repository.CourseRepository;
import org.example.quan_ly_khoa_hoc.repository.EnrolmentRepository;
import org.example.quan_ly_khoa_hoc.repository.StaffRepository;
import org.example.quan_ly_khoa_hoc.repository.StudentRepository;
import org.example.quan_ly_khoa_hoc.repository.repositoryInterface.IClassRepository;
import org.example.quan_ly_khoa_hoc.repository.repositoryInterface.ICourseRepository;
import org.example.quan_ly_khoa_hoc.repository.repositoryInterface.IEnrolmentRepository;
import org.example.quan_ly_khoa_hoc.repository.repositoryInterface.IStaffRepository;
import org.example.quan_ly_khoa_hoc.repository.repositoryInterface.IStudentRepository;
import org.example.quan_ly_khoa_hoc.service.serviceInterface.IAdminDashboardService;

import java.util.List;

public class AdminDashboardService implements IAdminDashboardService {
    private final IStaffRepository staffRepository = new StaffRepository();
    private final ICourseRepository courseRepository = new CourseRepository();
    private final IEnrolmentRepository enrolmentRepository = new EnrolmentRepository();
    private final IStudentRepository studentRepository = new StudentRepository();
    private final IClassRepository classRepository = new ClassRepository();

    @Override
    public int getTotalStaffCount() {
        return staffRepository.getTotalStaffCount();
    }

    @Override
    public int getTotalCourseCount() {
        return courseRepository.getTotalCourseCount();
    }

    @Override
    public int getTotalStudentCount() {
        return studentRepository.getTotalStudentCount();
    }

    @Override
    public int getTotalClassCount() {
        return classRepository.getTotalClassCount();
    }

    @Override
    public int getStudentEnrollmentCountByMonth(int year, int month) {
        return enrolmentRepository.getEnrollmentCountByMonth(year, month);
    }
}
