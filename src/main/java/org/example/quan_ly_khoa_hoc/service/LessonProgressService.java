package org.example.quan_ly_khoa_hoc.service;

import org.example.quan_ly_khoa_hoc.repository.LessonProgressRepository;
import org.example.quan_ly_khoa_hoc.repository.repositoryInterface.ILessonProgressRepository;
import org.example.quan_ly_khoa_hoc.service.serviceInterface.ILessonProgressService;

public class LessonProgressService implements ILessonProgressService {

    private ILessonProgressRepository lessonProgressRepository = new LessonProgressRepository();

    @Override
    public boolean updateIsComplete(Boolean is_completed, int student_id, int lesson_id) {
        return lessonProgressRepository.updateIsComplete(is_completed, student_id, lesson_id);
    }
}
