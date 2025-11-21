package org.example.quan_ly_khoa_hoc.service;

import org.example.quan_ly_khoa_hoc.dto.LessonContentDTO;
import org.example.quan_ly_khoa_hoc.dto.LessonDTO;
import org.example.quan_ly_khoa_hoc.repository.LessonContentRepository;
import org.example.quan_ly_khoa_hoc.repository.LessonRepository;
import org.example.quan_ly_khoa_hoc.repository.repositoryInterface.ILessonRepository;
import org.example.quan_ly_khoa_hoc.repository.repositoryInterface.ILessonContentRepository;
import org.example.quan_ly_khoa_hoc.service.serviceInterface.ILessonService;

import java.util.List;

public class LessonService implements ILessonService {
    private final ILessonRepository lessonRepository = new LessonRepository();
    private final ILessonContentRepository lessonContentRepository = new LessonContentRepository();

    @Override
    public List<LessonDTO> findLessonsByModuleId(int moduleId) {
        return lessonRepository.findLessonsByModuleId(moduleId);
    }

    @Override
    public LessonDTO findById(int lessonId) {
        return lessonRepository.findById(lessonId);
    }

    @Override
    public List<LessonDTO> getAllByModuleIdAndStudentId(int moduleId, int studentId) {
        return lessonRepository.getAllByModuleIdAndStudentId(moduleId, studentId);
    }

    @Override
    public LessonDTO save(LessonDTO lessonDTO) {
        return lessonRepository.save(lessonDTO);
    }

    @Override
    public LessonDTO findByNameAndModuleId(String lessonName, int moduleId) {
        return lessonRepository.findByNameAndModuleId(lessonName, moduleId);
    }

    // Removed saveLessonWithContent
    // Removed updateLessonWithContent

    @Override
    public void update(LessonDTO lessonDTO) {
        lessonRepository.update(lessonDTO);
    }

    @Override
    public void delete(int lessonId) {
        lessonRepository.delete(lessonId);
    }
}
