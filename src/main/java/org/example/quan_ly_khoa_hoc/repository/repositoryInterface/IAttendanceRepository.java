package org.example.quan_ly_khoa_hoc.repository.repositoryInterface;

import org.example.quan_ly_khoa_hoc.dto.AttendanceDetailDTO;
import org.example.quan_ly_khoa_hoc.dto.ScheduleDTO;
import org.example.quan_ly_khoa_hoc.entity.Attendance;

import java.time.LocalDate;
import java.util.List;

public interface IAttendanceRepository {
    void saveBatchAttendance(List<Attendance> attendanceList);
    List<ScheduleDTO> getSchedulesForToday();
    ScheduleDTO getScheduleById(int scheduleId);
    int countAttendanceByScheduleId(int scheduleId);
    List<Attendance> findByScheduleId(int scheduleId);
    List<ScheduleDTO> findSchedulesForToday(int teacherStaffId);
}
