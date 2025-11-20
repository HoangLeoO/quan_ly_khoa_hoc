package org.example.quan_ly_khoa_hoc.service.serviceInterface;

import org.example.quan_ly_khoa_hoc.dto.ClassInfoDTO;

import java.util.List;

import org.example.quan_ly_khoa_hoc.dto.UserDTO;
import org.example.quan_ly_khoa_hoc.dto.StudentProfileDTO;
import org.example.quan_ly_khoa_hoc.entity.Student;

import java.sql.Connection;
import java.sql.SQLException;

public interface IStudentService {
    Student addStudentInTransaction(Connection connection, Student student) throws SQLException;

    boolean updateStudentInTransaction(Connection connection, UserDTO userDTO) throws SQLException;
    List<ClassInfoDTO> getStudentClassesInfoById(int studentId);

    Integer getStudentIdByEmail(String email);
    StudentProfileDTO getStudentProfileByEmail(String email);
    List<StudentProfileDTO> findByClassId(int classId);
    boolean updateProfileStudent(Student student);

    String getHashedPasswordByEmail(String email);
    Boolean updatePassword(String userEmail,String newHashedPassword);
}
