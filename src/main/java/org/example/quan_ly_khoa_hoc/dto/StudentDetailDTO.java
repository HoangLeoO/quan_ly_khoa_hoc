package org.example.quan_ly_khoa_hoc.dto;

import java.time.LocalDate;

public class StudentDetailDTO {
    private int studentId;
    private String fullName;
    private int totalSessions;
    private int presentCount;
    private int lateCount;
    private int absentCount;
    private int excusedCount;

    public StudentDetailDTO() {
    }

    public StudentDetailDTO(int studentId, String fullName, int totalSessions, int presentCount, int lateCount, int absentCount, int excusedCount) {
        this.studentId = studentId;
        this.fullName = fullName;
        this.totalSessions = totalSessions;
        this.presentCount = presentCount;
        this.lateCount = lateCount;
        this.absentCount = absentCount;
        this.excusedCount = excusedCount;
    }

    public int getStudentId() {
        return studentId;
    }

    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public int getTotalSessions() {
        return totalSessions;
    }

    public void setTotalSessions(int totalSessions) {
        this.totalSessions = totalSessions;
    }

    public int getPresentCount() {
        return presentCount;
    }

    public void setPresentCount(int presentCount) {
        this.presentCount = presentCount;
    }

    public int getLateCount() {
        return lateCount;
    }

    public void setLateCount(int lateCount) {
        this.lateCount = lateCount;
    }

    public int getAbsentCount() {
        return absentCount;
    }

    public void setAbsentCount(int absentCount) {
        this.absentCount = absentCount;
    }

    public int getExcusedCount() {
        return excusedCount;
    }

    public void setExcusedCount(int excusedCount) {
        this.excusedCount = excusedCount;
    }
}

