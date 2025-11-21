package org.example.quan_ly_khoa_hoc.service;

import org.example.quan_ly_khoa_hoc.dto.LessonContentDTO;
import org.example.quan_ly_khoa_hoc.repository.LessonContentRepository;
import org.example.quan_ly_khoa_hoc.repository.repositoryInterface.ILessonContentRepository;
import org.example.quan_ly_khoa_hoc.service.serviceInterface.ILessonContentService;

public class LessonContentService implements ILessonContentService {
    private final ILessonContentRepository lessonContentRepository = new LessonContentRepository();

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
