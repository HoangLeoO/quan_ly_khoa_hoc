package org.example.quan_ly_khoa_hoc.service;


import org.example.quan_ly_khoa_hoc.dto.CourseDTO;
import org.example.quan_ly_khoa_hoc.repository.CourseRepository;
import org.example.quan_ly_khoa_hoc.repository.repositoryInterface.ICourseRepository;
import org.example.quan_ly_khoa_hoc.service.serviceInterface.ICourseService;

import java.util.List;

public class CourseService implements ICourseService {
    private final ICourseRepository courseRepository = new CourseRepository();
    @Override
    public List<org.example.quan_ly_khoa_hoc.entity.Course> findAll() {
        return courseRepository.findAll();
    }
    private final ICourseRepository courseRepository = new CourseRepository();


    @Override
    public List<CourseDTO> getAllCourse() {
        return courseRepository.getAllCourse();
    }

    @Override
    public CourseDTO addCourse(CourseDTO courseDTO) {
        return courseRepository.addCourse(courseDTO);
    }

    @Override
    public boolean deleteCourse(Integer courseId) {
        return courseRepository.deleteCourse(courseId);
    }

    @Override
    public List<CourseDTO> search(String keyword) {
        return courseRepository.search(keyword);
    }

    @Override
    public List<CourseDTO> findPaginated(int page, int pageSize) {
        return courseRepository.findPaginated(page, pageSize);
    }

    @Override
    public int getTotalCourseCount() {
        return courseRepository.getTotalCourseCount();
    }

    @Override
    public CourseDTO findByName(String courseName) {
        return courseRepository.findByName(courseName);
    }

    @Override
    public CourseDTO findById(int courseId) {
        return courseRepository.findById(courseId);
    }

    @Override
    public void update(CourseDTO course) {
        courseRepository.update(course);
    }
}
