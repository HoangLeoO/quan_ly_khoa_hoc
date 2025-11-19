package org.example.quan_ly_khoa_hoc.repository.repositoryInterface;

import org.example.quan_ly_khoa_hoc.entity.Role;

public interface IRoleRepository {
    Role getRoleNameById(Integer roleId);
}
