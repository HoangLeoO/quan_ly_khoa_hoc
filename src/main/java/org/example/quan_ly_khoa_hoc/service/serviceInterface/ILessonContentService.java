package org.example.quan_ly_khoa_hoc.service.serviceInterface;

import org.example.quan_ly_khoa_hoc.dto.LessonContentRowDTO;

import java.util.List;

import org.example.quan_ly_khoa_hoc.dto.LessonContentDTO;

public interface ILessonContentService {
    List<LessonContentRowDTO> getLessonContentById(int studentId, int lessonId, int moduleId);
    LessonContentDTO findByLessonId(int lessonId);
    void save(LessonContentDTO lessonContentDTO); // Already added in previous steps
    void update(LessonContentDTO lessonContentDTO); // Add this
}
