package org.example.quan_ly_khoa_hoc.service;

import org.example.quan_ly_khoa_hoc.dto.UserDTO;
import org.example.quan_ly_khoa_hoc.entity.Staff;
import org.example.quan_ly_khoa_hoc.repository.StaffRepository;
import org.example.quan_ly_khoa_hoc.repository.repositoryInterface.IStaffRepository;
import org.example.quan_ly_khoa_hoc.service.serviceInterface.IStaffService;

import java.sql.Connection;
import java.sql.SQLException;

public class StaffService implements IStaffService {
    private static IStaffRepository staffRepository = new StaffRepository();

    @Override
    public Staff addStaffInTransaction(Connection connection, Staff staff) throws SQLException {
        return staffRepository.addStaffInTransaction(connection,staff);
    }

    @Override
    public boolean updateStaffInTransaction(Connection connection, UserDTO userDTO) throws SQLException {
        return staffRepository.updateStaffInTransaction(connection,userDTO);
    }

    @Override
    public String getStaffById(int id_staff) {
        return staffRepository.getStaffNameById(id_staff);
    }
}
