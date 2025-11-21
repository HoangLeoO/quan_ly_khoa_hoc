package org.example.quan_ly_khoa_hoc.repository.repositoryInterface;

import org.example.quan_ly_khoa_hoc.dto.LessonContentDTO;

import org.example.quan_ly_khoa_hoc.dto.LessonContentRowDTO;

import java.util.List;

public interface ILessonContentRepository {
    LessonContentDTO findByLessonId(int lessonId);
    void save(LessonContentDTO lessonContentDTO);
    void update(LessonContentDTO lessonContentDTO); // Add this
    List<LessonContentRowDTO> getLessonContentById(int studentId,int lessonId,int moduleId);
}
