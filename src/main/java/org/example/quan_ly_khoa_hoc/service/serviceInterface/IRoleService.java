package org.example.quan_ly_khoa_hoc.service.serviceInterface;

import org.example.quan_ly_khoa_hoc.dto.RolesDTO;
import org.example.quan_ly_khoa_hoc.entity.Role;

import java.util.List;

public interface IRoleService {
    Role getRoleNameById(Integer roleId);

    List<RolesDTO> getAllRoles();
}
