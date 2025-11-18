package org.example.quan_ly_khoa_hoc.service.serviceInterface;

import org.example.quan_ly_khoa_hoc.dto.ClassInfoDTO;

import java.util.List;

public interface IStudentService {
    List<ClassInfoDTO> getStudentClassesInfoById(int studentId);
}
