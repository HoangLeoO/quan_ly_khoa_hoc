package org.example.quan_ly_khoa_hoc.repository;

import org.example.quan_ly_khoa_hoc.dto.ClassInfoDTO;
import org.example.quan_ly_khoa_hoc.repository.repositoryInterface.IStudentRepository;
import org.example.quan_ly_khoa_hoc.util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class StudentRepository implements IStudentRepository {

    private final String CLASS_INFO = "select e.class_id, cl.class_name, c.course_name, e.status\n" +
            "from classes cl\n" +
            "         join codegym.courses c on c.course_id = cl.course_id\n" +
            "         join codegym.enrolments e on cl.class_id = e.class_id\n" +
            "         join codegym.students s on e.student_id = s.student_id\n" +
            "where s.student_id = ? ";

    @Override
    public List<ClassInfoDTO> getStudentClassesInfoById(int studentId) {
        List<ClassInfoDTO> classInfoDTOS = new ArrayList<>();

        try(Connection connection = DatabaseUtil.getConnectDB()) {
            PreparedStatement preparedStatement = connection.prepareStatement(CLASS_INFO);
            preparedStatement.setInt(1,studentId);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()){
                int class_id = resultSet.getInt("class_id");
                String class_name = resultSet.getString("class_name");
                String course_name = resultSet.getString("course_name");
                String status = resultSet.getString("status");
                classInfoDTOS.add(new ClassInfoDTO(class_id,class_name,course_name,status));
            }
        } catch (SQLException e) {
            System.out.println("Lỗi ở repo student");
        }
        return classInfoDTOS;
    }
}
