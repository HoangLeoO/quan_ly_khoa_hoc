package org.example.quan_ly_khoa_hoc.entity;

import java.sql.Timestamp;

public class User {
    private Integer userId;
    private String email;
    private String passwordHash; // Dùng để lưu trữ mật khẩu đã hash
    private Integer roleId; // role_id có thể là NULL, nên dùng Integer
    private boolean isDelete;
    private Timestamp createdAt;

    // Constructors
    public User() {
    }

    public User(String email, String passwordHash, Integer roleId) {
        this.email = email;
        this.passwordHash = passwordHash;
        this.roleId = roleId;
    }

    public User(int userId, String email, String passwordHash, Integer roleId, boolean isDelete, Timestamp createdAt) {
        this.userId = userId;
        this.email = email;
        this.passwordHash = passwordHash;
        this.roleId = roleId;
        this.isDelete = isDelete;
        this.createdAt = createdAt;
    }

    // Getters and Setters
    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPasswordHash() {
        return passwordHash;
    }

    public void setPasswordHash(String passwordHash) {
        this.passwordHash = passwordHash;
    }

    public Integer getRoleId() {
        return roleId;
    }

    public void setRoleId(Integer roleId) {
        this.roleId = roleId;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public boolean isDelete() {
        return isDelete;
    }

    public void setDelete(boolean delete) {
        isDelete = delete;
    }
}