package org.example.quan_ly_khoa_hoc.repository;

import org.example.quan_ly_khoa_hoc.entity.Attendance;
import org.example.quan_ly_khoa_hoc.repository.repositoryInterface.IAttendanceRepository;
import org.example.quan_ly_khoa_hoc.util.DatabaseUtil;

import java.sql.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

public class AttendanceRepository implements IAttendanceRepository {
    // 1. TÌM LỊCH HỌC (Dựa trên ngày của time_start)
    @Override
    public Integer findScheduleId(int classId, LocalDate date, int lessonId) {
        // MySQL: Dùng hàm DATE(time_start) để lấy ngày, bỏ giờ
        String sql = "SELECT schedule_id FROM schedules WHERE class_id = ? AND DATE(time_start) = ? AND lesson_id = ?";

        try (Connection conn = DatabaseUtil.getConnectDB();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, classId);
            ps.setDate(2, Date.valueOf(date));
            ps.setInt(3, lessonId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt("schedule_id");
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    // 2. TẠO LỊCH HỌC MỚI (Nếu chưa có)
    @Override
    public int createSchedule(int classId, LocalDate date, int lessonId) {
        // Insert vào time_start, time_end (Bắt buộc theo file SQL của bạn)
        String sql = "INSERT INTO schedules (class_id, lesson_id, time_start, time_end) VALUES (?, ?, ?, ?)";

        try (Connection conn = DatabaseUtil.getConnectDB();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            LocalDateTime startDateTime = date.atTime(8, 0, 0);
            LocalDateTime endDateTime = date.atTime(17, 0, 0);

            ps.setInt(1, classId);
            ps.setInt(2, lessonId);
            ps.setTimestamp(3, Timestamp.valueOf(startDateTime));
            ps.setTimestamp(4, Timestamp.valueOf(endDateTime));
//            ps.setString(5, room);

            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) return rs.getInt(1); // Trả về ID vừa tạo
        } catch (SQLException e) { e.printStackTrace(); }
        return -1;
    }

    // 3. LƯU ĐIỂM DANH (Phụ thuộc vào ID lịch học ở trên)
    @Override
    public void saveBatchAttendance(List<Attendance> attendanceList) {
        String sql = "INSERT INTO attendance (schedule_id, student_id, status, note) VALUES (?, ?, ?, ?) " +
                "ON DUPLICATE KEY UPDATE status = VALUES(status), note = VALUES(note)";

        try (Connection conn = DatabaseUtil.getConnectDB()) {
            conn.setAutoCommit(false); // Bắt đầu giao dịch
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                for (Attendance att : attendanceList) {
                    ps.setInt(1, att.getScheduleId());
                    ps.setInt(2, att.getStudentId());
                    ps.setString(3, att.getStatus());
                    ps.setString(4, att.getNote());
                    ps.addBatch();
                }
                ps.executeBatch();
                conn.commit(); // Lưu tất cả
            } catch (SQLException e) {
                conn.rollback(); // Lỗi thì hoàn tác
                e.printStackTrace();
            }
        } catch (SQLException e) { e.printStackTrace(); }
    }
}
