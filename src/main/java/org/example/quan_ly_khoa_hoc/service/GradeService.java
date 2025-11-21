package org.example.quan_ly_khoa_hoc.service;

import org.example.quan_ly_khoa_hoc.dto.GradeDetailDTO;
import org.example.quan_ly_khoa_hoc.repository.GradeRepository;
import org.example.quan_ly_khoa_hoc.repository.repositoryInterface.IGradeRepository;
import org.example.quan_ly_khoa_hoc.service.serviceInterface.IGradeService;

import java.util.List;

public class GradeService implements IGradeService {
    private IGradeRepository gradeRepository = new GradeRepository();

    @Override
    public List<GradeDetailDTO> findStudentGradesByCourseAndStudentId(int studentId, int courseId) {
        return gradeRepository.findStudentGradesByCourseAndStudentId(studentId,courseId);
    }
}
