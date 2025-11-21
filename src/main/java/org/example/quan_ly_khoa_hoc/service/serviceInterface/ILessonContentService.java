package org.example.quan_ly_khoa_hoc.service.serviceInterface;

import org.example.quan_ly_khoa_hoc.dto.LessonContentRowDTO;

import java.util.List;

import org.example.quan_ly_khoa_hoc.dto.LessonContentDTO;

import java.util.List;

public interface ILessonContentService {
    List<LessonContentDTO> findByLessonId(int lessonId);
    LessonContentDTO findById(int contentId);
    LessonContentDTO save(LessonContentDTO lessonContentDTO);
    void update(LessonContentDTO lessonContentDTO);
    void delete(int contentId);
    // No changes needed here, as contentName is part of LessonContentDTO
    List<LessonContentRowDTO> getLessonContentById(int studentId, int lessonId, int moduleId);

}
