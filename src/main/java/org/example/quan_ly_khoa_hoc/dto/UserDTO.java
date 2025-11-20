package org.example.quan_ly_khoa_hoc.dto;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public class UserDTO {
    private Integer userId;
    private String fullName;
    private String email;

    private String phone;

    private String passwordHash;

    private LocalDate dob;

    private String position;
    private int roleId;
    private LocalDate createdAt;
    private String address;

    public UserDTO() {
    }

    public UserDTO(String fullName, String email, LocalDate dob, String position, int roleId, LocalDate createdAt, String passwordHash, String phone, String address) {

        this.fullName = fullName;
        this.email = email;
        this.dob = dob;
        this.position = position;
        this.roleId = roleId;
        this.createdAt = createdAt;
        this.passwordHash = passwordHash;
        this.phone = phone;
        this.address = address;
    }

    public UserDTO(Integer userId, String fullName, String email, LocalDate dob, String position, int roleId, LocalDate createdAt) {
        this.userId = userId;
        this.fullName = fullName;
        this.email = email;
        this.dob = dob;
        this.position = position;
        this.roleId = roleId;
        this.createdAt = createdAt;
    }

    public UserDTO(Integer userId, String fullName, String email, LocalDate dob, String position, int roleId, String phone, LocalDate createdAt) {
        this.phone = phone;
        this.userId = userId;
        this.fullName = fullName;
        this.email = email;
        this.dob = dob;
        this.position = position;
        this.roleId = roleId;
        this.createdAt = createdAt;
    }
    public UserDTO(Integer userId, String fullName, String email, LocalDate dob, String position, int roleId, String phone, String address, String passwordHash) {
        this.phone = phone;
        this.userId = userId;
        this.fullName = fullName;
        this.email = email;
        this.dob = dob;
        this.position = position;
        this.roleId = roleId;
        this.address = address;
        this.passwordHash = passwordHash;
    }

    public UserDTO(String fullName, String email, LocalDate dob, String position, int roleId, LocalDate createdAt) {
        this.fullName = fullName;
        this.email = email;
        this.dob = dob;
        this.position = position;
        this.roleId = roleId;
        this.createdAt = createdAt;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getPasswordHash() {
        return passwordHash;
    }

    public void setPasswordHash(String passwordHash) {
        this.passwordHash = passwordHash;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public LocalDate getDob() {
        return dob;
    }

    public void setDob(LocalDate dob) {
        this.dob = dob;
    }

    public int getRoleId() {
        return roleId;
    }

    public void setRoleId(int roleId) {
        this.roleId = roleId;
    }

    public int getRole() {
        return roleId;
    }

    public void setRole(int role) {
        this.roleId = roleId;
    }

    public LocalDate getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDate createdAt) {
        this.createdAt = createdAt;
    }

    public String getDobString() {
        if (this.dob == null) {
            return "";
        }
        // Định dạng ngày theo kiểu Việt Nam dd/MM/yyyy
        return this.dob.format(DateTimeFormatter.ofPattern("dd/MM/yyyy"));
    }

    public String getCreatedAtString() {
        if (this.createdAt == null) {
            return "";
        }
        // Định dạng ngày theo kiểu Việt Nam dd/MM/yyyy
        return this.createdAt.format(DateTimeFormatter.ofPattern("dd/MM/yyyy"));
    }


}
