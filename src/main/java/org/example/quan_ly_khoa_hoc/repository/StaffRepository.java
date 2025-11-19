package org.example.quan_ly_khoa_hoc.repository;

import org.example.quan_ly_khoa_hoc.dto.UserDTO;
import org.example.quan_ly_khoa_hoc.entity.Staff;
import org.example.quan_ly_khoa_hoc.repository.repositoryInterface.IStaffRepository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

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
}
