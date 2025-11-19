package org.example.quan_ly_khoa_hoc.repository;

import org.example.quan_ly_khoa_hoc.entity.Role;
import org.example.quan_ly_khoa_hoc.repository.repositoryInterface.IRoleRepository;
import org.example.quan_ly_khoa_hoc.util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class RoleRepository implements IRoleRepository {

    private final String SELECT_ROLE = "SELECT * FROM roles WHERE role_id = ?;";

    // Lấy tên role theo roleId
    @Override
    public Role getRoleNameById(Integer roleId) {
        Role role = null;
        if (roleId == null) {
            return null;
        }
        try (Connection c = DatabaseUtil.getConnectDB();
             PreparedStatement p = c.prepareStatement(SELECT_ROLE)) {
            p.setInt(1, roleId);
            ResultSet rs = p.executeQuery();
            if (rs.next()) {
                String role_name = rs.getString("role_name");
                role = new Role(role_name);
            }

        } catch (Exception e) {
            System.out.println("Lỗi repo role");
        }
        return role;
    }
}
