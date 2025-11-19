package org.example.quan_ly_khoa_hoc.repository;

import org.example.quan_ly_khoa_hoc.dto.TeacherClassDTO;
import org.example.quan_ly_khoa_hoc.dto.TeacherInfoDTO;
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
    private final String SELECT_STAFF_BY_EMAIL =
            "SELECT s.staff_id, s.full_name, u.email " +
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

            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return teacherInfoDTO;
    }

    @Override
    public Staff addStaffInTransaction(Connection connection, Staff staff) throws SQLException {
        return null;
    }
}
