package org.example.quan_ly_khoa_hoc.entity;

import java.time.LocalDate;

public class Student {
    private int studentId;
    private int userId;
    private String fullName;
    private String phone;
    private LocalDate dob; // Sử dụng LocalDate cho kiểu DATE

    // Constructors, Getters, và Setters...
    public Student() {}

    public Student(int userId, String phone, String fullName, LocalDate dob) {
        this.userId = userId;
        this.phone = phone;
        this.fullName = fullName;
        this.dob = dob;
    }

    public int getStudentId() {
        return studentId;
    }

    public void setStudentId(int studentId) {
        this.studentId = studentId;
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