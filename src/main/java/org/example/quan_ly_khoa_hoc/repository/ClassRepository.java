package org.example.quan_ly_khoa_hoc.repository;

import org.example.quan_ly_khoa_hoc.dto.ClassDTO;
import org.example.quan_ly_khoa_hoc.dto.StudentDetailDTO;
import org.example.quan_ly_khoa_hoc.dto.TeacherClassDTO;
import org.example.quan_ly_khoa_hoc.repository.repositoryInterface.IClassRepository;
import org.example.quan_ly_khoa_hoc.util.DatabaseUtil;
import org.example.quan_ly_khoa_hoc.entity.Class;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class ClassRepository implements IClassRepository {
    private final String SELECT_ALL_STUDYING = "SELECT c.class_id,c.class_name,c.course_id,co.course_name,c.start_date,c.end_date,c.status FROM classes c JOIN courses co ON c.course_id = co.course_id WHERE c.teacher_id = ? and status='studying';";
    private final String SELECT_ALL = "SELECT c.class_id, c.class_name AS class_name, co.course_id, co.course_name AS course_name, s.staff_id, s.full_name AS teacher_name, COUNT(e.student_id) AS student_count, c.start_date AS start_date, c.end_date AS end_date, c.status AS status \n" +
            "FROM classes c\n" +
            "LEFT JOIN courses co ON c.course_id = co.course_id\n" +
            "LEFT JOIN staff s ON c.teacher_id = s.staff_id\n" +
            "LEFT JOIN enrolments e ON c.class_id = e.class_id\n" +
            "where  c.status = 'completed' or c.status = 'studying'\n" +
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
                    "  AND e.status = 'studying' " +
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
                int courseId = resultSet.getInt("course_id");
                String courseName = resultSet.getString("course_name");
                int teacherId = resultSet.getInt("staff_id");
                String teacherName = resultSet.getString("teacher_name");
                int countStudent = resultSet.getInt("student_count");
                LocalDate startDate = resultSet.getDate("start_date").toLocalDate();
                LocalDate endDate = resultSet.getDate("end_date").toLocalDate();
                String status = resultSet.getString("status");
                classDTOList.add(new ClassDTO(classId, className, courseId, courseName, teacherId, teacherName, countStudent, startDate, endDate, status));
            }
        } catch (SQLException e) {
            System.out.println("lỗi lấy dữ liệu");
        }
        return classDTOList;
    }

    @Override
    public ClassDTO findByClassID(int classId) {
        List<ClassDTO> classDTOList = findAll();
        for (ClassDTO _class : classDTOList) {
            if (_class.getClassId() == classId) {
                return _class;
            }
        }
        return null;
    }

    @Override
    public int getTotalClassCount() {
        String sql = "SELECT COUNT(*) FROM classes";
        try (Connection conn = DatabaseUtil.getConnectDB();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    @Override
    public List<ClassDTO> search(String keyword, Integer teacherId, Integer courseId, String status) {
        List<ClassDTO> classDTOList = new ArrayList<>();

        StringBuilder sql = new StringBuilder(
                "SELECT " +
                        " c.class_id, " +
                        " c.class_name AS class_name, " +
                        " co.course_id, " +
                        " co.course_name AS course_name, " +
                        " s.staff_id, " +
                        " s.full_name AS teacher_name, " +
                        " COUNT(e.student_id) AS student_count, " +
                        " c.start_date AS start_date, " +
                        " c.end_date AS end_date, " +
                        " c.status AS status " +
                        "FROM classes c " +
                        "LEFT JOIN courses co ON c.course_id = co.course_id " +
                        "LEFT JOIN staff s ON c.teacher_id = s.staff_id " +
                        "LEFT JOIN enrolments e ON c.class_id = e.class_id " +
                        "WHERE 1=1 "
        );


        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND c.class_name LIKE ? ");
        }

        if (teacherId != null && teacherId > 0) {   // FIXED: teacherId > 0
            sql.append(" AND c.teacher_id = ? ");
        }

        if (courseId != null && courseId > 0) {     // FIXED: courseId > 0
            sql.append(" AND c.course_id = ? ");
        }

        if (status != null && !status.trim().isEmpty()) {  // FIXED: status rỗng ko lọc
            sql.append(" AND c.status = ? ");
        }

        sql.append(
                " GROUP BY c.class_id, c.class_name, co.course_id, co.course_name, " +
                        " s.staff_id, s.full_name, c.start_date, c.end_date, c.status " +
                        " ORDER BY c.class_id "
        );


        try (Connection conn = DatabaseUtil.getConnectDB();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            int index = 1;
            if (keyword != null && !keyword.trim().isEmpty()) {
                ps.setString(index++, "%" + keyword + "%");
            }

            if (teacherId != null && teacherId > 0) {
                ps.setInt(index++, teacherId);
            }

            if (courseId != null && courseId > 0) {
                ps.setInt(index++, courseId);
            }

            if (status != null && !status.trim().isEmpty()) {
                ps.setString(index++, status);
            }

            ResultSet resultSet = ps.executeQuery();

            while (resultSet.next()) {
                int classId = resultSet.getInt("class_id");
                String className = resultSet.getString("class_name");
                int _courseId = resultSet.getInt("course_id");
                String courseName = resultSet.getString("course_name");
                int _teacherId = resultSet.getInt("staff_id");
                String teacherName = resultSet.getString("teacher_name");
                int countStudent = resultSet.getInt("student_count");
                LocalDate startDate = resultSet.getDate("start_date").toLocalDate();
                LocalDate endDate = resultSet.getDate("end_date").toLocalDate();
                String _status = resultSet.getString("status");
                classDTOList.add(new ClassDTO(classId, className, _courseId, courseName, _teacherId, teacherName, countStudent, startDate, endDate, _status));
            }
        } catch (SQLException e) {
            System.out.println("lỗi lấy dữ liệu");
        }

        return classDTOList;
    }

    private final String INSERT_CLASS_SQL = "INSERT INTO classes (class_name, course_id, teacher_id, start_date, end_date, status) VALUES (?, ?, ?, ?, ?, ?);";
    private final String UPDATE_CLASS_SQL = "UPDATE classes SET class_name = ?, course_id = ?, teacher_id = ?, start_date = ?, end_date = ?, status = ? WHERE class_id = ?;";
    private final String DELETE_CLASS_SQL = "DELETE FROM classes WHERE class_id = ?;";

    @Override
    public boolean add(Class classObj) {
        try (Connection connection = DatabaseUtil.getConnectDB()) {
            PreparedStatement preparedStatement = connection.prepareStatement(INSERT_CLASS_SQL);
            preparedStatement.setString(1, classObj.getClassName());
            preparedStatement.setInt(2, classObj.getCourseId());
            preparedStatement.setInt(3, classObj.getTeacherId());
            preparedStatement.setDate(4, java.sql.Date.valueOf(classObj.getStartDate()));
            preparedStatement.setDate(5, java.sql.Date.valueOf(classObj.getEndDate()));
            preparedStatement.setString(6, classObj.getStatus());
            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("Lỗi khi thêm lớp học: " + e.getMessage());
        }
        return false;
    }

    @Override
    public boolean updateById(int classId, Class classObj) {
        try (Connection connection = DatabaseUtil.getConnectDB()) {
            PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_CLASS_SQL);
            preparedStatement.setString(1, classObj.getClassName());
            preparedStatement.setInt(2, classObj.getCourseId());
            preparedStatement.setInt(3, classObj.getTeacherId());
            preparedStatement.setDate(4, java.sql.Date.valueOf(classObj.getStartDate()));
            preparedStatement.setDate(5, java.sql.Date.valueOf(classObj.getEndDate()));
            preparedStatement.setString(6, classObj.getStatus());
            preparedStatement.setInt(7, classId);
            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("Lỗi khi cập nhật lớp học: " + e.getMessage());
        }
        return false;
    }

    @Override
    public boolean deleteById(int classId) {
        try (Connection connection = DatabaseUtil.getConnectDB()) {
            PreparedStatement preparedStatement = connection.prepareStatement(DELETE_CLASS_SQL);
            preparedStatement.setInt(1, classId);
            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("Lỗi khi xóa lớp học: " + e.getMessage());
        }
        return false;
    }
}
