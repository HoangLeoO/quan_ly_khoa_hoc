package org.example.quan_ly_khoa_hoc.entity;

import java.time.LocalDate;

public class Staff {
    private Integer staffId;
    private Integer userId;
    private String fullName;
    private String position;
    private String phone;
    private LocalDate dob; // Sử dụng LocalDate cho kiểu DATE
    private String address;

    public Staff() {
    }
    public Staff(Integer userId, String phone, String fullName, LocalDate dob, String address) {
        this.userId = userId;
        this.phone = phone;
        this.fullName = fullName;
        this.dob = dob;
        this.address = address;
    }
    public Staff(Integer userId, String fullName, String position) {
        this.userId = userId;
        this.fullName = fullName;
        this.position = position;
        this.phone = phone;
        this.dob = dob;
        this.address = address;
    }

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

    // Getters and Setters
    public int getStaffId() {
        return staffId;
    }

    public void setStaffId(int staffId) {
        this.staffId = staffId;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }


}