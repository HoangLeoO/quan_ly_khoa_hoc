package org.example.quan_ly_khoa_hoc.service;

import org.example.quan_ly_khoa_hoc.dto.TeacherInfoDTO;
import org.example.quan_ly_khoa_hoc.repository.TeacherRepository;
import org.example.quan_ly_khoa_hoc.repository.repositoryInterface.ITeacherRepository;
import org.example.quan_ly_khoa_hoc.service.serviceInterface.ITeacherService;

public class TeacherService implements ITeacherService {
    private ITeacherRepository teacherRepository= new TeacherRepository();
    @Override
    public TeacherInfoDTO findStaffByEmail(String email) {
        return teacherRepository.findStaffByEmail(email);
    }
}
