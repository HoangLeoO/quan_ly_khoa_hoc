package org.example.quan_ly_khoa_hoc.service;

import org.example.quan_ly_khoa_hoc.dto.CourseDTO;
import org.example.quan_ly_khoa_hoc.repository.CourseRepository;
import org.example.quan_ly_khoa_hoc.repository.repositoryInterface.ICourseRepository;
import org.example.quan_ly_khoa_hoc.service.serviceInterface.ICourseService;

import java.util.List;

public class CourseService implements ICourseService {
    private final ICourseRepository courseRepository = new CourseRepository();


    @Override
    public List<CourseDTO> getAllCourse() {
        return courseRepository.getAllCourse();
    }

    @Override
    public CourseDTO addCourse(CourseDTO courseDTO) {
        return courseRepository.addCourse(courseDTO);
    }
}
