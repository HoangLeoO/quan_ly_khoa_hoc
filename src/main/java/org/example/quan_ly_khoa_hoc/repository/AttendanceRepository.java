package org.example.quan_ly_khoa_hoc.repository;

import org.example.quan_ly_khoa_hoc.dto.ScheduleDTO;
import org.example.quan_ly_khoa_hoc.entity.Attendance;
import org.example.quan_ly_khoa_hoc.repository.repositoryInterface.IAttendanceRepository;
import org.example.quan_ly_khoa_hoc.util.DatabaseUtil;

import java.sql.*;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

public class AttendanceRepository implements IAttendanceRepository {

    private final String SELECT_SCHEDULES_FOR_TODAY =
            "SELECT " +
                    "    s.schedule_id, s.class_id, s.lesson_id, s.time_start, s.time_end, s.room, " +
                    "    c.class_name, l.lesson_name, co.course_name " +
                    "FROM schedules s " +
                    "JOIN classes c ON s.class_id = c.class_id " +
                    "LEFT JOIN lessons l ON s.lesson_id = l.lesson_id " +
                    "JOIN courses co ON c.course_id = co.course_id " +
                    // Điều kiện lọc theo ngày hiện tại
                    "WHERE DATE(s.time_start) = CURRENT_DATE() " +
                    // Điều kiện lọc theo Staff ID của giáo viên
                    "  AND c.teacher_id = ? " +
                    "ORDER BY s.time_start ASC";
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
    private final String INSERT_SCHEDULE =
            "INSERT INTO schedules (class_id, lesson_id, time_start, time_end, room) VALUES (?, ?, ?, ?, ?)";

    private final String FIND_TODAY_SCHEDULE_BY_CLASS =
            "SELECT sch.schedule_id, sch.class_id, sch.lesson_id, sch.time_start, sch.time_end, sch.room, " +
                    "       c.class_name, l.lesson_name " +
                    "FROM schedules sch " +
                    "JOIN classes c ON sch.class_id = c.class_id " +
                    "LEFT JOIN lessons l ON sch.lesson_id = l.lesson_id " +
                    "WHERE sch.class_id = ? AND DATE(sch.time_start) = CURDATE() " +
                    "LIMIT 1";

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
                throw new RuntimeException("Lỗi khi lưu điểm danh hàng loạt.", e);
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

                Timestamp timeEnd = rs.getTimestamp("time_end");
                if (timeEnd != null) {
                    schedule.setTimeEnd(timeEnd.toLocalDateTime());
                }

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

    @Override
    public List<ScheduleDTO> findSchedulesForToday(int teacherStaffId) {
        List<ScheduleDTO> scheduleList = new ArrayList<>();

        try (Connection connection = DatabaseUtil.getConnectDB();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_SCHEDULES_FOR_TODAY)) {

            // Gán giá trị teacherStaffId vào tham số đầu tiên (?)
            preparedStatement.setInt(1, teacherStaffId);

            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                ScheduleDTO schedule = new ScheduleDTO();
                schedule.setScheduleId(resultSet.getInt("schedule_id"));
                schedule.setClassId(resultSet.getInt("class_id"));
                schedule.setLessionId(resultSet.getInt("lesson_id"));
                schedule.setTimeStart(resultSet.getObject("time_start", LocalDateTime.class));
                schedule.setRoom(resultSet.getString("room"));
                schedule.setClassName(resultSet.getString("class_name"));
                schedule.setLessonName(resultSet.getString("lesson_name"));
                scheduleList.add(schedule);
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy danh sách lịch học hôm nay theo giáo viên: " + e.getMessage());
            e.printStackTrace();
        }

        return scheduleList;
    }


    // ------------------------------------------

    @Override
    public int createScheduleAndGetId(int classId, Integer lessonId, LocalDateTime timeStart, LocalDateTime timeEnd, String room) {
        int newScheduleId = -1;
        try (Connection conn = DatabaseUtil.getConnectDB();
             // SỬ DỤNG Statement.RETURN_GENERATED_KEYS ĐỂ LẤY ID MỚI TẠO
             PreparedStatement ps = conn.prepareStatement(INSERT_SCHEDULE, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, classId);

            // Xử lý LessonId có thể là NULL
            if (lessonId != null && lessonId > 0) {
                ps.setInt(2, lessonId);
            } else {
                ps.setNull(2, java.sql.Types.INTEGER);
            }

            ps.setTimestamp(3, Timestamp.valueOf(timeStart));
            ps.setTimestamp(4, Timestamp.valueOf(timeEnd));
            ps.setString(5, room);

            int affectedRows = ps.executeUpdate();

            if (affectedRows == 0) {
                throw new SQLException("Tạo buổi học thất bại, không có hàng nào được thêm.");
            }

            try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    newScheduleId = generatedKeys.getInt(1); // Trả về schedule_id
                } else {
                    throw new SQLException("Tạo buổi học thất bại, không lấy được ID.");
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi SQL khi tạo buổi học mới: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("Lỗi hệ thống khi tạo lịch học mới.", e);
        }
        return newScheduleId;
    }

    @Override
    public boolean hasScheduleForClassOnDate(int classId, LocalDateTime date) {
        String sql = "SELECT COUNT(*) FROM schedules " +
                "WHERE class_id = ? AND DATE(time_start) = DATE(?)";

        try (Connection connection = DatabaseUtil.getConnectDB();
             PreparedStatement stmt = connection.prepareStatement(sql)) {

            stmt.setInt(1, classId);
            stmt.setTimestamp(2, Timestamp.valueOf(date));

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next() && rs.getInt(1) > 0) {
                    return true;
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi kiểm tra trùng lặp lịch học (CSDL): " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public ScheduleDTO findTodayScheduleByClassId(int classId) {
        ScheduleDTO schedule = null;
        try (Connection conn = DatabaseUtil.getConnectDB();
             PreparedStatement ps = conn.prepareStatement(FIND_TODAY_SCHEDULE_BY_CLASS)) {

            ps.setInt(1, classId);
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

                Timestamp timeEnd = rs.getTimestamp("time_end");
                if (timeEnd != null) {
                    schedule.setTimeEnd(timeEnd.toLocalDateTime());
                }

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