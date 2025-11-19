package org.example.quan_ly_khoa_hoc.dto;

import java.time.LocalDateTime;

public class ScheduleDTO {
    private int scheduleId;
    private int classId;
    private String className;
    private String lessonName;
    private LocalDateTime timeStart;
    private String room;

    public ScheduleDTO() {
    }

    public ScheduleDTO(int scheduleId, int classId, String className, String lessonName, LocalDateTime timeStart, String room) {
        this.scheduleId = scheduleId;
        this.classId = classId;
        this.className = className;
        this.lessonName = lessonName;
        this.timeStart = timeStart;
        this.room = room;
    }

    public int getScheduleId() {
        return scheduleId;
    }

    public void setScheduleId(int scheduleId) {
        this.scheduleId = scheduleId;
    }

    public int getClassId() {
        return classId;
    }

    public void setClassId(int classId) {
        this.classId = classId;
    }

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
    }

    public String getLessonName() {
        return lessonName;
    }

    public void setLessonName(String lessonName) {
        this.lessonName = lessonName;
    }

    public LocalDateTime getTimeStart() {
        return timeStart;
    }

    public void setTimeStart(LocalDateTime timeStart) {
        this.timeStart = timeStart;
    }

    public String getRoom() {
        return room;
    }

    public void setRoom(String room) {
        this.room = room;
    }
}
