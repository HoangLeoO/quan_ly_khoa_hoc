package org.example.quan_ly_khoa_hoc.entity;

public class Module {
    private int moduleId;
    private int courseId;
    private String moduleName;
    private int sortOrder;

    public Module() {}

    public Module(int moduleId, String moduleName) {
        this.moduleId = moduleId;
        this.moduleName = moduleName;
    }

    public Module(int courseId, String moduleName, int sortOrder) {
        this.courseId = courseId;
        this.moduleName = moduleName;
        this.sortOrder = sortOrder;
    }

    // Getters and Setters
    public int getModuleId() {
        return moduleId;
    }

    public void setModuleId(int moduleId) {
        this.moduleId = moduleId;
    }

    public int getCourseId() {
        return courseId;
    }

    public void setCourseId(int courseId) {
        this.courseId = courseId;
    }

    public String getModuleName() {
        return moduleName;
    }

    public void setModuleName(String moduleName) {
        this.moduleName = moduleName;
    }

    public int getSortOrder() {
        return sortOrder;
    }

    public void setSortOrder(int sortOrder) {
        this.sortOrder = sortOrder;
    }
}