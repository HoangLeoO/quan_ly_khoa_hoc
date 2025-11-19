package org.example.quan_ly_khoa_hoc.service;

import org.example.quan_ly_khoa_hoc.entity.Lesson;
import org.example.quan_ly_khoa_hoc.entity.Module;
import org.example.quan_ly_khoa_hoc.repository.CourseRepository;
import org.example.quan_ly_khoa_hoc.repository.repositoryInterface.ICourseRepository;
import org.example.quan_ly_khoa_hoc.service.serviceInterface.ICourseService;

import java.util.List;

public class CourseService implements ICourseService {
    private ICourseRepository courseRepository = new CourseRepository();

    @Override
    public List<Module> findModulesByCourseId(int courseId) {
        return courseRepository.findModulesByCourseId(courseId);
    }

    @Override
    public List<Lesson> findLessonsByModuleId(int moduleId) {
        return courseRepository.findLessonsByModuleId(moduleId);
    }
}
