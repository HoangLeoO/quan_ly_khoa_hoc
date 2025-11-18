package org.example.quan_ly_khoa_hoc.entity;

public class LessonContent {
    private int contentId;
    private int lessonId;
    private String contentType; // ENUM: 'text', 'video', 'quiz', 'markdown'
    private String contentData;

    public LessonContent() {}

    public LessonContent(int lessonId, String contentType, String contentData) {
        this.lessonId = lessonId;
        this.contentType = contentType;
        this.contentData = contentData;
    }

    // Getters and Setters
    public int getContentId() {
        return contentId;
    }

    public void setContentId(int contentId) {
        this.contentId = contentId;
    }

    public int getLessonId() {
        return lessonId;
    }

    public void setLessonId(int lessonId) {
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