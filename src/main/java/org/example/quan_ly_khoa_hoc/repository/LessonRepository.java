package org.example.quan_ly_khoa_hoc.repository;

import org.example.quan_ly_khoa_hoc.dto.LessonDTO;
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
    public List<LessonDTO> findLessonsByModuleId(int moduleId) {
        List<LessonDTO> list = new ArrayList<>();
        String sql = "SELECT l.lesson_id, l.lesson_name, l.module_id, l.sort_order, lc.content_type " +
                     "FROM lessons l " +
                     "LEFT JOIN lesson_contents lc ON l.lesson_id = lc.lesson_id " +
                     "WHERE l.module_id = ? ORDER BY l.sort_order";
        try (Connection conn = DatabaseUtil.getConnectDB();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, moduleId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new LessonDTO(
                    rs.getInt("lesson_id"),
                    rs.getString("lesson_name"),
                    rs.getInt("module_id"),
                    rs.getInt("sort_order"),
                    rs.getString("content_type") // Get content_type
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public LessonDTO findById(int lessonId) {
        String sql = "SELECT l.lesson_id, l.lesson_name, l.module_id, l.sort_order, lc.content_type " +
                     "FROM lessons l " +
                     "LEFT JOIN lesson_contents lc ON l.lesson_id = lc.lesson_id " +
                     "WHERE l.lesson_id = ?";
        try (Connection conn = DatabaseUtil.getConnectDB();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, lessonId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                LessonDTO dto = new LessonDTO();
                dto.setLessonId(rs.getInt("lesson_id"));
                dto.setLessonName(rs.getString("lesson_name"));
                dto.setModuleId(rs.getInt("module_id"));
                dto.setSortOrder(rs.getInt("sort_order"));
                dto.setContentType(rs.getString("content_type")); // Get content_type
                return dto;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<LessonDTO> getAllByModuleIdAndStudentId(int moduleId, int studentId) {
        List<LessonDTO> list = new ArrayList<>();
        String sql = "SELECT l.lesson_id, l.lesson_name,COALESCE(lp.is_completed, 0) as is_completed " +
                     "FROM lessons l " +
                     "LEFT JOIN lesson_progress lp ON l.lesson_id = lp.lesson_id AND lp.student_id = ? " +
                     "WHERE l.module_id = ?;";
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

    @Override
    public LessonDTO save(LessonDTO lessonDTO) {
        String sql = "INSERT INTO lessons (module_id, lesson_name, sort_order) VALUES (?, ?, ?)";
        try (Connection conn = DatabaseUtil.getConnectDB();
             PreparedStatement ps = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, lessonDTO.getModuleId());
            ps.setString(2, lessonDTO.getLessonName());
            ps.setInt(3, lessonDTO.getSortOrder());
            int affectedRows = ps.executeUpdate();
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        lessonDTO.setLessonId(generatedKeys.getInt(1));
                    }
                }
            }
            return lessonDTO;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public LessonDTO findByNameAndModuleId(String lessonName, int moduleId) {
        String sql = "SELECT lesson_id, lesson_name, module_id, sort_order FROM lessons WHERE LOWER(lesson_name) = LOWER(?) AND module_id = ?";
        try (Connection conn = DatabaseUtil.getConnectDB();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, lessonName);
            ps.setInt(2, moduleId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                LessonDTO dto = new LessonDTO();
                dto.setLessonId(rs.getInt("lesson_id"));
                dto.setLessonName(rs.getString("lesson_name"));
                dto.setModuleId(rs.getInt("module_id"));
                dto.setSortOrder(rs.getInt("sort_order"));
                return dto;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public void update(LessonDTO lessonDTO) {
        String sql = "UPDATE lessons SET lesson_name = ?, sort_order = ? WHERE lesson_id = ?";
        try (Connection conn = DatabaseUtil.getConnectDB();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, lessonDTO.getLessonName());
            ps.setInt(2, lessonDTO.getSortOrder());
            ps.setInt(3, lessonDTO.getLessonId());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void delete(int lessonId) {
        String sql = "DELETE FROM lessons WHERE lesson_id = ?";
        try (Connection conn = DatabaseUtil.getConnectDB();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, lessonId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
