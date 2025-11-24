package org.example.quan_ly_khoa_hoc.repository.repositoryInterface;

import org.example.quan_ly_khoa_hoc.dto.TeacherInfoDTO;
import org.example.quan_ly_khoa_hoc.dto.UserDTO;
import org.example.quan_ly_khoa_hoc.entity.Staff;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

public interface IStaffRepository {
    Staff addStaffInTransaction(Connection connection, Staff staff) throws SQLException;
    boolean updateStaffInTransaction(Connection connection, UserDTO userDTO) throws SQLException;
    List<TeacherInfoDTO> findAllTeachers();
    int getTotalStaffCount(); // Add this
    TeacherInfoDTO findStaffByEmail(String email);
    boolean updateStaffProfile(Staff staff);
}
