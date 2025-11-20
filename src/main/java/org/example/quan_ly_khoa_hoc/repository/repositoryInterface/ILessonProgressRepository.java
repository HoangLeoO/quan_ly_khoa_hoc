package org.example.quan_ly_khoa_hoc.repository.repositoryInterface;

import java.sql.SQLException;

public interface ILessonProgressRepository {
    boolean  updateIsComplete(Boolean is_completed,int student_id,int lesson_id) ;
}
