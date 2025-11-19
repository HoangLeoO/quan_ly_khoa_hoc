package org.example.quan_ly_khoa_hoc.service;

import org.example.quan_ly_khoa_hoc.entity.Staff;
import org.example.quan_ly_khoa_hoc.service.serviceInterface.ITeacherService;

import java.sql.Connection;
import java.sql.SQLException;

public class TeacherService implements ITeacherService {
    @Override
    public Staff addStaffInTransaction(Connection connection, Staff staff) throws SQLException {
        return null;
    }
}
