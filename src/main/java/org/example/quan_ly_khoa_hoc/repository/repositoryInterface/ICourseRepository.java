package org.example.quan_ly_khoa_hoc.repository.repositoryInterface;

import org.example.quan_ly_khoa_hoc.entity.Lesson;
import org.example.quan_ly_khoa_hoc.entity.Module;

import java.util.List;

public interface ICourseRepository {
    List<Module> findModulesByCourseId(int courseId);
    List<Lesson> findLessonsByModuleId(int moduleId);
}
