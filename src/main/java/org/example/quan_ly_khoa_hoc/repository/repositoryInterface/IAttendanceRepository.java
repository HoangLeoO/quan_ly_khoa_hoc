package org.example.quan_ly_khoa_hoc.repository.repositoryInterface;

import org.example.quan_ly_khoa_hoc.dto.AttendanceDetailDTO;
import org.example.quan_ly_khoa_hoc.dto.ScheduleDTO;
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

    // THÊM: 1. Lấy danh sách lịch học (Schedules) theo Class ID
    List<ScheduleDTO> getSchedulesByClassId(int classId);

    // THÊM: 2. Lấy chi tiết điểm danh của TẤT CẢ học viên trong 1 Buổi học (Schedule)
    List<AttendanceDetailDTO> getAttendanceByScheduleId(int scheduleId);

    // THÊM: 3. Lấy chi tiết một bản ghi điểm danh (Dùng cho Form Sửa)
    ScheduleDTO findAttendanceById(int attendanceId);

    // THÊM: 4. Cập nhật trạng thái và ghi chú
    boolean updateAttendance(int attendanceId, String status, String note);

    // THÊM: 5. Xóa bản ghi điểm danh
    boolean deleteAttendance(int attendanceId);
}
