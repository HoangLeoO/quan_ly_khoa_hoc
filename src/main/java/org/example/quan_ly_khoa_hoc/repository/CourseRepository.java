package org.example.quan_ly_khoa_hoc.repository;

import org.example.quan_ly_khoa_hoc.entity.Course;
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

    @Override
    public List<CourseDTO> getAllCourse() {
        String sql = "SELECT\n" +
                "    c.course_id,\n" +
                "    c.course_name,\n" +
                "    c.description,\n" +
                "    COUNT(m.module_id) AS countModule\n" +
                "FROM courses c\n" +
                "         LEFT JOIN modules m ON c.course_id = m.course_id\n" +
                "GROUP BY c.course_id, c.course_name, c.description;";
        List<CourseDTO> courseDTOList = new ArrayList<>();
        try (Connection connection = DatabaseUtil.getConnectDB();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                Integer countModule = resultSet.getInt("countModule");
                Integer courseId = resultSet.getInt("course_id");
                String name = resultSet.getString("course_name");
                String description = resultSet.getString("description");
                courseDTOList.add(new CourseDTO(courseId, name, description, countModule));
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

    @Override
    public boolean deleteCourse(Integer courseId) {
        String sql = "DELETE FROM courses WHERE course_id = ?";
        try (Connection connection = DatabaseUtil.getConnectDB();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setInt(1, courseId);
            int affectedRow = preparedStatement.executeUpdate();
            if (affectedRow > 0) return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        return false;
    }

    @Override
    public List<CourseDTO> search(String keyword) {
        List<CourseDTO> courseDTOList = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
                "SELECT c.course_id, c.course_name, c.description, COUNT(m.module_id) AS countModule " +
                        "FROM courses c " +
                        "LEFT JOIN modules m ON c.course_id = m.course_id " +
                        "WHERE 1=1 "
        );

// 1. Xử lý điều kiện tìm kiếm (WHERE)
        if (keyword != null && !keyword.isEmpty()) {
            // Lưu ý: dùng c.course_name để rõ nghĩa (c là alias của courses)
            sql.append(" AND (c.course_name LIKE ? OR c.description LIKE ?) ");
        }

// 2. QUAN TRỌNG: GROUP BY phải nằm sau WHERE
        sql.append(" GROUP BY c.course_id, c.course_name, c.description ");

// 3. Thực thi truy vấn
        try (Connection connection = DatabaseUtil.getConnectDB();
             PreparedStatement preparedStatement = connection.prepareStatement(sql.toString())) {

            int index = 1;

            if (keyword != null && !keyword.isEmpty()) {
                preparedStatement.setString(index++, "%" + keyword + "%");
                preparedStatement.setString(index++, "%" + keyword + "%");
            }

            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                // Map dữ liệu vào object
                CourseDTO courseDTO = new CourseDTO();
                courseDTO.setCourseId(resultSet.getInt("course_id"));
                courseDTO.setCourseName(resultSet.getString("course_name"));
                courseDTO.setDescription(resultSet.getString("description"));
                // Lấy số lượng module (nhớ thêm thuộc tính này vào class Course như đã bàn ở trên)
                courseDTO.setCountModule(resultSet.getInt("countModule"));

                courseDTOList.add(courseDTO);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return courseDTOList;
    }


    @Override
    public List<CourseDTO> findPaginated(int page, int pageSize) {
        List<CourseDTO> courseDTOList = new ArrayList<>();

        // 1. Sửa SQL: Thêm LEFT JOIN, COUNT và GROUP BY
        // Lưu ý: LIMIT và OFFSET phải luôn nằm cuối cùng
        String sql = "SELECT c.course_id, c.course_name, c.description, COUNT(m.module_id) AS module_count " +
                "FROM courses c " +
                "LEFT JOIN modules m ON c.course_id = m.course_id " +
                "GROUP BY c.course_id, c.course_name, c.description " +
                "LIMIT ? OFFSET ?";

        try (Connection connection = DatabaseUtil.getConnectDB();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setInt(1, pageSize);
            preparedStatement.setInt(2, (page - 1) * pageSize);

            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                Integer courseId = resultSet.getInt("course_id");
                String courseName = resultSet.getString("course_name");
                String description = resultSet.getString("description");
                int moduleCount = resultSet.getInt("module_count");
                CourseDTO dto = new CourseDTO(courseId, courseName, description, moduleCount);
                courseDTOList.add(dto);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return courseDTOList;
    }

    @Override
    public int getTotalCourseCount() {
        String sql = "SELECT COUNT(*) FROM courses";
        try (Connection connection = DatabaseUtil.getConnectDB();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                return resultSet.getInt(1);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return 0;
    }

    @Override
    public CourseDTO findByName(String courseName) {
        String sql = "SELECT course_id, course_name, description FROM courses WHERE LOWER(course_name) = LOWER(?)";
        try (Connection connection = DatabaseUtil.getConnectDB();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setString(1, courseName);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                Integer courseId = resultSet.getInt("course_id");
                String name = resultSet.getString("course_name");
                String description = resultSet.getString("description");
                return new CourseDTO(courseId, name, description);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return null;
    }

    @Override
    public CourseDTO findById(int courseId) {
        String sql = "SELECT course_id, course_name, description FROM courses WHERE course_id = ?";
        try (Connection connection = DatabaseUtil.getConnectDB();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setInt(1, courseId);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                String name = resultSet.getString("course_name");
                String description = resultSet.getString("description");
                return new CourseDTO(courseId, name, description);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return null;
    }

    @Override
    public void update(CourseDTO course) {
        String sql = "UPDATE courses SET course_name = ?, description = ? WHERE course_id = ?";
        try (Connection connection = DatabaseUtil.getConnectDB();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setString(1, course.getCourseName());
            preparedStatement.setString(2, course.getDescription());
            preparedStatement.setInt(3, course.getCourseId());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}

