package org.example.quan_ly_khoa_hoc.dto;

public class ModuleDTO {
    private Integer moduleId;
    private Integer courseId;
    private String moduleName;
    private Integer sortOrder;
    private Float progressPercentage;
    private Integer completed_lessons;
    private Integer total_lessons;

    public ModuleDTO() {
    }

    public ModuleDTO(Integer moduleId, Integer courseId, String moduleName, Integer sortOrder, Float progressPercentage, Integer completed_lessons, Integer total_lessons) {
        this.moduleId = moduleId;
        this.courseId = courseId;
        this.moduleName = moduleName;
        this.sortOrder = sortOrder;
        this.progressPercentage = progressPercentage;
        this.completed_lessons = completed_lessons;
        this.total_lessons = total_lessons;
    }

    public Integer getModuleId() {
        return moduleId;
    }

    public void setModuleId(Integer moduleId) {
        this.moduleId = moduleId;
    }

    public Integer getCourseId() {
        return courseId;
    }

    public void setCourseId(Integer courseId) {
        this.courseId = courseId;
    }

    public String getModuleName() {
        return moduleName;
    }

    public void setModuleName(String moduleName) {
        this.moduleName = moduleName;
    }

    public Integer getSortOrder() {
        return sortOrder;
    }

    public void setSortOrder(Integer sortOrder) {
        this.sortOrder = sortOrder;
    }

    public Float getProgressPercentage() {
        return progressPercentage;
    }

    public void setProgressPercentage(Float progressPercentage) {
        this.progressPercentage = progressPercentage;
    }

    public Integer getCompleted_lessons() {
        return completed_lessons;
    }

    public void setCompleted_lessons(Integer completed_lessons) {
        this.completed_lessons = completed_lessons;
    }

    public Integer getTotal_lessons() {
        return total_lessons;
    }

    public void setTotal_lessons(Integer total_lessons) {
        this.total_lessons = total_lessons;
    }
}
