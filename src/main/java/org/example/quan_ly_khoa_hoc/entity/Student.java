package org.example.quan_ly_khoa_hoc.entity;

import java.time.LocalDate;

public class Student {
    private Integer studentId;
    private Integer userId;
    private String fullName;
    private String phone;
    private LocalDate dob; // Sử dụng LocalDate cho kiểu DATE
    private String address;

    // Constructors, Getters, và Setters...
    public Student() {}

    public Student(Integer userId, String phone, String fullName, LocalDate dob, String address) {
        this.userId = userId;
        this.phone = phone;
        this.fullName = fullName;
        this.dob = dob;
        this.address = address;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Integer getStudentId() {
        return studentId;
    }

    public void setStudentId(Integer studentId) {
        this.studentId = studentId;
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
}