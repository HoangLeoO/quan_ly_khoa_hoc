package org.example.quan_ly_khoa_hoc.dto;

public class GradeDetailDTO {

    // Thông tin Học sinh
    private String fullName;

    // Thông tin Khóa học
    private int courseId;
    private String courseName;

    // Thông tin Module
    private int moduleId;
    private String moduleName;

    // Điểm số
    private double theoryScore;
    private double practiceScore;
    private double averageScore; // diem_trung_binh

    /** Constructors **/

    public GradeDetailDTO() {
    }

    public GradeDetailDTO(String fullName, int courseId, String courseName, int moduleId, String moduleName, double theoryScore, double practiceScore, double averageScore) {
        this.fullName = fullName;
        this.courseId = courseId;
        this.courseName = courseName;
        this.moduleId = moduleId;
        this.moduleName = moduleName;
        this.theoryScore = theoryScore;
        this.practiceScore = practiceScore;
        this.averageScore = averageScore;
    }

    /** Getters and Setters **/

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
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

    public int getModuleId() {
        return moduleId;
    }

    public void setModuleId(int moduleId) {
        this.moduleId = moduleId;
    }

    public String getModuleName() {
        return moduleName;
    }

    public void setModuleName(String moduleName) {
        this.moduleName = moduleName;
    }

    public double getTheoryScore() {
        return theoryScore;
    }

    public void setTheoryScore(double theoryScore) {
        this.theoryScore = theoryScore;
    }

    public double getPracticeScore() {
        return practiceScore;
    }

    public void setPracticeScore(double practiceScore) {
        this.practiceScore = practiceScore;
    }

    public double getAverageScore() {
        return averageScore;
    }

    public void setAverageScore(double averageScore) {
        this.averageScore = averageScore;
    }

}