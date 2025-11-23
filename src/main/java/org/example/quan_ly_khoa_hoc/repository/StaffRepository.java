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
    private final String UPDATE_STAFF_SQL =
            "UPDATE staff SET full_name = ?, phone = ?, dob = ?, address = ? WHERE staff_id = ?";
    private final String SELECT_STAFF_BY_EMAIL =
            "SELECT s.staff_id, s.full_name, s.user_id, s.position, s.phone, s.dob, s.address, u.email " +
                    "FROM staff s JOIN users u ON s.user_id = u.user_id " +
                    "WHERE u.email = ?";
    @Override
    public TeacherInfoDTO findStaffByEmail(String email) {
        TeacherInfoDTO teacherInfoDTO = null;

        try (Connection conn = DatabaseUtil.getConnectDB();
             PreparedStatement ps = conn.prepareStatement(SELECT_STAFF_BY_EMAIL)) {

            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                teacherInfoDTO = new TeacherInfoDTO();
                teacherInfoDTO.setStaffId(rs.getInt("staff_id"));
                teacherInfoDTO.setUserId(rs.getInt("user_id"));
                teacherInfoDTO.setFullName(rs.getString("full_name"));
                teacherInfoDTO.setEmail(rs.getString("email"));
                teacherInfoDTO.setPosition(rs.getString("position"));
                teacherInfoDTO.setPhone(rs.getString("phone"));
                if (rs.getDate("dob") != null) {
                    teacherInfoDTO.setDob(rs.getDate("dob").toLocalDate());
                } else {
                    teacherInfoDTO.setDob(null);
                }

                teacherInfoDTO.setAddress(rs.getString("address"));

            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return teacherInfoDTO;
    }

    @Override
    public boolean updateStaffProfile(Staff staff) {
        boolean rowUpdated = false;
        try (Connection connection = DatabaseUtil.getConnectDB();
             PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_STAFF_SQL)) {
            preparedStatement.setString(1, staff.getFullName());
            preparedStatement.setString(2, staff.getPhone());
            if (staff.getDob() != null) {
                preparedStatement.setDate(3, java.sql.Date.valueOf(staff.getDob()));
            } else {
                preparedStatement.setNull(3, java.sql.Types.DATE);
            }
            preparedStatement.setString(4, staff.getAddress());
            preparedStatement.setInt(5, staff.getStaffId());
            rowUpdated = preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Lỗi khi cập nhật hồ sơ Staff:");
            e.printStackTrace();
        }
        return rowUpdated;
    }
}
