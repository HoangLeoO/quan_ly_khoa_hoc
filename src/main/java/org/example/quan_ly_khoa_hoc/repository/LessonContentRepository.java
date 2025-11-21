package org.example.quan_ly_khoa_hoc.repository;

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
