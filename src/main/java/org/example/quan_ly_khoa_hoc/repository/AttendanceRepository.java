package org.example.quan_ly_khoa_hoc.repository;

import org.example.quan_ly_khoa_hoc.dto.AttendanceDetailDTO;
import org.example.quan_ly_khoa_hoc.dto.ScheduleDTO;
import org.example.quan_ly_khoa_hoc.entity.Attendance;
import org.example.quan_ly_khoa_hoc.repository.repositoryInterface.IAttendanceRepository;
import org.example.quan_ly_khoa_hoc.util.DatabaseUtil;

import java.sql.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class AttendanceRepository implements IAttendanceRepository {
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

    private final String UPDATE_ATTENDANCE =
            "UPDATE attendance SET status = ?, note = ? WHERE attendance_id = ?";

    private final String DELETE_ATTENDANCE =
            "DELETE FROM attendance WHERE attendance_id = ?";
    private final String SELECT_SCHEDULES_TODAY =
            "SELECT sch.schedule_id, sch.class_id, c.class_name, l.lesson_name, sch.time_start, sch.room " +
                    "FROM schedules sch " +
                    "JOIN classes c ON sch.class_id = c.class_id " +
                    "LEFT JOIN lessons l ON sch.lesson_id = l.lesson_id " +
                    "WHERE DATE(sch.time_start) = CURDATE() " +
                    "ORDER BY sch.time_start ASC";
    @Override
    public Integer findScheduleId(int classId, LocalDate date, int lessonId) {
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
    @Override
    public void saveBatchAttendance(List<Attendance> attendanceList) {
        String sql = "INSERT INTO attendance (schedule_id, student_id, status, note) VALUES (?, ?, ?, ?) " +
                "ON DUPLICATE KEY UPDATE status = VALUES(status), note = VALUES(note)";
        try (Connection conn = DatabaseUtil.getConnectDB()) {
            conn.setAutoCommit(false);
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
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


    @Override
    public List<ScheduleDTO> getSchedulesByClassId(int classId) {
        List<ScheduleDTO> schedules = new ArrayList<>();
        try (Connection conn = DatabaseUtil.getConnectDB();
             PreparedStatement ps = conn.prepareStatement(SELECT_SCHEDULES_BY_CLASS)) {

            ps.setInt(1, classId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                ScheduleDTO dto = new ScheduleDTO();
                dto.setScheduleId(rs.getInt("schedule_id"));
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

    @Override
    public List<AttendanceDetailDTO> getAttendanceByScheduleId(int scheduleId) {
        List<AttendanceDetailDTO> attendanceList = new ArrayList<>();
        try (Connection conn = DatabaseUtil.getConnectDB();
             PreparedStatement ps = conn.prepareStatement(SELECT_ATTENDANCE_BY_SCHEDULE)) {
            ps.setInt(1, scheduleId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                AttendanceDetailDTO dto = new AttendanceDetailDTO();
                dto.setAttendanceId(rs.getInt("attendance_id"));
                dto.setStatus(rs.getString("status"));
                dto.setNote(rs.getString("note"));

                dto.setStudentId(rs.getInt("student_id"));
                dto.setFullName(rs.getString("full_name"));
                attendanceList.add(dto);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return attendanceList;
    }

    @Override
    public ScheduleDTO findAttendanceById(int attendanceId) {
        return null;
    }

    @Override
    public boolean updateAttendance(int attendanceId, String status, String note) {
        return false;
    }

    @Override
    public boolean deleteAttendance(int attendanceId) {
        return false;
    }
}
