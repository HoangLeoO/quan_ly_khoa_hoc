package org.example.quan_ly_khoa_hoc.entity;

public class Staff {
    private int staffId;
    private int userId;
    private String fullName;
    private String position;

    public Staff() {}

    public Staff(int userId, String fullName, String position) {
        this.userId = userId;
        this.fullName = fullName;
        this.position = position;
    }

    // Getters and Setters
    public int getStaffId() {
        return staffId;
    }

    public void setStaffId(int staffId) {
        this.staffId = staffId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }
}