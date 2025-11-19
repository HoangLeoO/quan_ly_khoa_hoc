package org.example.quan_ly_khoa_hoc.service;

import org.example.quan_ly_khoa_hoc.dto.ClassInfoDTO;
import org.example.quan_ly_khoa_hoc.dto.StudentProfileDTO;
import org.example.quan_ly_khoa_hoc.entity.Student;
import org.example.quan_ly_khoa_hoc.repository.StudentRepository;
import org.example.quan_ly_khoa_hoc.repository.repositoryInterface.IStudentRepository;
import org.example.quan_ly_khoa_hoc.service.serviceInterface.IStudentService;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

public class StudentService implements IStudentService {
    private static IStudentRepository studentRepository = new StudentRepository();
    @Override
    public Student addStudentInTransaction(Connection connection, Student student) throws SQLException {
        return studentRepository.addStudentInTransaction(connection,student);
    }
    @Override
    public List<ClassInfoDTO> getStudentClassesInfoById(int studentId) {
        return studentRepository.getStudentClassesInfoById(studentId);
    }

    @Override
    public Integer getStudentIdByEmail(String email) {
        return studentRepository.getStudentIdByEmail(email);
    }

    @Override
    public StudentProfileDTO getStudentProfileByEmail(String email) {
        return studentRepository.getStudentProfileByEmail(email);
    }
}
