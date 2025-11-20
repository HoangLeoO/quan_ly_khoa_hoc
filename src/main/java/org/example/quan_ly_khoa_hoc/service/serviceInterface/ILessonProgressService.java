package org.example.quan_ly_khoa_hoc.service.serviceInterface;

public interface ILessonProgressService {
    boolean updateIsComplete(Boolean is_completed, int student_id, int lesson_id);
}
