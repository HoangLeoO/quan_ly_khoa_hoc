package org.example.quan_ly_khoa_hoc.dto;

public class LessonContentDTO {
    private Integer contentId;
    private Integer lessonId;
    private String contentType; // Added contentType
    private String contentData; // Changed from contentText/videoUrl to contentData

    public LessonContentDTO() {
    }

    public LessonContentDTO(Integer contentId, Integer lessonId, String contentType, String contentData) {
        this.contentId = contentId;
        this.lessonId = lessonId;
        this.contentType = contentType;
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

    public String getContentData() {
        return contentData;
    }

    public void setContentData(String contentData) {
        this.contentData = contentData;
    }
}
