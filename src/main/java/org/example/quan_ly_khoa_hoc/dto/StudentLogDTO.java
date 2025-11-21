package org.example.quan_ly_khoa_hoc.dto;

import java.sql.Timestamp;

public class StudentLogDTO {
    private int logId;
    private int studentId;
    private String studentName; // Tên học sinh được ghi log
    private int authorStaffId;
    private String authorStaffName; // Tên Staff viết log
    private String content;
    private Timestamp createdAt;

    public StudentLogDTO() {
    }

    public StudentLogDTO(int logId, int studentId, String studentName, int authorStaffId, String authorStaffName, String content, Timestamp createdAt) {
        this.logId = logId;
        this.studentId = studentId;
        this.studentName = studentName;
        this.authorStaffId = authorStaffId;
        this.authorStaffName = authorStaffName;
        this.content = content;
        this.createdAt = createdAt;
    }

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

    public String getStudentName() {
        return studentName;
    }

    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }

    public int getAuthorStaffId() {
        return authorStaffId;
    }

    public void setAuthorStaffId(int authorStaffId) {
        this.authorStaffId = authorStaffId;
    }

    public String getAuthorStaffName() {
        return authorStaffName;
    }

    public void setAuthorStaffName(String authorStaffName) {
        this.authorStaffName = authorStaffName;
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
