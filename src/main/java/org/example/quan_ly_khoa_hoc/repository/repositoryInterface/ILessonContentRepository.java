package org.example.quan_ly_khoa_hoc.repository.repositoryInterface;

import org.example.quan_ly_khoa_hoc.dto.LessonContentDTO;

import java.util.List;

public interface ILessonContentRepository {
    List<LessonContentDTO> findByLessonId(int lessonId);
    LessonContentDTO findById(int contentId);
    LessonContentDTO save(LessonContentDTO lessonContentDTO); // Changed return type
    void update(LessonContentDTO lessonContentDTO);
    void delete(int contentId);
}
