package org.example.quan_ly_khoa_hoc.dto;

import java.time.LocalDate;

public class ClassInfoDTO {
    private int classId;
    private String className;
    private String courseName;
    private String status;
    private Integer course_id;

    public ClassInfoDTO() {

    }

    public ClassInfoDTO(int classId, String className, String courseName, String status, Integer course_id) {
        this.classId = classId;
        this.className = className;
        this.courseName = courseName;
        this.status = status;
        this.course_id = course_id;
    }

    public ClassInfoDTO(int classId, String className, String courseName, String status) {
        this.classId = classId;
        this.className = className;
        this.courseName = courseName;
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

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Integer getCourse_id() {
        return course_id;
    }

    public void setCourse_id(Integer course_id) {
        this.course_id = course_id;
    }
}