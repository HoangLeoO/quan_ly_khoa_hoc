package org.example.quan_ly_khoa_hoc.entity;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class Grade {
    private int studentId;
    private int moduleId;
    private BigDecimal score; // Dùng BigDecimal cho DECIMAL(5,2)
    private String note;
    private Timestamp lastUpdated;

    public Grade() {}

    public Grade(int moduleId, BigDecimal score, String note, Timestamp lastUpdated, int studentId) {
        this.moduleId = moduleId;
        this.score = score;
        this.note = note;
        this.lastUpdated = lastUpdated;
        this.studentId = studentId;
    }

    // Getters and Setters
    public int getStudentId() {
        return studentId;
    }

    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }

    public int getModuleId() {
        return moduleId;
    }

    public void setModuleId(int moduleId) {
        this.moduleId = moduleId;
    }

    public BigDecimal getScore() {
        return score;
    }

    public void setScore(BigDecimal score) {
        this.score = score;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public Timestamp getLastUpdated() {
        return lastUpdated;
    }

    public void setLastUpdated(Timestamp lastUpdated) {
        this.lastUpdated = lastUpdated;
    }
}