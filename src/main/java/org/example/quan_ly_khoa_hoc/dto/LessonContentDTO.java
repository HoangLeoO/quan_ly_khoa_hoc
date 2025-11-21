package org.example.quan_ly_khoa_hoc.dto;

public class LessonContentDTO {
    private Integer contentId;
    private Integer lessonId;
    private String contentType;
    private String contentName; // Added contentName
    private String contentData;

    public LessonContentDTO() {
    }

    public LessonContentDTO(Integer contentId, Integer lessonId, String contentType, String contentName, String contentData) {
        this.contentId = contentId;
        this.lessonId = lessonId;
        this.contentType = contentType;
        this.contentName = contentName;
        this.contentData = contentData;
    }

    // Getters and Setters
    public Integer getContentId() {
        return contentId;
    }

    public void setContentId(Integer contentId) {
        this.contentId = contentId;
    }

    public Integer getLessonId() {
        return lessonId;
    }

    public void setLessonId(Integer lessonId) {
        this.lessonId = lessonId;
    }

    public String getContentType() {
        return contentType;
    }

    public void setContentType(String contentType) {
        this.contentType = contentType;
    }

    public String getContentName() {
        return contentName;
    }

    public void setContentName(String contentName) {
        this.contentName = contentName;
    }

    public String getContentData() {
        return contentData;
    }

    public void setContentData(String contentData) {
        this.contentData = contentData;
    }
}
