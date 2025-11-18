package org.example.quan_ly_khoa_hoc.repository;

import org.example.quan_ly_khoa_hoc.entity.Student;
import org.example.quan_ly_khoa_hoc.entity.User;
import org.example.quan_ly_khoa_hoc.repository.repositoryInterface.IStudentRepository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class StudentRepository implements IStudentRepository {
    @Override
    public Student addStudentInTransaction(Connection connection, Student student) throws SQLException {
        if (student == null || student.getUserId() == null) {
            throw new IllegalArgumentException("Student and user_id cannot be null");
        }
        if (student.getFullName() == null || student.getFullName().trim().isEmpty()) {
            throw new IllegalArgumentException("Full name cannot be empty");
        }
        String sql = "INSERT INTO students (user_id, full_name,phone,dob,address) VALUES (?, ?, ?,?,?)";
        try (PreparedStatement preparedStatement = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
           preparedStatement.setInt(1, student.getUserId());
           preparedStatement.setString(2, student.getFullName());
           preparedStatement.setString(3,student.getPhone());
           preparedStatement.setDate(4, java.sql.Date.valueOf(student.getDob()));
           preparedStatement.setString(5,student.getAddress());
           int affectedRows = preparedStatement.executeUpdate();

            if (affectedRows == 0) {
                throw new SQLException("Creating user failed, no rows affected.");
            }
            try(ResultSet generatedKeys = preparedStatement.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    student.setStudentId(generatedKeys.getInt(1));
                    System.out.println("✓ Created Student with ID: " + generatedKeys.getInt(1) + " for User ID: " + student.getUserId());
                } else {
                    throw new SQLException("Creating student failed, no ID obtained.");
                }
            }
            return student;
        }
    }
}
