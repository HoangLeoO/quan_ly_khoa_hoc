package org.example.quan_ly_khoa_hoc.repository;

import org.example.quan_ly_khoa_hoc.dto.UserDTO;
import org.example.quan_ly_khoa_hoc.entity.User;
import org.example.quan_ly_khoa_hoc.repository.repositoryInterface.IUserRepository;
import org.example.quan_ly_khoa_hoc.util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

public class UserRepository implements IUserRepository {
    @Override
    public List<UserDTO> getAllUser() {
        List<UserDTO> userDTOList = new ArrayList<>();

        String sql = "SELECT u.role_id,s.full_name, u.email,s.dob,u.created_at, s.position  FROM users u  " +
                "join   staff s on u.user_id = s.user_id UNION SELECT  u.role_id,s.full_name,  u.email ,s.dob,u.created_at, s.position FROM users u  " +
                "join students  s on u.user_id = s.user_id ORDER BY role_id" ;

        try (Connection connection = DatabaseUtil.getConnectDB();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);
             ResultSet resultSet = preparedStatement.executeQuery()) {
            while (resultSet.next()) {
                String fullName = resultSet.getString("full_name");
                String email = resultSet.getString("email");
                LocalDate dob = resultSet.getDate("dob").toLocalDate();
                String position = resultSet.getString("position");
                int roleId = resultSet.getInt("role_id");
                LocalDate createdAt = resultSet.getDate("created_at").toLocalDate();
                userDTOList.add(new UserDTO(fullName, email, dob,position,roleId, createdAt));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return userDTOList;
    }

    @Override
    public User addUserInTransaction(Connection connection, User user) throws SQLException {
        if (user == null) {
            throw new IllegalArgumentException("User cannot be null");
        }
        if (user.getEmail() == null || user.getEmail().trim().isEmpty()) {
            throw new IllegalArgumentException("Email cannot be empty");
        }
        if (user.getPasswordHash() == null || user.getPasswordHash().trim().isEmpty()) {
            throw new IllegalArgumentException("Password cannot be empty");
        }
        String sql = "INSERT INTO users (email, password_hash, role_id) VALUES (?, ?, ?)";
        try (PreparedStatement preparedStatement = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
            preparedStatement.setString(1, user.getEmail());
            preparedStatement.setString(2, user.getPasswordHash());
            preparedStatement.setInt(3, user.getRoleId());
            int affectedRows = preparedStatement.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Creating user failed, no rows affected.");
            }
            try(ResultSet generatedKeys = preparedStatement.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    user.setUserId(generatedKeys.getInt(1));
                } else {
                    throw new SQLException("Creating user failed, no ID obtained.");
                }
            }

            return user;
        }
    }


}
