package org.example.quan_ly_khoa_hoc.service.serviceInterface;

import org.example.quan_ly_khoa_hoc.dto.ScheduleDTO;
import org.example.quan_ly_khoa_hoc.entity.Attendance;
import org.example.quan_ly_khoa_hoc.entity.Lesson;
import org.example.quan_ly_khoa_hoc.entity.Module;

import java.time.LocalDate;
import java.util.List;

public interface IAttendanceService {
    List<Module> getModulesByCourse(int courseId);
    List<Lesson> getLessonsByModule(int moduleId);

    void submitAttendance(int classId, LocalDate date, int lessonId, List<Attendance> attendanceData);
    List<ScheduleDTO> getSchedulesForToday();
}
