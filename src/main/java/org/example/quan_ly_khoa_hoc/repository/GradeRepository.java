package org.example.quan_ly_khoa_hoc.repository;

import org.example.quan_ly_khoa_hoc.dto.GradeDetailDTO;
import org.example.quan_ly_khoa_hoc.repository.repositoryInterface.IGradeRepository;
import org.example.quan_ly_khoa_hoc.util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class GradeRepository implements IGradeRepository {
    private static final String SELECT_GRADES_SQL =
            "SELECT " +
                    "s.full_name, c.course_id, c.course_name, m.module_id, m.module_name, " +
                    "g.theory_score, g.practice_score, (g.theory_score + g.practice_score) / 2 AS diem_trung_binh " +
                    "FROM grades g " +
                    "JOIN students s ON g.student_id = s.student_id " +
                    "JOIN modules m ON g.module_id = m.module_id " +
                    "JOIN courses c ON m.course_id = c.course_id " +
                    "WHERE s.student_id = ? AND c.course_id = ? " +
                    "ORDER BY m.sort_order";

    public List<GradeDetailDTO> findStudentGradesByCourseAndStudentId(int studentId, int courseId) {
        List<GradeDetailDTO> grades = new ArrayList<>();

        try (Connection connection = DatabaseUtil.getConnectDB();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_GRADES_SQL)) {

            preparedStatement.setInt(1, studentId);
            preparedStatement.setInt(2, courseId);

            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                String fullName = rs.getString("full_name");
                int fetchedCourseId = rs.getInt("course_id");
                String courseName = rs.getString("course_name");
                int moduleId = rs.getInt("module_id");
                String moduleName = rs.getString("module_name");
                double theoryScore = rs.getDouble("theory_score");
                double practiceScore = rs.getDouble("practice_score");
                double averageScore = rs.getDouble("diem_trung_binh");

                grades.add(new GradeDetailDTO(
                        fullName,
                        fetchedCourseId,
                        courseName,
                        moduleId,
                        moduleName,
                        theoryScore,
                        practiceScore,
                        averageScore
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Xử lý hoặc ném ngoại lệ (Exception) phù hợp
        }
        return grades;
    }
}
