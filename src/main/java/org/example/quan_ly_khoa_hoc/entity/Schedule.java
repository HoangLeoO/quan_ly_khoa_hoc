package org.example.quan_ly_khoa_hoc.entity;

import java.sql.Timestamp; // Sử dụng Timestamp cho DATETIME

public class Schedule {
    private int scheduleId;
    private int classId;
    private Integer lessonId; // lesson_id có thể là NULL
    private Timestamp timeStart;
    private Timestamp timeEnd;
    private String room;

    public Schedule() {}

    public Schedule(int scheduleId, int classId, Integer lessonId, String room) {
        this.scheduleId = scheduleId;
        this.classId = classId;
        this.lessonId = lessonId;
        this.room = room;
    }

    public Schedule(int scheduleId, int classId, Integer lessonId, Timestamp timeStart, Timestamp timeEnd, String room) {
        this.scheduleId = scheduleId;
        this.classId = classId;
        this.lessonId = lessonId;
        this.timeStart = timeStart;
        this.timeEnd = timeEnd;
        this.room = room;
    }

    // Getters and Setters
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

    public Integer getLessonId() {
        return lessonId;
    }

    public void setLessonId(Integer lessonId) {
        this.lessonId = lessonId;
    }

    public Timestamp getTimeStart() {
        return timeStart;
    }

    public void setTimeStart(Timestamp timeStart) {
        this.timeStart = timeStart;
    }

    public Timestamp getTimeEnd() {
        return timeEnd;
    }

    public void setTimeEnd(Timestamp timeEnd) {
        this.timeEnd = timeEnd;
    }

    public String getRoom() {
        return room;
    }

    public void setRoom(String room) {
        this.room = room;
    }
}