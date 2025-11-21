package org.example.quan_ly_khoa_hoc.repository;

import org.example.quan_ly_khoa_hoc.dto.StudentLogDTO;
import org.example.quan_ly_khoa_hoc.entity.StudentLog;
import org.example.quan_ly_khoa_hoc.repository.repositoryInterface.IStudentLogRepository;
import org.example.quan_ly_khoa_hoc.util.DatabaseUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class StudentLogRepository implements IStudentLogRepository {

    // --- SQL QUERIES ---
    private final String INSERT_LOG =
            "INSERT INTO student_logs (student_id, author_staff_id, content) VALUES (?, ?, ?)";

    // Câu SELECT cơ sở, JOIN với students (s) để lấy Student Name và staff (st) để lấy Author Staff Name
    private final String BASE_SELECT_LOG =
            "SELECT sl.log_id, sl.student_id, s.full_name AS student_name, " +
                    "sl.author_staff_id, st.full_name AS author_staff_name, " +
                    "sl.content, sl.created_at " +
                    "FROM student_logs sl " +
                    "JOIN students s ON sl.student_id = s.student_id " +
                    "JOIN staff st ON sl.author_staff_id = st.staff_id ";

    private final String SELECT_LOG_BY_ID = BASE_SELECT_LOG + "WHERE sl.log_id = ?";
    private final String SELECT_LOGS_BY_STUDENT_ID =
            "SELECT DISTINCT sl.log_id, sl.student_id, s.full_name AS student_name, " +
                    "sl.author_staff_id, st.full_name AS author_staff_name, sl.content, sl.created_at " +
                    "FROM student_logs sl " +
                    "JOIN students s ON sl.student_id = s.student_id " +
                    "JOIN staff st ON sl.author_staff_id = st.staff_id " +
                    "JOIN enrolments e ON sl.student_id = e.student_id " +
                    "WHERE sl.student_id = ? AND e.status = 'studying' " +    // <--- ĐIỀU KIỆN ĐÃ SỬA
                    "ORDER BY sl.created_at DESC";
    private final String SELECT_LOGS_BY_AUTHOR_STAFF_ID =
            "SELECT DISTINCT sl.log_id, sl.student_id, s.full_name AS student_name, " +
                    "sl.author_staff_id, st.full_name AS author_staff_name, sl.content, sl.created_at " +
                    "FROM student_logs sl " +
                    "JOIN students s ON sl.student_id = s.student_id " +
                    "JOIN staff st ON sl.author_staff_id = st.staff_id " +
                    "JOIN enrolments e ON sl.student_id = e.student_id " +
                    "WHERE sl.author_staff_id = ? AND e.status = 'studying' " + // <--- ĐIỀU KIỆN ĐÃ SỬA
                    "ORDER BY sl.created_at DESC";

    private final String UPDATE_LOG =
            "UPDATE student_logs SET content = ? WHERE log_id = ?";

    private final String DELETE_LOG =
            "DELETE FROM student_logs WHERE log_id = ?";

    private final String SELECT_STUDENT_NAME_BY_ID =
            "SELECT full_name FROM students WHERE student_id = ?";
    // ----------------------------------------------------
    // 1. CREATE (SAVE)
    // ----------------------------------------------------
    @Override
    public int save(StudentLog studentLog) {
        int generatedId = 0;
        try (Connection conn = DatabaseUtil.getConnectDB();
             // Sử dụng Statement.RETURN_GENERATED_KEYS để lấy ID tự động tạo
             PreparedStatement ps = conn.prepareStatement(INSERT_LOG, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, studentLog.getStudentId());
            ps.setInt(2, studentLog.getAuthorStaffId());
            ps.setString(3, studentLog.getContent());

            int affectedRows = ps.executeUpdate();

            if (affectedRows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        generatedId = rs.getInt(1);
                    }
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi tạo nhật ký học sinh: " + e.getMessage());
            e.printStackTrace();
        }
        return generatedId;
    }

    // ----------------------------------------------------
    // 2. READ (FIND BY ID)
    // ----------------------------------------------------
    @Override
    public StudentLogDTO findById(int logId) {
        StudentLogDTO log = null;
        try (Connection conn = DatabaseUtil.getConnectDB();
             PreparedStatement ps = conn.prepareStatement(SELECT_LOG_BY_ID)) {

            ps.setInt(1, logId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    log = mapResultSetToStudentLogDTO(rs);
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi tìm nhật ký theo ID: " + e.getMessage());
            e.printStackTrace();
        }
        return log;
    }

    // ----------------------------------------------------
    // 3. READ (FIND BY STUDENT ID)
    // ----------------------------------------------------
    @Override
    public List<StudentLogDTO> findByStudentId(int studentId) {
        List<StudentLogDTO> logs = new ArrayList<>();
        try (Connection conn = DatabaseUtil.getConnectDB();
             PreparedStatement ps = conn.prepareStatement(SELECT_LOGS_BY_STUDENT_ID)) {

            ps.setInt(1, studentId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    logs.add(mapResultSetToStudentLogDTO(rs));
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy danh sách nhật ký theo Student ID: " + e.getMessage());
            e.printStackTrace();
        }
        return logs;
    }

    // ----------------------------------------------------
    // 4. READ (FIND BY AUTHOR STAFF ID)
    // ----------------------------------------------------
    @Override
    public List<StudentLogDTO> findByAuthorStaffId(int authorStaffId) {
        List<StudentLogDTO> logs = new ArrayList<>();
        try (Connection conn = DatabaseUtil.getConnectDB();
             PreparedStatement ps = conn.prepareStatement(SELECT_LOGS_BY_AUTHOR_STAFF_ID)) {

            ps.setInt(1, authorStaffId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    logs.add(mapResultSetToStudentLogDTO(rs));
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy danh sách nhật ký theo Author Staff ID: " + e.getMessage());
            e.printStackTrace();
        }
        return logs;
    }


    // ----------------------------------------------------
    // 5. UPDATE
    // ----------------------------------------------------
    @Override
    public boolean update(StudentLog studentLog) {
        try (Connection conn = DatabaseUtil.getConnectDB();
             PreparedStatement ps = conn.prepareStatement(UPDATE_LOG)) {

            ps.setString(1, studentLog.getContent());
            ps.setInt(2, studentLog.getLogId());

            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;

        } catch (SQLException e) {
            System.err.println("Lỗi khi cập nhật nhật ký: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // ----------------------------------------------------
    // 6. DELETE
    // ----------------------------------------------------
    @Override
    public boolean delete(int logId) {
        try (Connection conn = DatabaseUtil.getConnectDB();
             PreparedStatement ps = conn.prepareStatement(DELETE_LOG)) {

            ps.setInt(1, logId);
            int rowsDeleted = ps.executeUpdate();

            return rowsDeleted > 0;

        } catch (SQLException e) {
            System.err.println("Lỗi khi xóa nhật ký: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public String findFullNameById(int studentId) {
        String fullName = null;
        try (Connection conn = DatabaseUtil.getConnectDB();
             PreparedStatement ps = conn.prepareStatement(SELECT_STUDENT_NAME_BY_ID)) {

            ps.setInt(1, studentId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    // Lấy giá trị từ cột full_name
                    fullName = rs.getString("full_name");
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi tìm tên học sinh theo ID: " + e.getMessage());
            e.printStackTrace();
        }
        return fullName;
    }

    // --- MAPPER HELPER (Ánh xạ ResultSet thành đối tượng StudentLogDTO) ---
    private StudentLogDTO mapResultSetToStudentLogDTO(ResultSet rs) throws SQLException {
        StudentLogDTO logDTO = new StudentLogDTO();
        logDTO.setLogId(rs.getInt("log_id"));
        logDTO.setStudentId(rs.getInt("student_id"));
        logDTO.setAuthorStaffId(rs.getInt("author_staff_id"));
        logDTO.setContent(rs.getString("content"));
        logDTO.setCreatedAt(rs.getTimestamp("created_at"));

        // Lấy Tên Học sinh (student_name) và Tên Staff (author_staff_name) từ kết quả JOIN
        logDTO.setStudentName(rs.getString("student_name"));
        logDTO.setAuthorStaffName(rs.getString("author_staff_name"));

        return logDTO;
    }
}