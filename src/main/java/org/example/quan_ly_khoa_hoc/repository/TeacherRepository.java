package org.example.quan_ly_khoa_hoc.repository;

import org.example.quan_ly_khoa_hoc.dto.TeacherClassDTO;
import org.example.quan_ly_khoa_hoc.repository.repositoryInterface.ITeacherRepository;
import org.example.quan_ly_khoa_hoc.util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class TeacherRepository implements ITeacherRepository {
    private final String SELECT_ALL = "select * from users;";
    @Override
    public List<TeacherClassDTO> getAll() {
        List<TeacherClassDTO> teacherDTOList = new ArrayList<>();

        try (Connection connection = DatabaseUtil.getConnectDB();) {
            PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                int classId = resultSet.getInt("id");
                String className = resultSet.getString("name");
                String courseName = resultSet.getString("email");
                LocalDate startDate= resultSet.getDate("startDate").toLocalDate();
                LocalDate endDate= resultSet.getDate("endDate").toLocalDate();
                int totalStudents = resultSet.getInt("totalStudents");
                teacherDTOList.add(new TeacherClassDTO(classId, className, courseName, startDate,endDate,totalStudents));
            }
        } catch (SQLException e) {
            System.out.println("lỗi lấy dữ liệu");
        }

        return teacherDTOList;
    }
}
