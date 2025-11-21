package org.example.quan_ly_khoa_hoc.service.serviceInterface;

import org.example.quan_ly_khoa_hoc.dto.LessonContentDTO;
import org.example.quan_ly_khoa_hoc.dto.LessonDTO;

import java.util.List;

public interface ILessonService {
    List<LessonDTO> findLessonsByModuleId(int moduleId);
    LessonDTO findById(int lessonId);
    List<LessonDTO> getAllByModuleIdAndStudentId(int moduleId,int studentId);
    LessonDTO save(LessonDTO lessonDTO); // Returns DTO with generated ID
    LessonDTO findByNameAndModuleId(String lessonName, int moduleId);
    // void saveLessonWithContent(LessonDTO lessonDTO, LessonContentDTO lessonContentDTO); // Removed
    void update(LessonDTO lessonDTO); // Added
    // void updateLessonWithContent(LessonDTO lessonDTO, LessonContentDTO lessonContentDTO); // Removed
    void delete(int lessonId);
}
