package org.example.quan_ly_khoa_hoc.repository;

import org.example.quan_ly_khoa_hoc.dto.ScheduleDTO;
import org.example.quan_ly_khoa_hoc.entity.Attendance;
import org.example.quan_ly_khoa_hoc.repository.repositoryInterface.IAttendanceRepository;
import org.example.quan_ly_khoa_hoc.util.DatabaseUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AttendanceRepository implements IAttendanceRepository {

    // --- CÁC HẰNG SỐ SQL CẦN THIẾT CHO LUỒNG ĐIỂM DANH MỚI ---

    // 1. Lấy chi tiết Schedule theo ID (Dùng cho showAttendanceForm)
    private final String SELECT_SCHEDULE_BY_ID =
            "SELECT sch.schedule_id, sch.class_id, sch.lesson_id, sch.time_start, sch.time_end, sch.room, " +
                    "       c.class_name, l.lesson_name " +
                    "FROM schedules sch " +
                    "JOIN classes c ON sch.class_id = c.class_id " +
                    "LEFT JOIN lessons l ON sch.lesson_id = l.lesson_id " +
                    "WHERE sch.schedule_id = ?";

    // 2. Lấy danh sách lịch học hôm nay (Dùng cho showTodaySchedules)
    private final String SELECT_SCHEDULES_TODAY =
            "SELECT sch.schedule_id, sch.class_id, c.class_name, l.lesson_name, sch.time_start, sch.room " +
                    "FROM schedules sch " +
                    "JOIN classes c ON sch.class_id = c.class_id " +
                    "LEFT JOIN lessons l ON sch.lesson_id = l.lesson_id " +
                    "WHERE DATE(sch.time_start) = CURDATE() " +
                    "ORDER BY sch.time_start ASC";

    // 3. Insert hoặc Update điểm danh hàng loạt (Dùng cho doPost)
    private final String INSERT_OR_UPDATE_ATTENDANCE =
            "INSERT INTO attendance (schedule_id, student_id, status, note) VALUES (?, ?, ?, ?) " +
                    "ON DUPLICATE KEY UPDATE status = VALUES(status), note = VALUES(note)";

    // --- CÁC HẰNG SỐ SQL KHÁC (Giữ nguyên cho mục đích quản lý/chi tiết) ---

    private final String SELECT_SCHEDULES_BY_CLASS =
            "SELECT sch.schedule_id, l.lesson_name, sch.time_start, sch.room " +
                    "FROM schedules sch " +
                    "LEFT JOIN lessons l ON sch.lesson_id = l.lesson_id " +
                    "WHERE sch.class_id = ? " +
                    "ORDER BY sch.time_start DESC";
    private final String SELECT_ATTENDANCE_BY_SCHEDULE =
            "SELECT a.attendance_id, a.status, a.note, s.student_id, s.full_name, u.email " +
                    "FROM attendance a " +
                    "JOIN students s ON a.student_id = s.student_id " +
                    "JOIN users u ON s.user_id = u.user_id " +
                    "WHERE a.schedule_id = ? " +
                    "ORDER BY s.full_name ASC";
    private final String SELECT_ATTENDANCE_BY_ID =
            "SELECT a.attendance_id, a.status, a.note, " +
                    "       s.student_id, s.full_name, u.email, " +
                    "       sch.schedule_id, sch.time_start, l.lesson_name " +
                    "FROM attendance a " +
                    "JOIN students s ON a.student_id = s.student_id " +
                    "JOIN users u ON s.user_id = u.user_id " +
                    "JOIN schedules sch ON a.schedule_id = sch.schedule_id " +
                    "LEFT JOIN lessons l ON sch.lesson_id = l.lesson_id " +
                    "WHERE a.attendance_id = ?";

    // --- TRIỂN KHAI PHƯƠNG THỨC: Lưu điểm danh hàng loạt ---

    @Override
    public void saveBatchAttendance(List<Attendance> attendanceList) {
        // Sử dụng hằng số INSERT_OR_UPDATE_ATTENDANCE
        try (Connection conn = DatabaseUtil.getConnectDB()) {
            conn.setAutoCommit(false);
            try (PreparedStatement ps = conn.prepareStatement(INSERT_OR_UPDATE_ATTENDANCE)) {
                for (Attendance att : attendanceList) {
                    ps.setInt(1, att.getScheduleId());
                    ps.setInt(2, att.getStudentId());
                    ps.setString(3, att.getStatus());
                    ps.setString(4, att.getNote());
                    ps.addBatch();
                }
                ps.executeBatch();
                conn.commit();
            } catch (SQLException e) {
                conn.rollback();
                e.printStackTrace();
            }
        } catch (SQLException e) { e.printStackTrace(); }
    }

    // --- TRIỂN KHAI PHƯƠNG THỨC: Lấy danh sách lịch học hôm nay ---

    @Override
    public List<ScheduleDTO> getSchedulesForToday() {
        List<ScheduleDTO> schedules = new ArrayList<>();
        try (Connection conn = DatabaseUtil.getConnectDB();
             PreparedStatement ps = conn.prepareStatement(SELECT_SCHEDULES_TODAY)) {

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                ScheduleDTO dto = new ScheduleDTO();
                dto.setScheduleId(rs.getInt("schedule_id"));
                dto.setClassId(rs.getInt("class_id"));
                dto.setClassName(rs.getString("class_name"));
                dto.setLessonName(rs.getString("lesson_name"));

                Timestamp timeStart = rs.getTimestamp("time_start");
                dto.setTimeStart(timeStart != null ? timeStart.toLocalDateTime() : null);

                dto.setRoom(rs.getString("room"));
                schedules.add(dto);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return schedules;
    }

    // --- TRIỂN KHAI PHƯƠNG THỨC MỚI: Lấy chi tiết lịch học theo ID ---

    @Override
    public ScheduleDTO getScheduleById(int scheduleId) {
        ScheduleDTO schedule = null;
        try (Connection conn = DatabaseUtil.getConnectDB();
             PreparedStatement ps = conn.prepareStatement(SELECT_SCHEDULE_BY_ID)) {

            ps.setInt(1, scheduleId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                schedule = new ScheduleDTO();
                schedule.setScheduleId(rs.getInt("schedule_id"));
                schedule.setClassId(rs.getInt("class_id"));
                // Sửa thành setLessonId để khớp với chuẩn Java Bean
                schedule.setLessionId(rs.getInt("lesson_id"));

                Timestamp timeStart = rs.getTimestamp("time_start");
                if (timeStart != null) {
                    schedule.setTimeStart(timeStart.toLocalDateTime());
                }

                // Cập nhật time_end nếu cần
                // Timestamp timeEnd = rs.getTimestamp("time_end");
                // if (timeEnd != null) { schedule.setTimeEnd(timeEnd.toLocalDateTime()); }

                schedule.setRoom(rs.getString("room"));
                schedule.setClassName(rs.getString("class_name"));
                schedule.setLessonName(rs.getString("lesson_name"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return schedule;
    }
}