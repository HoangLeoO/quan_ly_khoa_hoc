package org.example.quan_ly_khoa_hoc.dto;

import java.time.LocalDate;

public class ClassDTO {
    private int classId;
    private String className;
    private String courseName;
    private String teacherName; // teacher_id có thể là NULL
    private int countStudent;
    private LocalDate startDate;
    private LocalDate endDate;
    private String status;

    public ClassDTO() {
    }

    public ClassDTO(int classId, String className, String courseName, String teacherName, int countStudent, LocalDate startDate, LocalDate endDate, String status) {
        this.classId = classId;
        this.className = className;
        this.courseName = courseName;
        this.teacherName = teacherName;
        this.countStudent = countStudent;
        this.startDate = startDate;
        this.endDate = endDate;
        this.status = status;
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

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    public String getTeacherName() {
        return teacherName;
    }

    public void setTeacherName(String teacherName) {
        this.teacherName = teacherName;
    }

    public int getCountStudent() {
        return countStudent;
    }

    public void setCountStudent(int countStudent) {
        this.countStudent = countStudent;
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

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}