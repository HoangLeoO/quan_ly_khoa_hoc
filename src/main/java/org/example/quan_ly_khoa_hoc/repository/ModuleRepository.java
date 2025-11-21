package org.example.quan_ly_khoa_hoc.repository;

import org.example.quan_ly_khoa_hoc.dto.ModuleDTO;
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
    public List<ModuleDTO> findModulesByCourseId(int courseId) {
        List<ModuleDTO> list = new ArrayList<>();
        String sql = "SELECT m.module_id, m.module_name, m.course_id, m.sort_order, COUNT(l.lesson_id) as lesson_count " +
                     "FROM modules m " +
                     "LEFT JOIN lessons l ON m.module_id = l.module_id " +
                     "WHERE m.course_id = ? " +
                     "GROUP BY m.module_id, m.module_name, m.course_id, m.sort_order " +
                     "ORDER BY m.sort_order";
        try (Connection conn = DatabaseUtil.getConnectDB();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, courseId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ModuleDTO dto = new ModuleDTO();
                dto.setModuleId(rs.getInt("module_id"));
                dto.setModuleName(rs.getString("module_name"));
                dto.setCourseId(rs.getInt("course_id"));
                dto.setSortOrder(rs.getInt("sort_order"));
                dto.setTotal_lessons(rs.getInt("lesson_count"));
                list.add(dto);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    @Override
    public List<ModuleDTO> findModulesDTOByStudentId(int studentId) {
        List<ModuleDTO> list = new ArrayList<>();
        String sql = "SELECT m.module_id, m.module_name, " +
                "COALESCE(SUM(CASE WHEN lp.is_completed = 1 THEN 1 ELSE 0 END), 0) AS completed_lessons, " +
                "COUNT(l.lesson_id) AS total_lessons, " +
                "(COALESCE(SUM(CASE WHEN lp.is_completed = 1 THEN 1 ELSE 0 END), 0) * 100.0 / NULLIF(COUNT(l.lesson_id), 0)) AS progress_percentage " +
                "FROM modules m JOIN lessons l ON m.module_id = l.module_id " +
                "LEFT JOIN lesson_progress lp ON l.lesson_id = lp.lesson_id AND lp.student_id = ? " +
                "GROUP BY m.module_id, m.module_name ORDER BY m.sort_order";
        try (Connection conn = DatabaseUtil.getConnectDB();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, studentId);
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

    @Override
    public ModuleDTO findById(int moduleId) {
        String sql = "SELECT module_id, module_name, course_id, sort_order FROM modules WHERE module_id = ?";
        try (Connection conn = DatabaseUtil.getConnectDB();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, moduleId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                ModuleDTO dto = new ModuleDTO();
                dto.setModuleId(rs.getInt("module_id"));
                dto.setModuleName(rs.getString("module_name"));
                dto.setCourseId(rs.getInt("course_id"));
                dto.setSortOrder(rs.getInt("sort_order"));
                return dto;
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    @Override
    public ModuleDTO findByNameAndCourseId(String moduleName, int courseId) {
        String sql = "SELECT module_id, module_name, course_id, sort_order FROM modules WHERE LOWER(module_name) = LOWER(?) AND course_id = ?";
        try (Connection conn = DatabaseUtil.getConnectDB();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, moduleName);
            ps.setInt(2, courseId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                ModuleDTO dto = new ModuleDTO();
                dto.setModuleId(rs.getInt("module_id"));
                dto.setModuleName(rs.getString("module_name"));
                dto.setCourseId(rs.getInt("course_id"));
                dto.setSortOrder(rs.getInt("sort_order"));
                return dto;
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    @Override
    public void save(ModuleDTO moduleDTO) {
        String sql = "INSERT INTO modules (module_name, course_id, sort_order) VALUES (?, ?, ?)";
        try (Connection conn = DatabaseUtil.getConnectDB();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, moduleDTO.getModuleName());
            ps.setInt(2, moduleDTO.getCourseId());
            ps.setInt(3, moduleDTO.getSortOrder());
            ps.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    @Override
    public void update(ModuleDTO moduleDTO) {
        String sql = "UPDATE modules SET module_name = ?, sort_order = ? WHERE module_id = ?";
        try (Connection conn = DatabaseUtil.getConnectDB();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, moduleDTO.getModuleName());
            ps.setInt(2, moduleDTO.getSortOrder());
            ps.setInt(3, moduleDTO.getModuleId());
            ps.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    @Override
    public void delete(int moduleId) {
        String sql = "DELETE FROM modules WHERE module_id = ?";
        try (Connection conn = DatabaseUtil.getConnectDB();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, moduleId);
            ps.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }
}
