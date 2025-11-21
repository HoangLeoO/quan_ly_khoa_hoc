package org.example.quan_ly_khoa_hoc.repository.repositoryInterface;

import org.example.quan_ly_khoa_hoc.dto.LessonContentRowDTO;

import java.util.List;

public interface ILessonContentRepository {
    List<LessonContentRowDTO> getLessonContentById(int studentId,int lessonId,int moduleId);
}
