package org.example.quan_ly_khoa_hoc.repository;

import org.example.quan_ly_khoa_hoc.dto.ModuleDTO;
import org.example.quan_ly_khoa_hoc.entity.Module;
import org.example.quan_ly_khoa_hoc.repository.repositoryInterface.IModuleRepository;
import org.example.quan_ly_khoa_hoc.util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ModuleRepository implements IModuleRepository {
    @Override
    public List<Module> findModulesByCourseId(int courseId) {
        List<Module> list = new ArrayList<>();
        String sql = "SELECT module_id, module_name FROM modules WHERE course_id = ?";
        try (Connection conn = DatabaseUtil.getConnectDB();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, courseId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Module(rs.getInt("module_id"), rs.getString("module_name")));
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    @Override
    public List<ModuleDTO> findModulesDTOByStudentId(int studentId,int course_id) {
        List<ModuleDTO> list = new ArrayList<>();
        // Chú ý: Cột progress_percentage trong SQL trả về kiểu DECIMAL/FLOAT, phù hợp với Float trong Java
        String sql = "SELECT\n" +
                "    m.module_id,\n" +
                "    m.module_name,\n" +
                "    COALESCE(SUM(CASE WHEN lp.is_completed = 1 THEN 1 ELSE 0 END), 0) AS completed_lessons,\n" +
                "    COUNT(l.lesson_id) AS total_lessons,\n" +
                "    (COALESCE(SUM(CASE WHEN lp.is_completed = 1 THEN 1 ELSE 0 END), 0) * 100.0 / NULLIF(COUNT(l.lesson_id), 0)) AS progress_percentage\n" +
                "FROM\n" +
                "    modules m\n" +
                "    JOIN lessons l ON m.module_id = l.module_id\n" +
                "    LEFT JOIN lesson_progress lp ON l.lesson_id = lp.lesson_id AND lp.student_id = ?\n" +
                "WHERE\n" +
                "    m.course_id = ?\n" +
                "GROUP BY\n" +
                "    m.module_id, m.module_name\n" +
                "ORDER BY\n" +
                "    m.module_id;";
        try (Connection conn = DatabaseUtil.getConnectDB();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, studentId);
            ps.setInt(2,course_id);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                ModuleDTO dto = new ModuleDTO();

                dto.setModuleId(rs.getInt("module_id"));
                dto.setModuleName(rs.getString("module_name"));
                dto.setCompleted_lessons(rs.getInt("completed_lessons"));
                dto.setTotal_lessons(rs.getInt("total_lessons"));
                dto.setProgressPercentage(rs.getFloat("progress_percentage"));

                list.add(dto);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
