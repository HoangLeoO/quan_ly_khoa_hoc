package org.example.quan_ly_khoa_hoc.entity;

public class Lesson {
    private int lessonId;
    private int moduleId;
    private String lessonName;
    private int sortOrder;

    public Lesson() {}

    public Lesson(int moduleId, String lessonName, int sortOrder) {
        this.moduleId = moduleId;
        this.lessonName = lessonName;
        this.sortOrder = sortOrder;
    }

    public Lesson(int lessonId, String lessonName) {
        this.lessonId = lessonId;
        this.lessonName = lessonName;
    }

    // Getters and Setters
    public int getLessonId() {
        return lessonId;
    }

    public void setLessonId(int lessonId) {
        this.lessonId = lessonId;
    }

    public int getModuleId() {
        return moduleId;
    }

    public void setModuleId(int moduleId) {
        this.moduleId = moduleId;
    }

    public String getLessonName() {
        return lessonName;
    }

    public void setLessonName(String lessonName) {
        this.lessonName = lessonName;
    }

    public int getSortOrder() {
        return sortOrder;
    }

    public void setSortOrder(int sortOrder) {
        this.sortOrder = sortOrder;
    }
}