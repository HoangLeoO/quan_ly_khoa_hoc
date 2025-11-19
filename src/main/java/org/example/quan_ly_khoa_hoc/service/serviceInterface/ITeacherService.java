package org.example.quan_ly_khoa_hoc.service.serviceInterface;

import org.example.quan_ly_khoa_hoc.dto.TeacherInfoDTO;

public interface ITeacherService extends IStaffService{
    TeacherInfoDTO findStaffByEmail(String email);
}
