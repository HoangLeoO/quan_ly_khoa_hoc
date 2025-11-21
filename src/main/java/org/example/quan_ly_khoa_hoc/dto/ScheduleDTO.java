package org.example.quan_ly_khoa_hoc.dto;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;

public class ScheduleDTO {
    private int scheduleId;
    private int classId;
    private int lessionId;
    private String className;
    private String lessonName;
    private LocalDateTime timeStart;
    private String room;
    private LocalDate studyDate;
    private String weekday;
    private LocalTime timeEnd;
    private LocalTime timeBegin;
    private int moduleId;
    private String moduleName;
    private int teacherId;
    private String teacherName;
    private boolean attendanceTaken;

    public ScheduleDTO() {
    }

    public ScheduleDTO(int scheduleId, int classId, int lessionId, String className, String lessonName, LocalDateTime timeStart, String room) {
        this.scheduleId = scheduleId;
        this.classId = classId;
        this.lessionId = lessionId;
        this.className = className;
        this.lessonName = lessonName;
        this.timeStart = timeStart;
        this.room = room;
    }

    public ScheduleDTO(int scheduleId, int classId, int lessionId, String className, String lessonName, String room, LocalDate studyDate, String weekday, LocalTime timeEnd, LocalTime timeBegin,int moduleId, String moduleName, int teacherId, String teacherName) {
        this.scheduleId = scheduleId;
        this.classId = classId;
        this.lessionId = lessionId;
        this.className = className;
        this.lessonName = lessonName;
        this.room = room;
        this.studyDate = studyDate;
        this.weekday = weekday;
        this.timeEnd = timeEnd;
        this.timeBegin = timeBegin;
        this.moduleId = moduleId;
        this.moduleName = moduleName;
        this.teacherId = teacherId;
        this.teacherName = teacherName;
    }

    public ScheduleDTO(int scheduleId, int classId, int lessionId, String className, String lessonName, LocalDateTime timeStart, String room, boolean attendanceTaken) {
        this.scheduleId = scheduleId;
        this.classId = classId;
        this.lessionId = lessionId;
        this.className = className;
        this.lessonName = lessonName;
        this.timeStart = timeStart;
        this.room = room;
        this.attendanceTaken = attendanceTaken;
    }

    public boolean isAttendanceTaken() {
        return attendanceTaken;
    }

    public void setAttendanceTaken(boolean attendanceTaken) {
        this.attendanceTaken = attendanceTaken;
    }

    public int getLessionId() {
        return lessionId;
    }

    public void setLessionId(int lessionId) {
        this.lessionId = lessionId;
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

    public LocalDate getStudyDate() {
        return studyDate;
    }

    public void setStudyDate(LocalDate studyDate) {
        this.studyDate = studyDate;
    }

    public String getWeekday() {
        return weekday;
    }

    public void setWeekday(String weekday) {
        this.weekday = weekday;
    }

    public LocalTime getTimeEnd() {
        return timeEnd;
    }

    public void setTimeEnd(LocalTime timeEnd) {
        this.timeEnd = timeEnd;
    }

    public LocalTime getTimeBegin() {
        return timeBegin;
    }

    public void setTimeBegin(LocalTime timeBegin) {
        this.timeBegin = timeBegin;
    }

    public String getModuleName() {
        return moduleName;
    }

    public void setModuleName(String moduleName) {
        this.moduleName = moduleName;
    }

    public int getTeacherId() {
        return teacherId;
    }

    public void setTeacherId(int teacherId) {
        this.teacherId = teacherId;
    }

    public String getTeacherName() {
        return teacherName;
    }

    public void setTeacherName(String teacherName) {
        this.teacherName = teacherName;
    }

    public int getModuleId() {
        return moduleId;
    }

    public void setModuleId(int moduleId) {
        this.moduleId = moduleId;
    }
}