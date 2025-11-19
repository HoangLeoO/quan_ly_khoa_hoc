package org.example.quan_ly_khoa_hoc.service.serviceInterface;

import org.example.quan_ly_khoa_hoc.entity.Lesson;

import java.util.List;

public interface ILessonService {
    List<Lesson> findLessonsByModuleId(int moduleId);
}
