package org.example.quan_ly_khoa_hoc.entity;

public class Attendance {
    private int attendanceId;
    private int scheduleId;
    private int studentId;
    private String status; // ENUM: 'present', 'absent', 'late', 'excused'
    private String note;

    public Attendance() {}

    public Attendance(int scheduleId, int studentId, String status, String note) {
        this.scheduleId = scheduleId;
        this.studentId = studentId;
        this.status = status;
        this.note = note;
    }

    public int getAttendanceId() {
        return attendanceId;
    }

    public void setAttendanceId(int attendanceId) {
        this.attendanceId = attendanceId;
    }

    public int getScheduleId() {
        return scheduleId;
    }

    public void setScheduleId(int scheduleId) {
        this.scheduleId = scheduleId;
    }

    public int getStudentId() {
        return studentId;
    }

    public void setStudentId(int studentId) {
        this.studentId = studentId;
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