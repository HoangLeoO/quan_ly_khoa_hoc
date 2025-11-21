package org.example.quan_ly_khoa_hoc.service.serviceInterface;

import org.example.quan_ly_khoa_hoc.entity.Course;
import org.example.quan_ly_khoa_hoc.entity.Lesson;
import org.example.quan_ly_khoa_hoc.entity.Module;
import org.example.quan_ly_khoa_hoc.dto.CourseDTO;

import java.util.List;

public interface ICourseService {
    List<Course> findAll();
    List<CourseDTO> getAllCourse();

    CourseDTO addCourse(CourseDTO courseDTO);

    boolean deleteCourse (Integer courseId);

    List<CourseDTO> search(String keyword);

    List<CourseDTO> findPaginated(int page, int pageSize);

    int getTotalCourseCount();

    CourseDTO findByName(String courseName);

    CourseDTO findById(int courseId);

    void update(CourseDTO course);
}
