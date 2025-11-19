package org.example.quan_ly_khoa_hoc.service.serviceInterface;

import org.example.quan_ly_khoa_hoc.entity.Staff;

import java.sql.Connection;
import java.sql.SQLException;

public interface IStaffService {
    Staff addStaffInTransaction(Connection connection, Staff staff) throws SQLException;
}
