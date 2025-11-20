package org.example.quan_ly_khoa_hoc.repository;

import org.example.quan_ly_khoa_hoc.dto.CourseDTO;
import org.example.quan_ly_khoa_hoc.repository.repositoryInterface.ICourseRepository;
import org.example.quan_ly_khoa_hoc.util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CourseRepository implements ICourseRepository {
    @Override
    public List<CourseDTO> getAllCourse() {
        String sql = "SELECT courses.course_name, courses.description FROM courses";
        List<CourseDTO> courseDTOList = new ArrayList<>();
        try (Connection connection = DatabaseUtil.getConnectDB();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                String name = resultSet.getString("course_name");
                String description = resultSet.getString("description");
                courseDTOList.add(new CourseDTO(name, description));
            }
            return courseDTOList;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public CourseDTO addCourse(CourseDTO courseDTO) {
        String sql = "INSERT INTO courses (course_name, description) VALUES (?, ?)";
        try (Connection connection = DatabaseUtil.getConnectDB();
             PreparedStatement preparedStatement = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
            preparedStatement.setString(1, courseDTO.getCourseName());
            preparedStatement.setString(2, courseDTO.getDescription());
            int affectedRows = preparedStatement.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Creating user failed, no rows affected.");
            }
            try (ResultSet generatedKeys = preparedStatement.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    courseDTO.setCourseId(generatedKeys.getInt(1));
                } else {
                    throw new SQLException("Creating user failed, no ID obtained.");
                }
            }
            return courseDTO;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
