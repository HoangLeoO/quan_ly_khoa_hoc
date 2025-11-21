package org.example.quan_ly_khoa_hoc.repository.repositoryInterface;

import org.example.quan_ly_khoa_hoc.dto.LessonContentDTO;

public interface ILessonContentRepository {
    LessonContentDTO findByLessonId(int lessonId);
    void save(LessonContentDTO lessonContentDTO);
    void update(LessonContentDTO lessonContentDTO); // Add this
}
