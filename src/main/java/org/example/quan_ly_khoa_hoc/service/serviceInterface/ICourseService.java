package org.example.quan_ly_khoa_hoc.service.serviceInterface;

import org.example.quan_ly_khoa_hoc.dto.CourseDTO;

import java.util.List;

public interface ICourseService {
    List<CourseDTO> getAllCourse();

    CourseDTO addCourse(CourseDTO courseDTO);
}
