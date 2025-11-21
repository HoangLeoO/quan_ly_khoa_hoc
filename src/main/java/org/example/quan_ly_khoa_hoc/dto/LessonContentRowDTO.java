package org.example.quan_ly_khoa_hoc.dto;

import java.sql.Timestamp;

public class LessonContentRowDTO {

    // 1. Trường từ bảng lessons (l)
    private int lessonId;
    private String lessonName;

    // 2. Trường từ bảng modules (m)
    private int moduleId;
    private String moduleName;

    // 3. Trường từ bảng lesson_contents (lc)
    private int contentId;
    private String contentType;
    private String contentData;

    // 4. Trường từ bảng lesson_progress (lp)
    private boolean studentLessonCompleted; // Alias là is_completed
    private Timestamp completedAt;


    // Constructor Mặc định
    public LessonContentRowDTO() {
    }

    // Constructor Đầy đủ Tham số
    public LessonContentRowDTO(int lessonId, String lessonName, int moduleId, String moduleName,
                               int contentId, String contentType, String contentData,
                               boolean studentLessonCompleted, Timestamp completedAt) {
        this.lessonId = lessonId;
        this.lessonName = lessonName;
        this.moduleId = moduleId;
        this.moduleName = moduleName;
        this.contentId = contentId;
        this.contentType = contentType;
        this.contentData = contentData;
        this.studentLessonCompleted = studentLessonCompleted;
        this.completedAt = completedAt;
    }

    // Getters

    public int getLessonId() {
        return lessonId;
    }

    public String getLessonName() {
        return lessonName;
    }

    public int getModuleId() {
        return moduleId;
    }

    public String getModuleName() {
        return moduleName;
    }

    public int getContentId() {
        return contentId;
    }

    public String getContentType() {
        return contentType;
    }

    public String getContentData() {
        return contentData;
    }

    public boolean isStudentLessonCompleted() {
        return studentLessonCompleted;
    }

    public Timestamp getCompletedAt() {
        return completedAt;
    }


    // Setters

    public void setLessonId(int lessonId) {
        this.lessonId = lessonId;
    }

    public void setLessonName(String lessonName) {
        this.lessonName = lessonName;
    }

    public void setModuleId(int moduleId) {
        this.moduleId = moduleId;
    }

    public void setModuleName(String moduleName) {
        this.moduleName = moduleName;
    }

    public void setContentId(int contentId) {
        this.contentId = contentId;
    }

    public void setContentType(String contentType) {
        this.contentType = contentType;
    }

    public void setContentData(String contentData) {
        this.contentData = contentData;
    }

    public void setStudentLessonCompleted(boolean studentLessonCompleted) {
        this.studentLessonCompleted = studentLessonCompleted;
    }

    public void setCompletedAt(Timestamp completedAt) {
        this.completedAt = completedAt;
    }

    // Tùy chọn: toString()
    @Override
    public String toString() {
        return "LessonContentRowDTO{" +
                "lessonId=" + lessonId +
                ", lessonName='" + lessonName + '\'' +
                ", moduleId=" + moduleId +
                ", moduleName='" + moduleName + '\'' +
                ", contentId=" + contentId +
                ", contentType='" + contentType + '\'' +
                ", studentLessonCompleted=" + studentLessonCompleted +
                '}';
    }
}