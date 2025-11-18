package org.example.quan_ly_khoa_hoc.repository;

import org.example.quan_ly_khoa_hoc.dto.StudentDetailDTO;
import org.example.quan_ly_khoa_hoc.dto.TeacherClassDTO;
import org.example.quan_ly_khoa_hoc.repository.repositoryInterface.IClassRepository;
import org.example.quan_ly_khoa_hoc.util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class ClassRepository implements IClassRepository {
    private final String SELECT_ALL_STUDYING = "SELECT c.class_id,c.class_name,c.course_id,co.course_name,c.start_date,c.end_date,c.status FROM classes c JOIN courses co ON c.course_id = co.course_id WHERE c.teacher_id = ? and status='studying';";
    private final String SELECT_STUDENTS_BY_CLASS =
            "SELECT s.student_id,s.full_name, " +
                    "   COUNT(a.attendance_id) AS total_sessions, " +
                    "   COALESCE(SUM(CASE WHEN a.status = 'present' THEN 1 ELSE 0 END), 0) AS present_count, " +
                    "   COALESCE(SUM(CASE WHEN a.status = 'late' THEN 1 ELSE 0 END), 0) AS late_count, " +
                    "   COALESCE(SUM(CASE WHEN a.status = 'absent' THEN 1 ELSE 0 END), 0) AS absent_count, " +
                    "   COALESCE(SUM(CASE WHEN a.status = 'excused' THEN 1 ELSE 0 END), 0) AS excused_count " +
                    "FROM students s " +
                    "JOIN enrolments e ON s.student_id = e.student_id " +
                    "LEFT JOIN attendance a ON s.student_id = a.student_id " +
                    "LEFT JOIN schedules sch ON a.schedule_id = sch.schedule_id AND sch.class_id = e.class_id " +
                    "WHERE e.class_id = ? " +
                    "GROUP BY s.student_id, s.full_name;";
    @Override
    public List<TeacherClassDTO> findClassesByTeacherStaffId(int teacherStaffId) {
        List<TeacherClassDTO> userList = new ArrayList<>();
        try (Connection connection = DatabaseUtil.getConnectDB()) {
            PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_STUDYING);
            preparedStatement.setInt(1, teacherStaffId);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                int classId = resultSet.getInt("class_id");
                String className = resultSet.getString("class_name");
                int courseId = resultSet.getInt("course_id");
                String courseName = resultSet.getString("course_name");
                LocalDate startDate= resultSet.getDate("start_date").toLocalDate();
                LocalDate endDate= resultSet.getDate("end_date").toLocalDate();
                String status = resultSet.getString("status");
                userList.add(new TeacherClassDTO(classId, className, courseId,courseName, startDate,endDate,status));
            }
        } catch (SQLException e) {
            System.out.println("lỗi lấy dữ liệu");
        }

        return userList;
    }

    @Override
    public List<StudentDetailDTO> findStudentsByClassId(int classId) {
        List<StudentDetailDTO> studentDetailDTOList = new ArrayList<>();
        try (Connection connection = DatabaseUtil.getConnectDB();) {
            PreparedStatement preparedStatement = connection.prepareStatement(SELECT_STUDENTS_BY_CLASS);
            preparedStatement.setInt(1, classId);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                int studentId = resultSet.getInt("student_id");
                String fullName = resultSet.getString("full_name");
                int totalSessions = resultSet.getInt("total_sessions");
                int presentCount = resultSet.getInt("present_count");
                int lateCount = resultSet.getInt("late_count");
                int absentCount = resultSet.getInt("absent_count");
                int excusedCount = resultSet.getInt("excused_count");
                studentDetailDTOList.add(new StudentDetailDTO(studentId,fullName, totalSessions, presentCount, lateCount,absentCount,excusedCount));
            }
        } catch (SQLException e) {
            System.out.println("lỗi lấy dữ liệu");
        }

        return studentDetailDTOList;
    }

    @Override
    public TeacherClassDTO findClassById(int classId) {
        String sql = "SELECT c.class_id, c.class_name, c.course_id, co.course_name, c.start_date, c.end_date, c.status " +
                "FROM classes c " +
                "JOIN courses co ON c.course_id = co.course_id " +
                "WHERE c.class_id = ?";

        TeacherClassDTO classDTO = null;

        try (Connection connection = DatabaseUtil.getConnectDB();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, classId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                classDTO = new TeacherClassDTO(
                        rs.getInt("class_id"),
                        rs.getString("class_name"),
                        rs.getInt("course_id"),
                        rs.getString("course_name"),
                        rs.getDate("start_date").toLocalDate(),
                        rs.getDate("end_date").toLocalDate(),
                        rs.getString("status")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return classDTO;
    }
}
