package org.example.quan_ly_khoa_hoc.dto;

public class RolesDTO {
    private Integer roleId;
    private String roleName;

    public RolesDTO(Integer roleId, String roleName) {
        this.roleId = roleId;
        this.roleName = roleName;
    }

    public RolesDTO(String roleName) {
        this.roleName = roleName;
    }

    public RolesDTO(Integer roleId) {
        this.roleId = roleId;
    }

    public Integer getRoleId() {
        return roleId;
    }

    public void setRoleId(Integer roleId) {
        this.roleId = roleId;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }
}
