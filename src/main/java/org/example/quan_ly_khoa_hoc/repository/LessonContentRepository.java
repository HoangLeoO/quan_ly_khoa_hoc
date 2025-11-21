package org.example.quan_ly_khoa_hoc.repository;

import org.example.quan_ly_khoa_hoc.dto.LessonContentDTO;
import org.example.quan_ly_khoa_hoc.repository.repositoryInterface.ILessonContentRepository;
import org.example.quan_ly_khoa_hoc.util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class LessonContentRepository implements ILessonContentRepository {
    @Override
    public List<LessonContentDTO> findByLessonId(int lessonId) {
        List<LessonContentDTO> contents = new ArrayList<>();
        String sql = "SELECT content_id, lesson_id, content_type, content_name, content_data FROM lesson_contents WHERE lesson_id = ? ORDER BY content_id ASC";
        try (Connection conn = DatabaseUtil.getConnectDB();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, lessonId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                contents.add(new LessonContentDTO(
                        rs.getInt("content_id"),
                        rs.getInt("lesson_id"),
                        rs.getString("content_type"),
                        rs.getString("content_name"), // Get content_name
                        rs.getString("content_data")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return contents;
    }

    @Override
    public LessonContentDTO findById(int contentId) {
        String sql = "SELECT content_id, lesson_id, content_type, content_name, content_data FROM lesson_contents WHERE content_id = ?";
        try (Connection conn = DatabaseUtil.getConnectDB();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, contentId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new LessonContentDTO(
                        rs.getInt("content_id"),
                        rs.getInt("lesson_id"),
                        rs.getString("content_type"),
                        rs.getString("content_name"), // Get content_name
                        rs.getString("content_data")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public LessonContentDTO save(LessonContentDTO lessonContentDTO) {
        String sql = "INSERT INTO lesson_contents (lesson_id, content_type, content_name, content_data) VALUES (?, ?, ?, ?)";
        try (Connection conn = DatabaseUtil.getConnectDB();
             PreparedStatement ps = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, lessonContentDTO.getLessonId());
            ps.setString(2, lessonContentDTO.getContentType());
            ps.setString(3, lessonContentDTO.getContentName()); // Set content_name
            ps.setString(4, lessonContentDTO.getContentData());
            ps.executeUpdate();
            try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    lessonContentDTO.setContentId(generatedKeys.getInt(1));
                }
            }
            return lessonContentDTO;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public void update(LessonContentDTO lessonContentDTO) {
        String sql = "UPDATE lesson_contents SET content_type = ?, content_name = ?, content_data = ? WHERE content_id = ?";
        try (Connection conn = DatabaseUtil.getConnectDB();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, lessonContentDTO.getContentType());
            ps.setString(2, lessonContentDTO.getContentName()); // Set content_name
            ps.setString(3, lessonContentDTO.getContentData());
            ps.setInt(4, lessonContentDTO.getContentId());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void delete(int contentId) {
        String sql = "DELETE FROM lesson_contents WHERE content_id = ?";
        try (Connection conn = DatabaseUtil.getConnectDB();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, contentId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
