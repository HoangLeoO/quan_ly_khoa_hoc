package org.example.quan_ly_khoa_hoc.service;

import org.example.quan_ly_khoa_hoc.dto.ScheduleDTO;
import org.example.quan_ly_khoa_hoc.entity.Attendance;
import org.example.quan_ly_khoa_hoc.entity.Lesson;
import org.example.quan_ly_khoa_hoc.entity.Module;
import org.example.quan_ly_khoa_hoc.repository.AttendanceRepository;
import org.example.quan_ly_khoa_hoc.repository.repositoryInterface.IAttendanceRepository;
import org.example.quan_ly_khoa_hoc.service.serviceInterface.IAttendanceService;
import org.example.quan_ly_khoa_hoc.service.serviceInterface.ILessonService;
import org.example.quan_ly_khoa_hoc.service.serviceInterface.IModuleService;

import java.time.LocalDate;
import java.util.List;

public class AttendanceService implements IAttendanceService {
    private final IAttendanceRepository attendanceRepository = new AttendanceRepository();
    @Override
    public ScheduleDTO getScheduleById(int scheduleId) {
        return attendanceRepository.getScheduleById(scheduleId);
    }
    @Override
    public void submitAttendance(int scheduleId, List<Attendance> attendanceData) {
        // Loại bỏ logic tìm/tạo schedule cũ. Giờ chỉ cần lưu:

        if (attendanceData != null && !attendanceData.isEmpty()) {
            for (Attendance att : attendanceData) {
                att.setScheduleId(scheduleId);
            }
            attendanceRepository.saveBatchAttendance(attendanceData);
        }
    }

    @Override
    public List<ScheduleDTO> getSchedulesForToday() {
        return attendanceRepository.getSchedulesForToday();
    }
}