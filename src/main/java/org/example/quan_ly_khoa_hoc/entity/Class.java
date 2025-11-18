package org.example.quan_ly_khoa_hoc.entity;

import java.time.LocalDate;

public class Class { // Hoặc Class (TrainingClass)
    private int classId;
    private String className;
    private int courseId;
    private Integer teacherId; // teacher_id có thể là NULL
    private LocalDate startDate;
    private LocalDate endDate;

    public Class() {}

    public Class(String className, int courseId, Integer teacherId, LocalDate startDate, LocalDate endDate) {
        this.className = className;
        this.courseId = courseId;
        this.teacherId = teacherId;
        this.startDate = startDate;
        this.endDate = endDate;
    }

    // Getters and Setters
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

    public int getCourseId() {
        return courseId;
    }

    public void setCourseId(int courseId) {
        this.courseId = courseId;
    }

    public Integer getTeacherId() {
        return teacherId;
    }

    public void setTeacherId(Integer teacherId) {
        this.teacherId = teacherId;
    }

    public LocalDate getStartDate() {
        return startDate;
    }

    public void setStartDate(LocalDate startDate) {
        this.startDate = startDate;
    }

    public LocalDate getEndDate() {
        return endDate;
    }

    public void setEndDate(LocalDate endDate) {
        this.endDate = endDate;
    }
}