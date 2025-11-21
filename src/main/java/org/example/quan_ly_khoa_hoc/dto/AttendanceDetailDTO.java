package org.example.quan_ly_khoa_hoc.dto;

public class AttendanceDetailDTO {
    private int attendanceId;
    private int studentId;
    private String fullName;
    private String status;
    private String note;
    public AttendanceDetailDTO() {
    }

    public AttendanceDetailDTO(int attendanceId, int studentId, String fullName, String status, String note) {
        this.attendanceId = attendanceId;
        this.studentId = studentId;
        this.fullName = fullName;
        this.status = status;
        this.note = note;
    }

    public int getAttendanceId() {
        return attendanceId;
    }

    public void setAttendanceId(int attendanceId) {
        this.attendanceId = attendanceId;
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

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }
}