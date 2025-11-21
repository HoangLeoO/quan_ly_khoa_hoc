package org.example.quan_ly_khoa_hoc.repository.repositoryInterface;

import org.example.quan_ly_khoa_hoc.dto.MonthlyStatsDTO;
import org.example.quan_ly_khoa_hoc.entity.Enrolment;

import java.util.List;

public interface IEnrolmentRepository {
    List<MonthlyStatsDTO> getMonthlyStudentEnrollmentCount();
    int getEnrollmentCountByMonth(int year, int month); // Add this
    boolean add(Enrolment enrolment);
    boolean delete(int classId, int studentId);
}
