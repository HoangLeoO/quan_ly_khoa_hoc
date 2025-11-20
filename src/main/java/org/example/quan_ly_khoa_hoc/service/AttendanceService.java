package org.example.quan_ly_khoa_hoc.service;

import org.example.quan_ly_khoa_hoc.dto.ScheduleDTO;
import org.example.quan_ly_khoa_hoc.entity.Attendance;
import org.example.quan_ly_khoa_hoc.repository.AttendanceRepository;
import org.example.quan_ly_khoa_hoc.repository.repositoryInterface.IAttendanceRepository;
import org.example.quan_ly_khoa_hoc.service.serviceInterface.IAttendanceService;
// Đã loại bỏ các import không cần thiết (Lesson, Module, ILessonService, IModuleService, LocalDate)

import java.util.List;

public class AttendanceService implements IAttendanceService {
    private final IAttendanceRepository attendanceRepository = new AttendanceRepository();
    @Override
    public ScheduleDTO getScheduleById(int scheduleId) {
        return attendanceRepository.getScheduleById(scheduleId);
    }

    @Override
    public void submitAttendance(int scheduleId, List<Attendance> attendanceData) {
        if (attendanceData != null && !attendanceData.isEmpty()) {
            for (Attendance att : attendanceData) {
                att.setScheduleId(scheduleId);
            }
            attendanceRepository.saveBatchAttendance(attendanceData);
        }
    }

    @Override
    public boolean isAttendanceTaken(int scheduleId) {
        return attendanceRepository.countAttendanceByScheduleId(scheduleId) > 0;
    }

    @Override
    public List<Attendance> getAttendanceByScheduleId(int scheduleId) {
        return attendanceRepository.findByScheduleId(scheduleId);
    }

    @Override
    public List<ScheduleDTO> getSchedulesForToday() {
        return attendanceRepository.getSchedulesForToday();
    }
}