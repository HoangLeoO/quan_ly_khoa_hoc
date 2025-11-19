package org.example.quan_ly_khoa_hoc.service;

import org.example.quan_ly_khoa_hoc.entity.Lesson;
import org.example.quan_ly_khoa_hoc.repository.LessonRepository;
import org.example.quan_ly_khoa_hoc.repository.repositoryInterface.ILessonRepository;
import org.example.quan_ly_khoa_hoc.service.serviceInterface.ILessonService;

import java.util.List;

public class LessonService implements ILessonService {
    private ILessonRepository lessonRepository= new LessonRepository();
    @Override
    public List<Lesson> findLessonsByModuleId(int moduleId) {
        return lessonRepository.findLessonsByModuleId(moduleId);
    }
}
