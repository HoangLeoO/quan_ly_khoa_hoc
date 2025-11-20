package org.example.quan_ly_khoa_hoc.repository;

import org.example.quan_ly_khoa_hoc.dto.LessonDTO;
import org.example.quan_ly_khoa_hoc.entity.Lesson;
import org.example.quan_ly_khoa_hoc.repository.repositoryInterface.ILessonRepository;
import org.example.quan_ly_khoa_hoc.util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class LessonRepository implements ILessonRepository {
    @Override
    public List<Lesson> findLessonsByModuleId(int moduleId) {
        List<Lesson> list = new ArrayList<>();
        String sql = "SELECT lesson_id, lesson_name FROM lessons WHERE module_id = ?";
        try (Connection conn = DatabaseUtil.getConnectDB();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, moduleId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Lesson(rs.getInt("lesson_id"), rs.getString("lesson_name")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public List<LessonDTO> getAllByModuleIdAndStudentId(int moduleId, int studentId) {
        List<LessonDTO> list = new ArrayList<>();
        String sql = "SELECT l.lesson_id, l.lesson_name,COALESCE(lp.is_completed, 0) as is_completed \n" +
                "                 FROM lessons l\n" +
                "                 LEFT JOIN lesson_progress lp ON l.lesson_id = lp.lesson_id AND lp.student_id = ?\n" +
                "                 WHERE l.module_id = ?;";
        try (Connection conn = DatabaseUtil.getConnectDB();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, studentId);
            ps.setInt(2, moduleId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int lesson_id = rs.getInt("lesson_id");
                String lesson_name = rs.getString("lesson_name");
                boolean status = rs.getBoolean("is_completed");
                list.add(new LessonDTO(lesson_id, lesson_name, status));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
