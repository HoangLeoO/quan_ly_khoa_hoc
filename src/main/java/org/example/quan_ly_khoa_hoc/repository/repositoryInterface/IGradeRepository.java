package org.example.quan_ly_khoa_hoc.repository.repositoryInterface;

import org.example.quan_ly_khoa_hoc.dto.GradeDetailDTO;

import java.util.List;

public interface IGradeRepository {
    List<GradeDetailDTO> findStudentGradesByCourseAndStudentId (int studentId,int courseId);
}
