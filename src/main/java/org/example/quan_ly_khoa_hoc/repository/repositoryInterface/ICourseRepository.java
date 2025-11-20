package org.example.quan_ly_khoa_hoc.repository.repositoryInterface;

import org.example.quan_ly_khoa_hoc.dto.CourseDTO;
import org.example.quan_ly_khoa_hoc.entity.Course;

import java.util.List;

public interface ICourseRepository {
    List<CourseDTO> getAllCourse();

    CourseDTO addCourse(CourseDTO courseDTO);

}
