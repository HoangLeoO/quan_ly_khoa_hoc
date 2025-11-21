package org.example.quan_ly_khoa_hoc.repository;

import org.example.quan_ly_khoa_hoc.dto.TeacherInfoDTO;
import org.example.quan_ly_khoa_hoc.dto.UserDTO;
import org.example.quan_ly_khoa_hoc.entity.Staff;
import org.example.quan_ly_khoa_hoc.repository.repositoryInterface.ITeacherRepository;
import org.example.quan_ly_khoa_hoc.util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class TeacherRepository implements ITeacherRepository {
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

    @Override
    public Staff addStaffInTransaction(Connection connection, Staff staff) throws SQLException {
        return null;
    }

    @Override
    public boolean updateStaffInTransaction(Connection connection, UserDTO userDTO) throws SQLException {
        return false;
    }

    @Override
    public List<TeacherInfoDTO> findAllTeachers() {
        return List.of();
    }
}