package org.example.quan_ly_khoa_hoc.repository;

import org.example.quan_ly_khoa_hoc.dto.ClassDTO;
import org.example.quan_ly_khoa_hoc.entity.Course;
import org.example.quan_ly_khoa_hoc.entity.Lesson;
import org.example.quan_ly_khoa_hoc.entity.Module;
import org.example.quan_ly_khoa_hoc.repository.repositoryInterface.ICourseRepository;
import org.example.quan_ly_khoa_hoc.util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class CourseRepository implements ICourseRepository {
    private final String SELECT_ALL_COURSES = "SELECT * FROM courses";

    @Override
    public List<Course> findAll() {
        List<Course> courseList = new ArrayList<>();
        try (Connection connection = DatabaseUtil.getConnectDB()) {
                PreparedStatement ps = connection.prepareStatement(SELECT_ALL_COURSES);
                ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int courseId = rs.getInt("course_id");
                String courseName = rs.getString("course_name");
                String description = rs.getString("description");
                courseList.add(new Course(courseId,courseName,description));
            }
        } catch (SQLException e) {
            System.out.println("lỗi lấy dữ liệu");
        }
            return courseList;
        }
    }

