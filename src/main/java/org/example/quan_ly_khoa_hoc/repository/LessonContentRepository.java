package org.example.quan_ly_khoa_hoc.repository;

import org.example.quan_ly_khoa_hoc.dto.LessonContentRowDTO;
import org.example.quan_ly_khoa_hoc.repository.repositoryInterface.ILessonContentRepository;
import org.example.quan_ly_khoa_hoc.util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class LessonContentRepository implements ILessonContentRepository {
    @Override
    public List<LessonContentRowDTO> getLessonContentById(int studentId, int lessonId, int moduleId) {
        List<LessonContentRowDTO> list = new ArrayList<>();

        String sql = "SELECT\n" +
                "    l.lesson_id, l.lesson_name, m.module_id, m.module_name,\n" +
                "    lc.content_id, lc.content_type, lc.content_data,\n" +
                "    COALESCE(lp.is_completed, 0) AS student_lesson_completed,\n" +
                "    lp.completed_at\n" +
                "FROM\n" +
                "    lessons l\n" +
                "    JOIN modules m ON l.module_id = m.module_id\n" +
                "    JOIN lesson_contents lc ON l.lesson_id = lc.lesson_id\n" +
                "    LEFT JOIN lesson_progress lp ON l.lesson_id = lp.lesson_id AND lp.student_id = ?\n" +
                "WHERE\n" +
                "    l.lesson_id = ?\n" +
                "    AND m.module_id = ?\n" +
                "ORDER BY\n" +
                "    l.sort_order, lc.content_id;";

        try (Connection conn = DatabaseUtil.getConnectDB();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, studentId); // lp.student_id = ?
            ps.setInt(2, lessonId);  // l.lesson_id = ?
            ps.setInt(3, moduleId);  // m.module_id = ?

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    LessonContentRowDTO dto = new LessonContentRowDTO();

                    dto.setLessonId(rs.getInt("lesson_id"));
                    dto.setLessonName(rs.getString("lesson_name"));
                    dto.setModuleId(rs.getInt("module_id"));
                    dto.setModuleName(rs.getString("module_name"));
                    dto.setContentId(rs.getInt("content_id"));
                    dto.setContentType(rs.getString("content_type"));
                    dto.setContentData(rs.getString("content_data"));
                    dto.setStudentLessonCompleted(rs.getBoolean("student_lesson_completed"));
                    dto.setCompletedAt(rs.getTimestamp("completed_at"));

                    list.add(dto);
                }
            }
        } catch (Exception e) {
            System.err.println("Lỗi truy vấn nội dung bài học: studentId=" + studentId + ", lessonId=" + lessonId);
            e.printStackTrace();
        }
        return list;
    }
import org.example.quan_ly_khoa_hoc.dto.LessonContentDTO;
import org.example.quan_ly_khoa_hoc.repository.repositoryInterface.ILessonContentRepository;
import org.example.quan_ly_khoa_hoc.util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class LessonContentRepository implements ILessonContentRepository {
    @Override
    public LessonContentDTO findByLessonId(int lessonId) {
        String sql = "SELECT content_id, lesson_id, content_type, content_data FROM lesson_contents WHERE lesson_id = ?";
        try (Connection conn = DatabaseUtil.getConnectDB();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, lessonId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new LessonContentDTO(
                        rs.getInt("content_id"),
                        rs.getInt("lesson_id"),
                        rs.getString("content_type"),
                        rs.getString("content_data")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public void save(LessonContentDTO lessonContentDTO) {
        String sql = "INSERT INTO lesson_contents (lesson_id, content_type, content_data) VALUES (?, ?, ?)";
        try (Connection conn = DatabaseUtil.getConnectDB();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, lessonContentDTO.getLessonId());
            ps.setString(2, lessonContentDTO.getContentType());
            ps.setString(3, lessonContentDTO.getContentData());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void update(LessonContentDTO lessonContentDTO) {
        String sql = "UPDATE lesson_contents SET content_type = ?, content_data = ? WHERE lesson_id = ?";
        try (Connection conn = DatabaseUtil.getConnectDB();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, lessonContentDTO.getContentType());
            ps.setString(2, lessonContentDTO.getContentData());
            ps.setInt(3, lessonContentDTO.getLessonId());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
