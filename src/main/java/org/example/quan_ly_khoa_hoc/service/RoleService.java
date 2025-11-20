package org.example.quan_ly_khoa_hoc.service;

import org.example.quan_ly_khoa_hoc.dto.RolesDTO;
import org.example.quan_ly_khoa_hoc.entity.Role;
import org.example.quan_ly_khoa_hoc.repository.RoleRepository;
import org.example.quan_ly_khoa_hoc.repository.repositoryInterface.IRoleRepository;
import org.example.quan_ly_khoa_hoc.service.serviceInterface.IRoleService;

import java.util.List;

public class RoleService implements IRoleService {
    private IRoleRepository roleRepository = new RoleRepository();

    @Override
    public Role getRoleNameById(Integer roleId) {
        return roleRepository.getRoleNameById(roleId);
    }

    @Override
    public List<RolesDTO> getAllRoles() {
        return roleRepository.getAllRoles();
    }
}
