package org.example.quan_ly_khoa_hoc.repository.repositoryInterface;

import org.example.quan_ly_khoa_hoc.dto.LessonContentDTO;

import java.util.List;

import org.example.quan_ly_khoa_hoc.dto.LessonContentRowDTO;

import java.util.List;

public interface ILessonContentRepository {
    List<LessonContentDTO> findByLessonId(int lessonId);
    LessonContentDTO findById(int contentId);
    LessonContentDTO save(LessonContentDTO lessonContentDTO);
    void update(LessonContentDTO lessonContentDTO);
    void delete(int contentId);
    List<LessonContentRowDTO> getLessonContentById(int studentId,int lessonId,int moduleId);
    List<LessonContentDTO> findByContentId(int contentId);
}
