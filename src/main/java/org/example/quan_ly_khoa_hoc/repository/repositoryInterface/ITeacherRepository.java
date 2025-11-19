package org.example.quan_ly_khoa_hoc.repository.repositoryInterface;

import org.example.quan_ly_khoa_hoc.dto.TeacherClassDTO;
import org.example.quan_ly_khoa_hoc.dto.TeacherInfoDTO;

import java.util.List;

public interface ITeacherRepository extends IStaffRepository{
    TeacherInfoDTO findStaffByEmail(String email);
}
