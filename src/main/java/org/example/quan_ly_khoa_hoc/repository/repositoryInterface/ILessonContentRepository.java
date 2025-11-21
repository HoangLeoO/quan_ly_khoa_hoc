package org.example.quan_ly_khoa_hoc.repository.repositoryInterface;

import org.example.quan_ly_khoa_hoc.dto.LessonContentDTO;

import java.util.List;

public interface ILessonContentRepository {
    List<LessonContentDTO> findByLessonId(int lessonId);
    LessonContentDTO findById(int contentId);
    LessonContentDTO save(LessonContentDTO lessonContentDTO);
    void update(LessonContentDTO lessonContentDTO);
    void delete(int contentId);
    // No need to explicitly add contentName to method signatures here,
    // as it's part of LessonContentDTO which is already passed.
}
