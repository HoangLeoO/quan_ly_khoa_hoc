package org.example.quan_ly_khoa_hoc.repository;

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
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }
}
