package org.example.quan_ly_khoa_hoc.repository.repositoryInterface;

import org.example.quan_ly_khoa_hoc.entity.Lesson;

import java.util.List;

public interface ILessonRepository {
    List<Lesson> findLessonsByModuleId(int moduleId);
}
