package org.example.quan_ly_khoa_hoc.service.serviceInterface;

import org.example.quan_ly_khoa_hoc.dto.LessonContentDTO;

public interface ILessonContentService {
    LessonContentDTO findByLessonId(int lessonId);
    void save(LessonContentDTO lessonContentDTO); // Already added in previous steps
    void update(LessonContentDTO lessonContentDTO); // Add this
}
