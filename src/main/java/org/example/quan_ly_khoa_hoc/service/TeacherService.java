package org.example.quan_ly_khoa_hoc.service;

import org.example.quan_ly_khoa_hoc.dto.UserDTO;
import org.example.quan_ly_khoa_hoc.entity.Staff;
import org.example.quan_ly_khoa_hoc.dto.TeacherInfoDTO;
import org.example.quan_ly_khoa_hoc.entity.Staff;
import org.example.quan_ly_khoa_hoc.repository.TeacherRepository;
import org.example.quan_ly_khoa_hoc.repository.repositoryInterface.ITeacherRepository;
import org.example.quan_ly_khoa_hoc.service.serviceInterface.ITeacherService;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

public class TeacherService implements ITeacherService {

    @Override
    public Staff addStaffInTransaction(Connection connection, Staff staff) throws SQLException {
        return null;
    }

    @Override
    public boolean updateStaffInTransaction(Connection connection, UserDTO userDTO) throws SQLException {
        return false;
    }

    @Override
    public List<TeacherInfoDTO> findAllTeachers() {
        return List.of();
    }

    private ITeacherRepository teacherRepository= new TeacherRepository();
    @Override
    public TeacherInfoDTO findStaffByEmail(String email) {
        return teacherRepository.findStaffByEmail(email);
    }

    @Override
    public boolean updateStaffProfile(Staff staff) {
        return teacherRepository.updateStaffProfile(staff);
    }


}
