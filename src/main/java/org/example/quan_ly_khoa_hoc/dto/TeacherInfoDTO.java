package org.example.quan_ly_khoa_hoc.dto;

public class TeacherInfoDTO {
    private int staffId;
    private int userId;
    private String fullName;
    private String email;
    private String position;

    public TeacherInfoDTO() {
    }

    public TeacherInfoDTO(int staffId, int userId, String fullName, String email, String position) {
        this.staffId = staffId;
        this.userId = userId;
        this.fullName = fullName;
        this.email = email;
        this.position = position;
    }

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

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }
}
