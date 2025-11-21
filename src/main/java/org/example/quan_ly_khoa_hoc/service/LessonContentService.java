package org.example.quan_ly_khoa_hoc.service;

import org.example.quan_ly_khoa_hoc.dto.LessonContentDTO;
import org.example.quan_ly_khoa_hoc.dto.LessonContentRowDTO;
import org.example.quan_ly_khoa_hoc.repository.LessonContentRepository;
import org.example.quan_ly_khoa_hoc.repository.repositoryInterface.ILessonContentRepository;
import org.example.quan_ly_khoa_hoc.service.serviceInterface.ILessonContentService;

import java.util.List;

public class LessonContentService implements ILessonContentService {
    private ILessonContentRepository lessonContentRepository = new LessonContentRepository();

    @Override
    public List<LessonContentRowDTO> getLessonContentById(int studentId, int lessonId, int moduleId) {
        return lessonContentRepository.getLessonContentById(studentId,lessonId,moduleId);
    }
;

    @Override
    public LessonContentDTO findByLessonId(int lessonId) {
        return lessonContentRepository.findByLessonId(lessonId);
    }

    @Override
    public void save(LessonContentDTO lessonContentDTO) {
        lessonContentRepository.save(lessonContentDTO);
    }

    @Override
    public void update(LessonContentDTO lessonContentDTO) {
        lessonContentRepository.update(lessonContentDTO);
    }
}
