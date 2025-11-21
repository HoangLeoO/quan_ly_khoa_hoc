package org.example.quan_ly_khoa_hoc.dto;

public class LessonDTO {
    private Integer lessonId;
    private String lessonName;
    private Integer moduleId;
    private Integer sortOrder;
    private String contentType; // Added contentType
    private boolean isCompleted;

    public LessonDTO() {
    }

    public LessonDTO(Integer lessonId, String lessonName) {
        this.lessonId = lessonId;
        this.lessonName = lessonName;
    }

    public LessonDTO(Integer lessonId, String lessonName, Integer moduleId, Integer sortOrder) {
        this.lessonId = lessonId;
        this.lessonName = lessonName;
        this.moduleId = moduleId;
        this.sortOrder = sortOrder;
    }

    public LessonDTO(Integer lessonId, String lessonName, Integer moduleId, Integer sortOrder, String contentType) {
        this.lessonId = lessonId;
        this.lessonName = lessonName;
        this.moduleId = moduleId;
        this.sortOrder = sortOrder;
        this.contentType = contentType;
    }

    public LessonDTO(Integer lessonId, String lessonName, boolean isCompleted) {
        this.lessonId = lessonId;
        this.lessonName = lessonName;
        this.isCompleted = isCompleted;
    }

    // Getters and Setters
    public Integer getLessonId() {
        return lessonId;
    }

    public void setLessonId(Integer lessonId) {
        this.lessonId = lessonId;
    }

    public String getLessonName() {
        return lessonName;
    }

    public void setLessonName(String lessonName) {
        this.lessonName = lessonName;
    }

    public Integer getModuleId() {
        return moduleId;
    }

    public void setModuleId(Integer moduleId) {
        this.moduleId = moduleId;
    }

    public Integer getSortOrder() {
        return sortOrder;
    }

    public void setSortOrder(Integer sortOrder) {
        this.sortOrder = sortOrder;
    }

    public String getContentType() {
        return contentType;
    }

    public void setContentType(String contentType) {
        this.contentType = contentType;
    }

    public boolean isCompleted() {
        return isCompleted;
    }

    public void setCompleted(boolean completed) {
        isCompleted = completed;
    }
}
