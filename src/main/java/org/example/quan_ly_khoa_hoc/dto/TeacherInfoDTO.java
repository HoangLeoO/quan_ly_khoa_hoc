package org.example.quan_ly_khoa_hoc.dto;

import java.time.LocalDate; // CẦN IMPORT CHO DOB

public class TeacherInfoDTO {
    private int staffId;
    private int userId;
    private String fullName;
    private String email;
    private String phone;
    private LocalDate dob;
    private String position;
    private String address;
    private String roleName;

    public TeacherInfoDTO() {
    }
    public TeacherInfoDTO(int staffId, int userId, String fullName, String email, String phone, LocalDate dob, String position, String address) {
        this.staffId = staffId;
        this.userId = userId;
        this.fullName = fullName;
        this.email = email;
        this.phone = phone;
        this.dob = dob;
        this.position = position;
        this.address = address;
    }
    public TeacherInfoDTO(int staffId, String fullName, String roleName) {
        this.staffId = staffId;
        this.fullName = fullName;
        this.roleName = roleName;
    }

    // Getters and Setters hiện có (Giữ nguyên)
    public int getStaffId() {
        return staffId;
    }

    public void setStaffId(int staffId) {
        this.staffId = staffId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
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

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    // GETTERS VÀ SETTERS MỚI CHO CÁC TRƯỜNG THIẾU
    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public LocalDate getDob() {
        return dob;
    }

    public void setDob(LocalDate dob) {
        this.dob = dob;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }
}