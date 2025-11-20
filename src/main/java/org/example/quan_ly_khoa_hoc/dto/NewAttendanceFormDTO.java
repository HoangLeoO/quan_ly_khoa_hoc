package org.example.quan_ly_khoa_hoc.dto;

import org.example.quan_ly_khoa_hoc.entity.Attendance;

import java.time.LocalDateTime;
import java.util.List;

public class NewAttendanceFormDTO {
    // Thông tin Schedule mới
    private int classId;
    private Integer lessonId; // Có thể null
    private LocalDateTime timeStart;
    private LocalDateTime timeEnd;
    private String room;

    // Dữ liệu điểm danh
    private List<Attendance> attendanceList;

    // Constructor đầy đủ
    public NewAttendanceFormDTO(int classId, Integer lessonId, LocalDateTime timeStart, LocalDateTime timeEnd, String room, List<Attendance> attendanceList) {
        this.classId = classId;
        this.lessonId = lessonId;
        this.timeStart = timeStart;
        this.timeEnd = timeEnd;
        this.room = room;
        this.attendanceList = attendanceList;
    }

    public int getClassId() {
        return classId;
    }

    public void setClassId(int classId) {
        this.classId = classId;
    }

    public Integer getLessonId() {
        return lessonId;
    }

    public void setLessonId(Integer lessonId) {
        this.lessonId = lessonId;
    }

    public LocalDateTime getTimeStart() {
        return timeStart;
    }

    public void setTimeStart(LocalDateTime timeStart) {
        this.timeStart = timeStart;
    }

    public LocalDateTime getTimeEnd() {
        return timeEnd;
    }

    public void setTimeEnd(LocalDateTime timeEnd) {
        this.timeEnd = timeEnd;
    }

    public String getRoom() {
        return room;
    }

    public void setRoom(String room) {
        this.room = room;
    }

    public List<Attendance> getAttendanceList() {
        return attendanceList;
    }

    public void setAttendanceList(List<Attendance> attendanceList) {
        this.attendanceList = attendanceList;
    }
}
