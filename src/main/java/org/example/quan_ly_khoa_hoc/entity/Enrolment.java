package org.example.quan_ly_khoa_hoc.entity;

import java.sql.Timestamp;

public class Enrolment {
    private int studentId;
    private int classId;
    private Timestamp enrolDate;
    private String status; // Giá trị ENUM: 'studying', 'completed', 'dropped'

    // Constructors, Getters, và Setters...
    public Enrolment() {}

    public Enrolment(int studentId, int classId, Timestamp enrolDate, String status) {
        this.studentId = studentId;
        this.classId = classId;
        this.enrolDate = enrolDate;
        this.status = status;
    }

    public int getStudentId() {
        return studentId;
    }

    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }

    public int getClassId() {
        return classId;
    }

    public void setClassId(int classId) {
        this.classId = classId;
    }

    public Timestamp getEnrolDate() {
        return enrolDate;
    }

    public void setEnrolDate(Timestamp enrolDate) {
        this.enrolDate = enrolDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}