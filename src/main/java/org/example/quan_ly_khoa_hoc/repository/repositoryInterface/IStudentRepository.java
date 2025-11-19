package org.example.quan_ly_khoa_hoc.repository.repositoryInterface;

import org.example.quan_ly_khoa_hoc.dto.ClassInfoDTO;

import java.util.List;


import org.example.quan_ly_khoa_hoc.dto.StudentProfileDTO;
import org.example.quan_ly_khoa_hoc.entity.Student;
import org.example.quan_ly_khoa_hoc.entity.User;

import java.sql.Connection;
import java.sql.SQLException;


public interface IStudentRepository {
    List<ClassInfoDTO> getStudentClassesInfoById(int studentId);
    Student addStudentInTransaction(Connection connection, Student student) throws SQLException;

    Integer getStudentIdByEmail(String email);

    StudentProfileDTO getStudentProfileByEmail(String email);

    boolean updateStudentInTransaction(Connection connection,UserDTO userDTO) throws SQLException;
}
