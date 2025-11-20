package org.example.quan_ly_khoa_hoc.service.serviceInterface;

import org.example.quan_ly_khoa_hoc.dto.TeacherInfoDTO;
import org.example.quan_ly_khoa_hoc.entity.Staff;
import org.example.quan_ly_khoa_hoc.entity.Student;

public interface ITeacherService extends IStaffService{
    TeacherInfoDTO findStaffByEmail(String email);
    boolean updateStaffProfile(Staff staff);
}
