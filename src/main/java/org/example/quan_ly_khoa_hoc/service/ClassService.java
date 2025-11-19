package org.example.quan_ly_khoa_hoc.service;

import org.example.quan_ly_khoa_hoc.dto.ClassDTO;
import org.example.quan_ly_khoa_hoc.dto.StudentDetailDTO;
import org.example.quan_ly_khoa_hoc.dto.TeacherClassDTO;
import org.example.quan_ly_khoa_hoc.repository.ClassRepository;
import org.example.quan_ly_khoa_hoc.repository.repositoryInterface.IClassRepository;
import org.example.quan_ly_khoa_hoc.service.serviceInterface.IClassService;

import java.util.List;

public class ClassService implements IClassService {
    private IClassRepository classRepository = new ClassRepository();
    @Override
    public List<TeacherClassDTO> findClassesByTeacherStaffId(int teacherStaffId) {
        return classRepository.findClassesByTeacherStaffId(teacherStaffId);
    }

    @Override
    public List<StudentDetailDTO> findStudentsByClassId(int classId) {
        return classRepository.findStudentsByClassId(classId);
    }

    @Override
    public List<ClassDTO> findAll() {
        return classRepository.findAll();
    }

    @Override
    public ClassDTO findByClassID(int classId) {
        return classRepository.findByClassID(classId);
    }
}
