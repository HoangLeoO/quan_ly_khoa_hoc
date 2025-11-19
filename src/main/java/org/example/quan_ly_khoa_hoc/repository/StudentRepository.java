package org.example.quan_ly_khoa_hoc.repository;

import org.example.quan_ly_khoa_hoc.dto.ClassDTO;
import org.example.quan_ly_khoa_hoc.dto.ClassInfoDTO;
import org.example.quan_ly_khoa_hoc.dto.StudentProfileDTO;
import org.example.quan_ly_khoa_hoc.entity.Student;
import org.example.quan_ly_khoa_hoc.entity.User;
import org.example.quan_ly_khoa_hoc.repository.repositoryInterface.IStudentRepository;
import org.example.quan_ly_khoa_hoc.util.DatabaseUtil;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class StudentRepository implements IStudentRepository {
    private final String SELECT_STUDENTS_BY_CLASS = "SELECT \n" +
            "    st.full_name ,\n" +
            "    st.phone ,\n" +
            "    st.dob,\n" +
            "    st.address ,\n" +
            "    u.email \n" +
            "FROM enrolments e\n" +
            "INNER JOIN students st ON e.student_id = st.student_id\n" +
            "INNER JOIN users u ON st.user_id = u.user_id\n" +
            "WHERE e.class_id = ?\n" +
            "ORDER BY st.full_name;";
    @Override
    public Student addStudentInTransaction(Connection connection, Student student) throws SQLException {
        if (student == null || student.getUserId() == null) {
            throw new IllegalArgumentException("Student and user_id cannot be null");
        }
        if (student.getFullName() == null || student.getFullName().trim().isEmpty()) {
            throw new IllegalArgumentException("Full name cannot be empty");
        }
        String sql = "INSERT INTO students (user_id, full_name,phone,dob,address) VALUES (?, ?, ?,?,?)";
        try (PreparedStatement preparedStatement = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
            preparedStatement.setInt(1, student.getUserId());
            preparedStatement.setString(2, student.getFullName());
            preparedStatement.setString(3, student.getPhone());
            preparedStatement.setDate(4, java.sql.Date.valueOf(student.getDob()));
            preparedStatement.setString(5, student.getAddress());
            int affectedRows = preparedStatement.executeUpdate();

            if (affectedRows == 0) {
                throw new SQLException("Creating user failed, no rows affected.");
            }
            try (ResultSet generatedKeys = preparedStatement.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    student.setStudentId(generatedKeys.getInt(1));
                    System.out.println("✓ Created Student with ID: " + generatedKeys.getInt(1) + " for User ID: " + student.getUserId());
                } else {
                    throw new SQLException("Creating student failed, no ID obtained.");
                }
            }
            return student;
        }
    }

    @Override
    public Integer getStudentIdByEmail(String email) {
        Integer id = null;

        try (Connection connection = DatabaseUtil.getConnectDB()) {
            PreparedStatement preparedStatement = connection.prepareStatement("select s.student_id from students s join codegym.users u on s.user_id = u.user_id where u.email = ?;");
            preparedStatement.setString(1, email);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                id = resultSet.getInt("student_id");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return id;
    }

    @Override
    public StudentProfileDTO getStudentProfileByEmail(String email) {
        StudentProfileDTO s = null;
        try (Connection connection = DatabaseUtil.getConnectDB()) {
            PreparedStatement preparedStatement = connection.prepareStatement("select s.full_name,s.phone,s.dob,s.address,u.email from students s join users u on s.user_id = u.user_id where u.email = ?;");
            preparedStatement.setString(1, email);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                String fullName = resultSet.getString("full_name");
                String phone = resultSet.getString("phone");
                LocalDate dob = null;
                Date sqlDob = resultSet.getDate("dob");
                if (sqlDob != null) {
                    dob = sqlDob.toLocalDate();
                }
                String address = resultSet.getString("address");
                String emailS= resultSet.getString("email");
                s = new StudentProfileDTO(fullName,phone,dob,address,emailS);
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return s;
    }

    @Override
    public List<StudentProfileDTO> findByClassId(int classId) {
        List<StudentProfileDTO> studentProfileDTOList = new ArrayList<>();
        try (Connection connection = DatabaseUtil.getConnectDB()) {
            PreparedStatement preparedStatement = connection.prepareStatement(SELECT_STUDENTS_BY_CLASS);
            preparedStatement.setInt(1, classId);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                String fullName = resultSet.getString("full_name");
                String phone = resultSet.getString("phone");
                LocalDate dob = resultSet.getDate("dob").toLocalDate();
                String address = resultSet.getString("address");
                String email = resultSet.getString("email");
                studentProfileDTOList.add(new StudentProfileDTO(fullName,phone,dob,address,email));
            }
        } catch (SQLException e) {
            System.out.println("lỗi lấy dữ liệu");
        }
       return studentProfileDTOList;
    }

    private final String CLASS_INFO = "select e.class_id, cl.class_name, c.course_name, c.course_id, e.status\n" +
            "            from classes cl\n" +
            "                  join courses c on c.course_id = cl.course_id\n" +
            "                    join enrolments e on cl.class_id = e.class_id\n" +
            "                     join students s on e.student_id = s.student_id\n" +
            "            where s.student_id =  ?;";

    @Override
    public List<ClassInfoDTO> getStudentClassesInfoById(int studentId) {
        List<ClassInfoDTO> classInfoDTOS = new ArrayList<>();

        try (Connection connection = DatabaseUtil.getConnectDB()) {
            PreparedStatement preparedStatement = connection.prepareStatement(CLASS_INFO);
            preparedStatement.setInt(1, studentId);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                int class_id = resultSet.getInt("class_id");
                String class_name = resultSet.getString("class_name");
                String course_name = resultSet.getString("course_name");
                String status = resultSet.getString("status");
                int course_id = resultSet.getInt("course_id");
                classInfoDTOS.add(new ClassInfoDTO(class_id,class_name,course_name,status,course_id));
            }
        } catch (SQLException e) {
            System.out.println("Lỗi ở repo student");
        }
        return classInfoDTOS;
    }
}
