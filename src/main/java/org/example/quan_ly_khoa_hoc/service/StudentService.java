package org.example.quan_ly_khoa_hoc.service;

import org.example.quan_ly_khoa_hoc.entity.Student;
import org.example.quan_ly_khoa_hoc.repository.StudentRepository;
import org.example.quan_ly_khoa_hoc.repository.repositoryInterface.IStudentRepository;
import org.example.quan_ly_khoa_hoc.service.serviceInterface.IStudentService;

import java.sql.Connection;
import java.sql.SQLException;

public class StudentService implements IStudentService {
    private static IStudentRepository studentRepository = new StudentRepository();
    @Override
    public Student addStudentInTransaction(Connection connection, Student student) throws SQLException {
        return studentRepository.addStudentInTransaction(connection,student);
    }
}
