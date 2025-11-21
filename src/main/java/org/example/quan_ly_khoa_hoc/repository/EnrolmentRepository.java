package org.example.quan_ly_khoa_hoc.repository;

import org.example.quan_ly_khoa_hoc.dto.MonthlyStatsDTO;
import org.example.quan_ly_khoa_hoc.repository.repositoryInterface.IEnrolmentRepository;
import org.example.quan_ly_khoa_hoc.util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class EnrolmentRepository implements IEnrolmentRepository {
    @Override
    public List<MonthlyStatsDTO> getMonthlyStudentEnrollmentCount() {
        List<MonthlyStatsDTO> monthlyStats = new ArrayList<>();
        String sql = "SELECT " +
                     "    MONTH(enrol_date) AS month, " +
                     "    YEAR(enrol_date) AS year, " +
                     "    COUNT(student_id) AS count " +
                     "FROM enrolments " +
                     "GROUP BY MONTH(enrol_date), YEAR(enrol_date) " +
                     "ORDER BY YEAR(enrol_date) DESC, MONTH(enrol_date) DESC";
        try (Connection conn = DatabaseUtil.getConnectDB();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                monthlyStats.add(new MonthlyStatsDTO(
                    rs.getInt("month"),
                    rs.getInt("year"),
                    rs.getLong("count")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return monthlyStats;
    }

    @Override
    public int getEnrollmentCountByMonth(int year, int month) {
        String sql = "SELECT COUNT(student_id) FROM enrolments WHERE YEAR(enrol_date) = ? AND MONTH(enrol_date) = ?";
        try (Connection conn = DatabaseUtil.getConnectDB();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, year);
            ps.setInt(2, month);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}
