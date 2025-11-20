package org.example.quan_ly_khoa_hoc.dto;

public class LessonDTO {
    private int lessonId;
    private String lessonName;
    private Boolean status;

    public LessonDTO() {
    }

    public LessonDTO(int lessonId, String lessonName, Boolean status) {
        this.lessonId = lessonId;
        this.lessonName = lessonName;
        this.status = status;
    }

    public int getLessonId() {
        return lessonId;
    }

    public void setLessonId(int lessonId) {
        this.lessonId = lessonId;
    }

    public String getLessonName() {
        return lessonName;
    }

    public void setLessonName(String lessonName) {
        this.lessonName = lessonName;
    }

    public Boolean getStatus() {
        return status;
    }

    public void setStatus(Boolean status) {
        this.status = status;
    }
}
