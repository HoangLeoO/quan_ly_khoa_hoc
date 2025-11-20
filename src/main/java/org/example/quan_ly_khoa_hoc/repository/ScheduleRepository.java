package org.example.quan_ly_khoa_hoc.repository;

import org.example.quan_ly_khoa_hoc.dto.ScheduleDTO;
import org.example.quan_ly_khoa_hoc.entity.Schedule;
import org.example.quan_ly_khoa_hoc.repository.repositoryInterface.IScheduleRepository;
import org.example.quan_ly_khoa_hoc.util.DatabaseUtil;

import java.sql.*;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

public class ScheduleRepository implements IScheduleRepository {
     private final String SELECT_BASE =
             """
                     SELECT
                         sch.schedule_id,
                         sch.class_id,
                         c.class_name,
                        \s
                         DATE(sch.time_start)       AS study_date,
                         DAYNAME(sch.time_start)    AS weekday,
                         TIME(sch.time_start)       AS time_start,
                         TIME(sch.time_end)         AS time_end,
                        \s
                         sch.room                   AS room,
                         l.lesson_name              AS lesson_name,
                         l.lesson_id                AS lesson_id,
                         m.module_name              AS module_name,
                        \s
                         s.staff_id                 AS teacher_id,
                         s.full_name                AS teacher_name
                     
                     FROM schedules sch
                     INNER JOIN classes c ON sch.class_id = c.class_id
                     LEFT JOIN lessons l ON sch.lesson_id = l.lesson_id
                     LEFT JOIN modules m ON l.module_id = m.module_id
                     LEFT JOIN staff s   ON c.teacher_id = s.staff_id
                     """;


    @Override
    public List<ScheduleDTO> findAll() {
        List<ScheduleDTO> scheduleDTOList = new ArrayList<>();
        try (Connection connection = DatabaseUtil.getConnectDB()) {
            // Query đầy đủ cho findAll
            String SELECT_ALL = SELECT_BASE + "ORDER BY sch.time_start;";
            PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                int scheduleId = resultSet.getInt("schedule_id");
                int classId = resultSet.getInt("class_id");
                String className = resultSet.getString("class_name");
                LocalDate studyDate = resultSet.getDate("study_date").toLocalDate();
                String weekday = resultSet.getString("weekday");
                LocalTime timeBegin = resultSet.getTime("time_start").toLocalTime();
                LocalTime timeEnd = resultSet.getTime("time_end").toLocalTime();
                String room = resultSet.getString("room");
                String lessonName = resultSet.getString("lesson_name");
                int lessonId = resultSet.getInt("lesson_id");
                String moduleName = resultSet.getString("module_name");
                int teacherId = resultSet.getInt("teacher_id");
                String teacherName = resultSet.getString("teacher_name");

                scheduleDTOList.add(new ScheduleDTO(scheduleId, classId, lessonId, className, lessonName, room, studyDate, weekday, timeEnd, timeBegin, moduleName, teacherId, teacherName));
            }
        } catch (SQLException e) {
            System.out.println("lỗi lấy dữ liệu");
        }
        return scheduleDTOList;
    }

    // CREATE
    @Override
    public boolean add(Schedule schedule) {
        try (Connection connection = DatabaseUtil.getConnectDB()) {
            String INSERT = "INSERT INTO schedules(class_id, lesson_id, time_start, time_end, room) VALUES (?,?,?,?,?)";
            PreparedStatement preparedStatement = connection.prepareStatement(INSERT);
            preparedStatement.setInt(1, schedule.getClassId());
            preparedStatement.setInt(2, schedule.getLessonId());
            preparedStatement.setTimestamp(3, schedule.getTimeStart());
            preparedStatement.setTimestamp(4, schedule.getTimeEnd());
            preparedStatement.setString(5, schedule.getRoom());
            int effectRow = preparedStatement.executeUpdate();
            return effectRow == 1;
        } catch (SQLException e) {

            System.out.println("lỗi lấy dữ liệu");
        }
        return false;
    }

    // FIND BY CLASS ID
    @Override
    public boolean editById(int scheduleId, Schedule schedule) {
        try (Connection connection = DatabaseUtil.getConnectDB()) {
            String UPDATE = "UPDATE schedules SET class_id=?, lesson_id=?, time_start=?, time_end=?, room=? WHERE schedule_id=?";
            PreparedStatement preparedStatement = connection.prepareStatement(UPDATE);
            preparedStatement.setInt(1, schedule.getClassId());
            preparedStatement.setInt(2, schedule.getLessonId());
            preparedStatement.setTimestamp(3, schedule.getTimeStart());
            preparedStatement.setTimestamp(4, schedule.getTimeEnd());
            preparedStatement.setString(5, schedule.getRoom());
            preparedStatement.setInt(6, scheduleId); // ✅ Đúng index
            int effectRow = preparedStatement.executeUpdate();
            return effectRow == 1;
        } catch (SQLException e) {

            System.out.println("lỗi lấy dữ liệu");
        }
        return false;
    }

    @Override
    public boolean deleteById(int scheduleId) {
        try (Connection connection = DatabaseUtil.getConnectDB()) {
            String DELETE = "DELETE FROM schedules WHERE schedule_id=?";
            PreparedStatement preparedStatement = connection.prepareStatement(DELETE);
            preparedStatement.setInt(1, scheduleId);
            int effectRow = preparedStatement.executeUpdate();
            return effectRow == 1;
        } catch (SQLException e) {

            System.out.println("lỗi lấy dữ liệu");
        }
        return false;
    }

    @Override
    public List<ScheduleDTO> findScheduleDTOByClassId(int classId) {
        List<ScheduleDTO> scheduleDTOList = new ArrayList<>();
        String sql = SELECT_BASE + "WHERE c.class_id = ? ORDER BY sch.time_start;";

        try (Connection connection = DatabaseUtil.getConnectDB()) {
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, classId);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                int scheduleId = resultSet.getInt("schedule_id");
                String className = resultSet.getString("class_name");
                LocalDate studyDate = resultSet.getDate("study_date").toLocalDate();
                String weekday = resultSet.getString("weekday");
                LocalTime timeBegin = resultSet.getTime("time_start").toLocalTime();
                LocalTime timeEnd = resultSet.getTime("time_end").toLocalTime();
                String room = resultSet.getString("room");
                String lessonName = resultSet.getString("lesson_name");
                int lessonId = resultSet.getInt("lesson_id");
                String moduleName = resultSet.getString("module_name");
                int teacherId = resultSet.getInt("teacher_id");
                String teacherName = resultSet.getString("teacher_name");

                scheduleDTOList.add(new ScheduleDTO(scheduleId, classId, lessonId, className,
                        lessonName, room, studyDate, weekday, timeEnd, timeBegin,
                        moduleName, teacherId, teacherName));
            }
        } catch (SQLException e) {

            System.out.println("lỗi lấy dữ liệu: " + e.getMessage());
        }
        return scheduleDTOList;
    }


    @Override
    public Schedule findScheduleById(int scheduleId) {
        Schedule schedule = null;
        try (Connection connection = DatabaseUtil.getConnectDB()) {
            String FIND_SCHEDULE_BY_ID = "select class_id,lesson_id,time_start,time_end,room from schedules where schedule_id = ?;";
            PreparedStatement preparedStatement = connection.prepareStatement(FIND_SCHEDULE_BY_ID);
            preparedStatement.setInt(1, scheduleId);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                int classId = resultSet.getInt("class_id");
                int lessonId = resultSet.getInt("lesson_id");
                Timestamp timeStart = resultSet.getTimestamp("time_start");
                Timestamp timeEnd = resultSet.getTimestamp("time_end");
                String room = resultSet.getString("room");
                schedule = new Schedule(scheduleId, classId, lessonId, timeStart, timeEnd, room);
            }
        } catch (SQLException e) {
            System.out.println("lỗi lấy dữ liệu");
        }
        return schedule;
    }

}

