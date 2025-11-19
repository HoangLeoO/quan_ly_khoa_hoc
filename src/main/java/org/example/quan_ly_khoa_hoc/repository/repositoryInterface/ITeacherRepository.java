package org.example.quan_ly_khoa_hoc.repository.repositoryInterface;

import org.example.quan_ly_khoa_hoc.dto.TeacherClassDTO;

import java.util.List;

public interface ITeacherRepository extends IStaffRepository{
    List<TeacherClassDTO> getAll();
}
