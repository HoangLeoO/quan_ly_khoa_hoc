package org.example.quan_ly_khoa_hoc.repository.repositoryInterface;

import org.example.quan_ly_khoa_hoc.dto.UserDTO;
import org.example.quan_ly_khoa_hoc.entity.Student;
import org.example.quan_ly_khoa_hoc.entity.User;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

public interface IStudentRepository {
    Student addStudentInTransaction(Connection connection, Student student) throws SQLException;
}
