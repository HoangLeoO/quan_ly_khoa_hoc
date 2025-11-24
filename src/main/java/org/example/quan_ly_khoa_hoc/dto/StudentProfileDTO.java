package org.example.quan_ly_khoa_hoc.dto;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public class StudentProfileDTO {
    private int studentId;
    private String fullName;
    private String phone;
    private LocalDate dob;
    private String address;
    private String email;

    public StudentProfileDTO() {
    }

    public StudentProfileDTO(String fullName, String phone, LocalDate dob, String address, String email) {
        this.fullName = fullName;
        this.phone = phone;
        this.dob = dob;
        this.address = address;
        this.email = email;
    }

    public StudentProfileDTO(int studentId, String fullName, String phone, LocalDate dob, String address, String email) {
        this.studentId = studentId;
        this.fullName = fullName;
        this.phone = phone;
        this.dob = dob;
        this.address = address;
        this.email = email;
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

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public int getStudentId() {
        return studentId;
    }

    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }

    public String getDobFormatted() {
        if (dob != null) {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
            return dob.format(formatter);
        }
        return "";
    }
}
