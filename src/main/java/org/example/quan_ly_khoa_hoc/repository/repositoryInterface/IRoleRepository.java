package org.example.quan_ly_khoa_hoc.repository.repositoryInterface;

import org.example.quan_ly_khoa_hoc.dto.RolesDTO;
import org.example.quan_ly_khoa_hoc.entity.Role;

import java.util.List;

public interface IRoleRepository {
    Role getRoleNameById(Integer roleId);

    List<RolesDTO> getAllRoles();
}
