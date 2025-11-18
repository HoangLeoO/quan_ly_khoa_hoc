package org.example.quan_ly_khoa_hoc.entity;

public class Course {
    private int courseId;
    private String courseName;
    private String description;

    // Constructors, Getters, và Setters...
    public Course() {
    }


    public Course(String courseName, String description) {
        this.courseName = courseName;
        this.description = description;
    }

    public int getCourseId() {
        return courseId;
    }

    public void setCourseId(int courseId) {
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
}