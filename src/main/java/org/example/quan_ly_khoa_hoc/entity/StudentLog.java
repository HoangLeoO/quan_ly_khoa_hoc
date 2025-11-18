package org.example.quan_ly_khoa_hoc.entity;

import java.sql.Timestamp;

public class StudentLog {
    private int logId;
    private int studentId;
    private int authorStaffId;
    private String content;
    private Timestamp createdAt;

    public StudentLog() {}

    public StudentLog(int studentId, int authorStaffId, String content, Timestamp createdAt) {
        this.studentId = studentId;
        this.authorStaffId = authorStaffId;
        this.content = content;
        this.createdAt = createdAt;
    }

    // Getters and Setters
    public int getLogId() {
        return logId;
    }

    public void setLogId(int logId) {
        this.logId = logId;
    }

    public int getStudentId() {
        return studentId;
    }

    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }

    public int getAuthorStaffId() {
        return authorStaffId;
    }

    public void setAuthorStaffId(int authorStaffId) {
        this.authorStaffId = authorStaffId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
}