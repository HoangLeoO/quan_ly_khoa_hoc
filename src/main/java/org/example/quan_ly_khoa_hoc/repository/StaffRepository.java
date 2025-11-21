package org.example.quan_ly_khoa_hoc.repository;

import org.example.quan_ly_khoa_hoc.dto.TeacherInfoDTO;
import org.example.quan_ly_khoa_hoc.dto.UserDTO;
import org.example.quan_ly_khoa_hoc.entity.Course;
import org.example.quan_ly_khoa_hoc.entity.Staff;
import org.example.quan_ly_khoa_hoc.repository.repositoryInterface.IStaffRepository;
import org.example.quan_ly_khoa_hoc.util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class StaffRepository implements IStaffRepository {
    @Override
    public Staff addStaffInTransaction(Connection connection, Staff staff) throws SQLException {
        if (staff == null || staff.getUserId() == null) {
            throw new IllegalArgumentException("Staff and user_id cannot be null");
        }
        if (staff.getFullName() == null || staff.getFullName().trim().isEmpty()) {
            throw new IllegalArgumentException("Full name cannot be empty");
        }
        String sql = "INSERT INTO staff (user_id, full_name,position,phone,dob,address) VALUES (?, ?,?, ?,?,?)";
        try (PreparedStatement preparedStatement = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
            preparedStatement.setInt(1, staff.getUserId());
            preparedStatement.setString(2, staff.getFullName());
            preparedStatement.setString(3, staff.getPosition());
            preparedStatement.setString(4, staff.getPhone());
            preparedStatement.setDate(5, java.sql.Date.valueOf(staff.getDob()));
            preparedStatement.setString(6, staff.getAddress());
            int affectedRows = preparedStatement.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Creating staff failed, no rows affected.");
            }
            try (ResultSet generatedKeys = preparedStatement.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    staff.setStaffId(generatedKeys.getInt(1));
                } else {
                    throw new SQLException("Creating user failed, no ID obtained.");
                }
            }
            return staff;
        }
    }

    @Override
    public boolean updateStaffInTransaction(Connection connection, UserDTO userDTO) throws SQLException {
        String sql = "UPDATE staff SET full_name = ?, phone = ?, dob = ?, address = ? WHERE user_id = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setString(1, userDTO.getFullName());
            preparedStatement.setString(2, userDTO.getPhone());
            preparedStatement.setDate(3, java.sql.Date.valueOf(userDTO.getDob()));
            preparedStatement.setString(4, userDTO.getAddress());
            preparedStatement.setInt(5, userDTO.getUserId());
            int affectedRow = preparedStatement.executeUpdate();
            if (affectedRow == 0) {
                throw new SQLException("Updating user failed, no rows affected.");
            }
            System.out.println("✓ Updated Staff with uID: " + userDTO.getUserId());
            return true;
        }
    }
    private final String SELECT_ALL_TEACHERS_SQL =
            "SELECT \n" +
                    "    s.staff_id,\n" +
                    "    s.full_name,\n" +
                    "    r.role_name \n" +
                    "FROM staff s\n" +
                    "INNER JOIN users u ON s.user_id = u.user_id\n" +
                    "INNER JOIN roles r ON u.role_id = r.role_id\n" +
                    "WHERE r.role_name = 'Teacher'\n" +
                    "ORDER BY s.full_name;";
    @Override
    public List<TeacherInfoDTO> findAllTeachers() {
        List<TeacherInfoDTO> teacherInfoDTOList = new ArrayList<>();
        try (Connection connection = DatabaseUtil.getConnectDB()) {
            PreparedStatement ps = connection.prepareStatement(SELECT_ALL_TEACHERS_SQL);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int staffId = rs.getInt("staff_id");
                String fullName = rs.getString("full_name");
                String roleName = rs.getString("role_name");
                teacherInfoDTOList.add(new TeacherInfoDTO(staffId, fullName, roleName));
            }
        } catch (SQLException e) {
            System.out.println("lỗi lấy dữ liệu");
        }
        return teacherInfoDTOList;
    }

    @Override
    public int getTotalStaffCount() {
        String sql = "SELECT COUNT(*) FROM staff";
        try (Connection conn = DatabaseUtil.getConnectDB();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}
