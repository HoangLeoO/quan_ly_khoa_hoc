package org.example.quan_ly_khoa_hoc.repository;

import org.example.quan_ly_khoa_hoc.dto.RolesDTO;
import org.example.quan_ly_khoa_hoc.entity.Role;
import org.example.quan_ly_khoa_hoc.repository.repositoryInterface.IRoleRepository;
import org.example.quan_ly_khoa_hoc.util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

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

    @Override
    public List<RolesDTO> getAllRoles() {
        String sql = "SELECT * FROM roles";
        try (Connection connection = DatabaseUtil.getConnectDB();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);
             ResultSet resultSet = preparedStatement.executeQuery();) {
            List<RolesDTO> rolesDTOList = new java.util.ArrayList<>();
            while (resultSet.next()) {
                Integer roleId = resultSet.getInt("role_id");
                String roleName = resultSet.getString("role_name");
                rolesDTOList.add(new RolesDTO(roleId, roleName));
            }
            return rolesDTOList;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }
}
