package org.example.quan_ly_khoa_hoc.service.serviceInterface;

import org.example.quan_ly_khoa_hoc.entity.Student;

import java.sql.Connection;
import java.sql.SQLException;

public interface IStudentService {
    Student addStudentInTransaction(Connection connection, Student student) throws SQLException;
}
