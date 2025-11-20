package org.example.quan_ly_khoa_hoc.dto;

import java.sql.Timestamp;

public class ClassLogDTO {
    private int logId;
    private int classId;
    private int authorStaffId;
    private String authorStaffName;
    private String content;
    private Timestamp createdAt;

    public ClassLogDTO() {
    }

    public ClassLogDTO(int logId, int classId, int authorStaffId, String authorStaffName, String content, Timestamp createdAt) {
        this.logId = logId;
        this.classId = classId;
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

    public int getClassId() {
        return classId;
    }

    public void setClassId(int classId) {
        this.classId = classId;
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
