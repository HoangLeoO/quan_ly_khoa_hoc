package org.example.quan_ly_khoa_hoc.service.serviceInterface;

import org.example.quan_ly_khoa_hoc.dto.LessonContentRowDTO;

import java.util.List;

public interface ILessonContentService {
    List<LessonContentRowDTO> getLessonContentById(int studentId, int lessonId, int moduleId);
}
