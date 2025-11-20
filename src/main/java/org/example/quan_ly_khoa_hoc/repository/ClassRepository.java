package org.example.quan_ly_khoa_hoc.repository;

import org.example.quan_ly_khoa_hoc.dto.ClassDTO;
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
    private final String SELECT_ALL = "SELECT \n" +
            "    c.class_id,\n" +
            "    c.class_name AS class_name,\n" +
            "co.course_name AS course_name,\n" +
            "s.full_name AS teacher_name,\n" +
            "COUNT(e.student_id) AS student_count,\n" +
            "c.start_date AS start_date,\n" +
            "c.end_date AS end_date,\n" +
            "c.status AS status\n" +
            "FROM classes c\n" +
            "LEFT JOIN courses co ON c.course_id = co.course_id\n" +
            "LEFT JOIN staff s ON c.teacher_id = s.staff_id\n" +
            "LEFT JOIN enrolments e ON c.class_id = e.class_id\n" +
            "GROUP BY c.class_id, c.class_name, co.course_name, s.full_name, c.start_date, c.end_date, c.status\n" +
            "ORDER BY c.class_id;";
    private final String SELECT_LATEST_MODULE_ORDER =
            "SELECT m.sort_order " +
                    "FROM schedules s " +
                    "JOIN lessons l ON s.lesson_id = l.lesson_id " +
                    "JOIN modules m ON l.module_id = m.module_id " +
                    "WHERE s.class_id = ? " +
                    "ORDER BY s.time_start DESC " +
                    "LIMIT 1;";
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
                    "LEFT JOIN lessons les ON sch.lesson_id = les.lesson_id " +
                    "LEFT JOIN modules m ON les.module_id = m.module_id " + // ĐÃ SỬA: mod -> m
                    "WHERE e.class_id = ? " +
                    "  AND (m.sort_order IS NULL OR m.sort_order <= ?) " + // ĐÃ SỬA: mod -> m
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
                LocalDate startDate = resultSet.getDate("start_date").toLocalDate();
                LocalDate endDate = resultSet.getDate("end_date").toLocalDate();
                String status = resultSet.getString("status");
                userList.add(new TeacherClassDTO(classId, className, courseId, courseName, startDate, endDate, status));
            }
        } catch (SQLException e) {
            System.out.println("lỗi lấy dữ liệu");
        }

        return userList;
    }

    @Override
    public List<StudentDetailDTO> findStudentsByClassId(int classId) {
        // --- Bước 1: Tìm Module Sort Order gần nhất đã học ---
        int latestModuleOrder = 0; // Mặc định là 0 nếu chưa học buổi nào
        try (Connection connection = DatabaseUtil.getConnectDB();
             PreparedStatement ps = connection.prepareStatement(SELECT_LATEST_MODULE_ORDER)) {
            ps.setInt(1, classId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                latestModuleOrder = rs.getInt("sort_order");
            }
        } catch (SQLException e) {
            System.out.println("Lỗi khi tìm Module Sort Order gần nhất: " + e.getMessage());
            // Nếu lỗi, latestModuleOrder vẫn là 0, điều này đảm bảo không có attendance nào được tính.
        }

        // --- Bước 2: Truy vấn điểm danh dựa trên latestModuleOrder ---
        List<StudentDetailDTO> studentDetailDTOList = new ArrayList<>();
        try (Connection connection = DatabaseUtil.getConnectDB();) {
            // Dùng SELECT_STUDENTS_BY_CLASS đã sửa đổi
            PreparedStatement preparedStatement = connection.prepareStatement(SELECT_STUDENTS_BY_CLASS);

            // Tham số 1: class_id (dùng cho mệnh đề WHERE e.class_id = ?)
            preparedStatement.setInt(1, classId);

            // Tham số 2: latestModuleOrder (dùng cho mệnh đề AND mod.sort_order <= ?)
            preparedStatement.setInt(2, latestModuleOrder);

            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                int studentId = resultSet.getInt("student_id");
                String fullName = resultSet.getString("full_name");
                int totalSessions = resultSet.getInt("total_sessions");
                int presentCount = resultSet.getInt("present_count");
                int lateCount = resultSet.getInt("late_count");
                int absentCount = resultSet.getInt("absent_count");
                int excusedCount = resultSet.getInt("excused_count");

                // Lưu ý: Nếu muốn có chi tiết theo Module, StudentDetailDTO cần được cập nhật
                // và truy vấn SQL cần GROUP BY cả student_id và module_id.
                studentDetailDTOList.add(new StudentDetailDTO(studentId, fullName, totalSessions, presentCount, lateCount, absentCount, excusedCount));
            }
        } catch (SQLException e) {
            System.out.println("Lỗi khi lấy dữ liệu sinh viên và điểm danh theo Module gần nhất: " + e.getMessage());
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

    @Override
    public List<ClassDTO> findAll() {
        List<ClassDTO> classDTOList = new ArrayList<>();
        try (Connection connection = DatabaseUtil.getConnectDB()) {
            PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                int classId = resultSet.getInt("class_id");
                String className = resultSet.getString("class_name");
                String courseName = resultSet.getString("course_name");
                String teacherName = resultSet.getString("teacher_name");
                int countStudent = resultSet.getInt("student_count");
                LocalDate startDate = resultSet.getDate("start_date").toLocalDate();
                LocalDate endDate = resultSet.getDate("end_date").toLocalDate();
                String status = resultSet.getString("status");
                classDTOList.add(new ClassDTO(classId, className, courseName, teacherName, countStudent, startDate, endDate, status));
            }
        } catch (SQLException e) {
            System.out.println("lỗi lấy dữ liệu");
        }
        return classDTOList;
    }
}
