package org.example.quan_ly_khoa_hoc.entity;

import java.sql.Timestamp;

public class LessonProgress {
    private int studentId;
    private int lessonId;
    private boolean isCompleted;
    private Timestamp completedAt;

    public LessonProgress() {}

    public LessonProgress(int studentId, int lessonId, boolean isCompleted, Timestamp completedAt) {
        this.studentId = studentId;
        this.lessonId = lessonId;
        this.isCompleted = isCompleted;
        this.completedAt = completedAt;
    }

    // Getters and Setters
    public int getStudentId() {
        return studentId;
    }

    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }

    public int getLessonId() {
        return lessonId;
    }

    public void setLessonId(int lessonId) {
        this.lessonId = lessonId;
    }

    public boolean isCompleted() {
        return isCompleted;
    }

    public void setCompleted(boolean completed) {
        isCompleted = completed;
    }

    public Timestamp getCompletedAt() {
        return completedAt;
    }

    public void setCompletedAt(Timestamp completedAt) {
        this.completedAt = completedAt;
    }
}