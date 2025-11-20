package org.example.quan_ly_khoa_hoc.repository;

import org.example.quan_ly_khoa_hoc.dto.ScheduleDTO;
import org.example.quan_ly_khoa_hoc.entity.Attendance;
import org.example.quan_ly_khoa_hoc.repository.repositoryInterface.IAttendanceRepository;
import org.example.quan_ly_khoa_hoc.util.DatabaseUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AttendanceRepository implements IAttendanceRepository {


    private final String SELECT_SCHEDULE_BY_ID =
            "SELECT sch.schedule_id, sch.class_id, sch.lesson_id, sch.time_start, sch.time_end, sch.room, " +
                    "       c.class_name, l.lesson_name " +
                    "FROM schedules sch " +
                    "JOIN classes c ON sch.class_id = c.class_id " +
                    "LEFT JOIN lessons l ON sch.lesson_id = l.lesson_id " +
                    "WHERE sch.schedule_id = ?";


    private final String SELECT_SCHEDULES_TODAY =
            "SELECT sch.schedule_id, sch.class_id, c.class_name, l.lesson_name, sch.time_start, sch.room " +
                    "FROM schedules sch " +
                    "JOIN classes c ON sch.class_id = c.class_id " +
                    "LEFT JOIN lessons l ON sch.lesson_id = l.lesson_id " +
                    "WHERE DATE(sch.time_start) = CURDATE() " +
                    "ORDER BY sch.time_start ASC";

    private final String INSERT_OR_UPDATE_ATTENDANCE =
            "INSERT INTO attendance (schedule_id, student_id, status, note) VALUES (?, ?, ?, ?) " +
                    "ON DUPLICATE KEY UPDATE status = VALUES(status), note = VALUES(note)";

    private final String COUNT_ATTENDANCE_BY_SCHEDULE_ID =
            "SELECT COUNT(*) FROM attendance WHERE schedule_id = ?";

    private final String FIND_ATTENDANCE_BY_SCHEDULE_ID =
            "SELECT student_id, status, note FROM attendance WHERE schedule_id = ?";



    @Override
    public void saveBatchAttendance(List<Attendance> attendanceList) {
        // ... (Logic giữ nguyên) ...
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
                throw new RuntimeException("Lỗi khi lưu điểm danh hàng loạt.", e); // Thêm ngoại lệ Runtime
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Lỗi kết nối CSDL.", e);
        }
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

    // ----------------------------------------------------
    // PHƯƠNG THỨC MỚI 1: KIỂM TRA TRẠNG THÁI ĐIỂM DANH
    // ----------------------------------------------------
    @Override
    public int countAttendanceByScheduleId(int scheduleId) {
        int count = 0;
        try (Connection conn = DatabaseUtil.getConnectDB();
             PreparedStatement ps = conn.prepareStatement(COUNT_ATTENDANCE_BY_SCHEDULE_ID)) {

            ps.setInt(1, scheduleId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    count = rs.getInt(1); // Lấy giá trị của COUNT(*)
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi truy vấn SQL khi đếm bản ghi điểm danh: " + e.getMessage());
            e.printStackTrace();
        }
        return count;
    }

    // ----------------------------------------------------
    // PHƯƠNG THỨC MỚI 2: LẤY DỮ LIỆU ĐIỂM DANH CŨ (CHỈNH SỬA)
    // ----------------------------------------------------
    @Override
    public List<Attendance> findByScheduleId(int scheduleId) {
        List<Attendance> attendanceList = new ArrayList<>();
        try (Connection conn = DatabaseUtil.getConnectDB();
             PreparedStatement ps = conn.prepareStatement(FIND_ATTENDANCE_BY_SCHEDULE_ID)) {

            ps.setInt(1, scheduleId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {

                    Attendance att = new Attendance();
                    att.setStudentId(rs.getInt("student_id"));
                    att.setScheduleId(scheduleId);
                    att.setStatus(rs.getString("status"));
                    att.setNote(rs.getString("note"));


                    attendanceList.add(att);
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi truy vấn SQL khi lấy dữ liệu điểm danh cũ: " + e.getMessage());
            e.printStackTrace();
        }
        return attendanceList;
    }
}