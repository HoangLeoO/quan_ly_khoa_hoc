package org.example.quan_ly_khoa_hoc.repository.repositoryInterface;

import org.example.quan_ly_khoa_hoc.dto.LessonDTO;

import java.util.List;

public interface ILessonRepository {
    List<LessonDTO> findLessonsByModuleId(int moduleId);
    LessonDTO findById(int lessonId);
    List<LessonDTO> getAllByModuleIdAndStudentId(int moduleId,int studentId);
    LessonDTO save(LessonDTO lessonDTO); // Returns DTO with generated ID
    LessonDTO findByNameAndModuleId(String lessonName, int moduleId);
    void update(LessonDTO lessonDTO); // Add this
    void delete(int lessonId);
}
