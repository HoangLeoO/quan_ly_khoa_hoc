package org.example.quan_ly_khoa_hoc.repository.repositoryInterface;

import org.example.quan_ly_khoa_hoc.entity.Attendance;

import java.time.LocalDate;
import java.util.List;

public interface IAttendanceRepository {
    // Tìm schedule_id dựa trên lớp, ngày và bài học
    Integer findScheduleId(int classId, LocalDate date, int lessonId);

    // Tạo mới schedule và trả về ID vừa tạo
    int createSchedule(int classId, LocalDate date, int lessonId);

    // Lưu danh sách điểm danh
    void saveBatchAttendance(List<Attendance> attendanceList);

}
