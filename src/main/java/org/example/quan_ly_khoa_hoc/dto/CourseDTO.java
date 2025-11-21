package org.example.quan_ly_khoa_hoc.dto;

import java.time.LocalDate;

public class CourseDTO {
    private Integer courseId;
    private String courseName;
    private String description;
    private LocalDate createdAt;

    private Integer countModule;

    public CourseDTO() {
    }

    public CourseDTO(String courseName, String description) {
        this.courseName = courseName;
        this.description = description;
    }

    public CourseDTO(Integer courseId, String courseName, String description,Integer countModule) {
       this.countModule = countModule;
        this.courseId = courseId;
        this.courseName = courseName;
        this.description = description;
    }

    public CourseDTO(Integer courseId, String courseName, String description) {
        this.courseId = courseId;
        this.courseName = courseName;
        this.description = description;
    }

    public CourseDTO(String courseName, String description, LocalDate createdAt) {
        this.courseName = courseName;
        this.description = description;
        this.createdAt = createdAt;
    }

    public CourseDTO(Integer courseId, String courseName, String description, LocalDate createdAt) {
        this.courseId = courseId;
        this.courseName = courseName;
        this.description = description;
        this.createdAt = createdAt;
    }

    public Integer getCountModule() {
        return countModule;
    }

    public void setCountModule(Integer countModule) {
        this.countModule = countModule;
    }

    public Integer getCourseId() {
        return courseId;
    }

    public void setCourseId(Integer courseId) {
        this.courseId = courseId;
    }

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public LocalDate getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDate createdAt) {
        this.createdAt = createdAt;
    }
}
