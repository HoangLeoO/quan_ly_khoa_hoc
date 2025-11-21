package org.example.quan_ly_khoa_hoc.service.serviceInterface;

import org.example.quan_ly_khoa_hoc.dto.ScheduleDTO;
import org.example.quan_ly_khoa_hoc.entity.Attendance;
import org.example.quan_ly_khoa_hoc.entity.Lesson;
import org.example.quan_ly_khoa_hoc.entity.Module;

import java.util.List;

public interface IAttendanceService {
    List<ScheduleDTO> getSchedulesForToday();
    ScheduleDTO getScheduleById(int scheduleId);
    void submitAttendance(int scheduleId, List<Attendance> attendanceList);
    boolean isAttendanceTaken(int scheduleId);
    List<Attendance> getAttendanceByScheduleId(int scheduleId);
    List<ScheduleDTO> getSchedulesForToday(int teacherStaffId);
}