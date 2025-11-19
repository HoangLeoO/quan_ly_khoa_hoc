package org.example.quan_ly_khoa_hoc.service;

import org.example.quan_ly_khoa_hoc.dto.ScheduleDTO;
import org.example.quan_ly_khoa_hoc.entity.Attendance;
import org.example.quan_ly_khoa_hoc.entity.Lesson;
import org.example.quan_ly_khoa_hoc.entity.Module;
import org.example.quan_ly_khoa_hoc.repository.AttendanceRepository;
import org.example.quan_ly_khoa_hoc.repository.CourseRepository;
import org.example.quan_ly_khoa_hoc.repository.repositoryInterface.IAttendanceRepository;
import org.example.quan_ly_khoa_hoc.repository.repositoryInterface.ICourseRepository;
import org.example.quan_ly_khoa_hoc.service.serviceInterface.IAttendanceService;
import org.example.quan_ly_khoa_hoc.service.serviceInterface.ILessonService;
import org.example.quan_ly_khoa_hoc.service.serviceInterface.IModuleService;

import java.time.LocalDate;
import java.util.List;

public class AttendanceService implements IAttendanceService {
//    private final ICourseRepository contentRepository = new CourseRepository()
    private final IModuleService moduleService= new ModuleService();
    private final ILessonService lessonService= new LessonService();
    private final IAttendanceRepository attendanceRepository = new AttendanceRepository();

    @Override
    public List<Module> getModulesByCourse(int courseId) {
        return moduleService.findModulesByCourseId(courseId);
    }

    @Override
    public List<Lesson> getLessonsByModule(int moduleId) {
        return lessonService.findLessonsByModuleId(moduleId);
    }

    @Override
    public void submitAttendance(int classId, LocalDate date, int lessonId, List<Attendance> attendanceData) {
        Integer scheduleId = attendanceRepository.findScheduleId(classId, date, lessonId);
        if (scheduleId == null) {
            scheduleId = attendanceRepository.createSchedule(classId, date, lessonId);
        }

        for (Attendance att : attendanceData) {
            att.setScheduleId(scheduleId);
        }
        attendanceRepository.saveBatchAttendance(attendanceData);
    }

    @Override
    public List<ScheduleDTO> getSchedulesForToday() {
        return attendanceRepository.getSchedulesForToday();
    }
}
