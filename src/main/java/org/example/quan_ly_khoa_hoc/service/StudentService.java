package org.example.quan_ly_khoa_hoc.service;

import org.example.quan_ly_khoa_hoc.dto.ClassInfoDTO;
import org.example.quan_ly_khoa_hoc.repository.StudentRepository;
import org.example.quan_ly_khoa_hoc.repository.repositoryInterface.IStudentRepository;
import org.example.quan_ly_khoa_hoc.service.serviceInterface.IStudentService;

import java.util.List;

public class StudentService implements IStudentService {

    private IStudentRepository studentRepository = new StudentRepository();

    @Override
    public List<ClassInfoDTO> getStudentClassesInfoById(int studentId) {
        return studentRepository.getStudentClassesInfoById(studentId);
    }
}
