package org.example.quan_ly_khoa_hoc.dto;

import java.time.LocalDate;

public class TeacherClassDTO {
    int classId;
    String className;       // từ classes.class_name
    String courseName;      // join courses.course_name
    LocalDate startDate;
    LocalDate endDate;
    int totalStudents;
//    String status;

    public TeacherClassDTO() {
    }

    public TeacherClassDTO(int classId, String className, String courseName, LocalDate startDate, LocalDate endDate, int totalStudents) {
        this.classId = classId;
        this.className = className;
        this.courseName = courseName;
        this.startDate = startDate;
        this.endDate = endDate;
        this.totalStudents = totalStudents;
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

    public int getTotalStudents() {
        return totalStudents;
    }

    public void setTotalStudents(int totalStudents) {
        this.totalStudents = totalStudents;
    }
}
