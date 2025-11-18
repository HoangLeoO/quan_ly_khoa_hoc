package org.example.quan_ly_khoa_hoc.repository.repositoryInterface;

import org.example.quan_ly_khoa_hoc.dto.ClassInfoDTO;

import java.util.List;

public interface IStudentRepository {
    List<ClassInfoDTO> getStudentClassesInfoById(int studentId);
}
