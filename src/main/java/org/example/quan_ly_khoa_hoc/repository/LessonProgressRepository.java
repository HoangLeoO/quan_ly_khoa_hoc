package org.example.quan_ly_khoa_hoc.repository;

import org.example.quan_ly_khoa_hoc.repository.repositoryInterface.ILessonProgressRepository;
import org.example.quan_ly_khoa_hoc.util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class LessonProgressRepository implements ILessonProgressRepository {
    @Override
    public boolean updateIsComplete(Boolean is_completed, int student_id, int lesson_id) {
        try (Connection connection = DatabaseUtil.getConnectDB()) {
            PreparedStatement preparedStatement = connection.prepareStatement("UPDATE lesson_progress\n" +
                    "SET\n" +
                    "    is_completed = ?,                 -- Đặt trạng thái thành TRUE (Đã hoàn thành)\n" +
                    "    completed_at = CURRENT_TIMESTAMP     -- Cập nhật thời gian hoàn thành là thời điểm hiện tại\n" +
                    "WHERE\n" +
                    "    student_id = ?\n" +
                    "  AND lesson_id = ?;");
            preparedStatement.setBoolean(1, is_completed);
            preparedStatement.setInt(2, student_id);
            preparedStatement.setInt(3, lesson_id);
            int resultSet = preparedStatement.executeUpdate();
            if (resultSet > 0) {
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
