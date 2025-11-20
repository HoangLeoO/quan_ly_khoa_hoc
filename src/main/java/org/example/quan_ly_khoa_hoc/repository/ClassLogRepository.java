package org.example.quan_ly_khoa_hoc.repository;

import org.example.quan_ly_khoa_hoc.dto.ClassLogDTO; // Import DTO
import org.example.quan_ly_khoa_hoc.entity.ClassLog;
import org.example.quan_ly_khoa_hoc.repository.repositoryInterface.IClassLogRepository;
import org.example.quan_ly_khoa_hoc.util.DatabaseUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ClassLogRepository implements IClassLogRepository {

    // --- SQL QUERIES ---
    private final String INSERT_LOG =
            "INSERT INTO class_logs (class_id, author_staff_id, content) VALUES (?, ?, ?)";

    // Câu SELECT cơ sở, JOIN với bảng staff để lấy tên tác giả (full_name)
    // Alias 'cl' cho class_logs và 's' cho staff
    private final String BASE_SELECT_LOG_WITH_STAFF =
            "SELECT cl.log_id, cl.class_id, cl.author_staff_id, cl.content, cl.created_at, s.full_name " +
                    "FROM class_logs cl JOIN staff s ON cl.author_staff_id = s.staff_id ";

    private final String SELECT_LOG_BY_ID = BASE_SELECT_LOG_WITH_STAFF + "WHERE cl.log_id = ?";
    private final String SELECT_ALL_LOGS = BASE_SELECT_LOG_WITH_STAFF + "ORDER BY cl.created_at DESC";
    private final String SELECT_LOGS_BY_CLASS_ID = BASE_SELECT_LOG_WITH_STAFF + "WHERE cl.class_id = ? ORDER BY cl.created_at DESC";

    private final String UPDATE_LOG =
            "UPDATE class_logs SET content = ? WHERE log_id = ?";
    private final String DELETE_LOG =
            "DELETE FROM class_logs WHERE log_id = ?";


    // ----------------------------------------------------
    // 1. CREATE (SAVE) - Ghi dữ liệu, vẫn dùng ClassLog Entity
    // ----------------------------------------------------
    @Override
    public int save(ClassLog classLog) {
        int generatedId = 0;
        try (Connection conn = DatabaseUtil.getConnectDB();
             PreparedStatement ps = conn.prepareStatement(INSERT_LOG, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, classLog.getClassId());
            ps.setInt(2, classLog.getAuthorStaffId());
            ps.setString(3, classLog.getContent());

            int affectedRows = ps.executeUpdate();

            if (affectedRows > 0) {
                // Lấy ID tự động tạo
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        generatedId = rs.getInt(1);
                    }
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi tạo nhật ký lớp học: " + e.getMessage());
            e.printStackTrace();
        }
        return generatedId;
    }

    // ----------------------------------------------------
    // 2. READ (FIND BY ID) - Trả về ClassLogDTO
    // ----------------------------------------------------
    @Override
    public ClassLogDTO findById(int logId) {
        ClassLogDTO log = null;
        try (Connection conn = DatabaseUtil.getConnectDB();
             PreparedStatement ps = conn.prepareStatement(SELECT_LOG_BY_ID)) {

            ps.setInt(1, logId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    log = mapResultSetToClassLogDTO(rs); // Sử dụng DTO mapper mới
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi tìm nhật ký theo ID: " + e.getMessage());
            e.printStackTrace();
        }
        return log;
    }

    // ----------------------------------------------------
    // 3. READ (FIND ALL) - Trả về List<ClassLogDTO>
    // ----------------------------------------------------
    @Override
    public List<ClassLogDTO> findAll() {
        List<ClassLogDTO> logs = new ArrayList<>();
        try (Connection conn = DatabaseUtil.getConnectDB();
             PreparedStatement ps = conn.prepareStatement(SELECT_ALL_LOGS);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                logs.add(mapResultSetToClassLogDTO(rs)); // Sử dụng DTO mapper mới
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy tất cả nhật ký: " + e.getMessage());
            e.printStackTrace();
        }
        return logs;
    }

    // ----------------------------------------------------
    // 4. READ (FIND BY CLASS ID) - Trả về List<ClassLogDTO>
    // ----------------------------------------------------
    @Override
    public List<ClassLogDTO> findByClassId(int classId) {
        List<ClassLogDTO> logs = new ArrayList<>();
        try (Connection conn = DatabaseUtil.getConnectDB();
             PreparedStatement ps = conn.prepareStatement(SELECT_LOGS_BY_CLASS_ID)) {

            ps.setInt(1, classId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    logs.add(mapResultSetToClassLogDTO(rs)); // Sử dụng DTO mapper mới
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy danh sách nhật ký theo Class ID: " + e.getMessage());
            e.printStackTrace();
        }
        return logs;
    }


    // ----------------------------------------------------
    // 5. UPDATE
    // ----------------------------------------------------
    @Override
    public boolean update(ClassLog classLog) {
        try (Connection conn = DatabaseUtil.getConnectDB();
             PreparedStatement ps = conn.prepareStatement(UPDATE_LOG)) {

            ps.setString(1, classLog.getContent());
            ps.setInt(2, classLog.getLogId());

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

    // --- MAPPER HELPER (Ánh xạ ResultSet thành đối tượng ClassLogDTO) ---
    private ClassLogDTO mapResultSetToClassLogDTO(ResultSet rs) throws SQLException {
        ClassLogDTO logDTO = new ClassLogDTO();
        logDTO.setLogId(rs.getInt("log_id"));
        logDTO.setClassId(rs.getInt("class_id"));
        logDTO.setAuthorStaffId(rs.getInt("author_staff_id"));
        logDTO.setContent(rs.getString("content"));
        logDTO.setCreatedAt(rs.getTimestamp("created_at"));

        // Lấy Tên Staff (full_name) từ kết quả JOIN
        logDTO.setAuthorStaffName(rs.getString("full_name"));

        return logDTO;
    }
}