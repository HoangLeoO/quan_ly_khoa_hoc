package org.example.quan_ly_khoa_hoc.service;

import org.example.quan_ly_khoa_hoc.dto.NewAttendanceFormDTO;
import org.example.quan_ly_khoa_hoc.dto.ScheduleDTO;
import org.example.quan_ly_khoa_hoc.entity.Attendance;
import org.example.quan_ly_khoa_hoc.repository.AttendanceRepository;
import org.example.quan_ly_khoa_hoc.repository.repositoryInterface.IAttendanceRepository;
import org.example.quan_ly_khoa_hoc.service.serviceInterface.IAttendanceService;
// Đã loại bỏ các import không cần thiết (Lesson, Module, ILessonService, IModuleService, LocalDate)

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

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
    public List<ScheduleDTO> getSchedulesForToday(int teacherStaffId) {
        return attendanceRepository.findSchedulesForToday(teacherStaffId);
    }

    @Override
    public void createScheduleAndSaveAttendance(NewAttendanceFormDTO formDTO) {
        if (formDTO.getAttendanceList() == null || formDTO.getAttendanceList().isEmpty()) {
            throw new IllegalArgumentException("Danh sách điểm danh không được trống.");
        }

        // =========================================================
        // 1. BƯỚC SỬA: KIỂM TRA TRÙNG LẶP LỊCH HỌC TRONG NGÀY
        // =========================================================
        LocalDateTime scheduleDate = formDTO.getTimeStart();

        // Gọi Repository để kiểm tra
        if (attendanceRepository.hasScheduleForClassOnDate(formDTO.getClassId(), scheduleDate)) {
            // Ném IllegalStateException (Unchecked Exception) nếu trùng lặp
            throw new IllegalStateException("Lớp này đã có buổi học vào ngày "
                    + scheduleDate.toLocalDate().toString()
                    + ". Vui lòng sử dụng chức năng Chỉnh sửa.");
        }
        // =========================================================

        int newScheduleId;
        try {
            // 2. TẠO LỊCH HỌC MỚI VÀ LẤY ID (Chỉ chạy nếu không trùng lặp)
            newScheduleId = attendanceRepository.createScheduleAndGetId(
                    formDTO.getClassId(),
                    formDTO.getLessonId(),
                    formDTO.getTimeStart(),
                    formDTO.getTimeEnd(),
                    formDTO.getRoom()
            );

            // 3. CẬP NHẬT SCHEDULE ID CHO TỪNG BẢN GHI ĐIỂM DANH
            List<Attendance> attendanceList = formDTO.getAttendanceList();

            List<Attendance> updatedAttendanceList = attendanceList.stream()
                    .peek(att -> att.setScheduleId(newScheduleId))
                    .collect(Collectors.toList());

            // 4. LƯU ĐIỂM DANH HÀNG LOẠT
            attendanceRepository.saveBatchAttendance(updatedAttendanceList);

        } catch (RuntimeException e) {
            System.err.println("Lỗi khi tạo Schedule và lưu Attendance: " + e.getMessage());
            // Lỗi CSDL (SQLException) đã được bọc thành RuntimeException trong Repository
            // Controller sẽ bắt lỗi này
            throw new RuntimeException("Lỗi hệ thống trong quá trình lưu dữ liệu.", e);
        }
    }

    @Override
    public ScheduleDTO getTodayScheduleByClassId(int classId) {
        return attendanceRepository.findTodayScheduleByClassId(classId);
    }

    @Override
    public void saveTodayAttendance(int classId, Integer lessonId, LocalDateTime timeStart, LocalDateTime timeEnd, String room, List<Attendance> attendanceList) {
        if (attendanceList == null || attendanceList.isEmpty()) {
            throw new IllegalArgumentException("Danh sách điểm danh không được trống.");
        }

        // 1. Tìm schedule hôm nay của class
        ScheduleDTO todaySchedule = attendanceRepository.findTodayScheduleByClassId(classId);
        int scheduleId;

        if (todaySchedule == null) {
            // 2A. Chưa có → tạo mới
            scheduleId = attendanceRepository.createScheduleAndGetId(
                    classId,
                    lessonId,
                    timeStart,
                    timeEnd,
                    room
            );
        } else {
            // 2B. Đã có → dùng lại
            scheduleId = todaySchedule.getScheduleId();
            // Nếu muốn, có thể update timeStart/timeEnd/room ở bảng schedules,
            // nhưng tạm thời giữ nguyên cho đơn giản.
        }

        // 3. Gán scheduleId cho tất cả attendance và lưu
        List<Attendance> updated = attendanceList.stream()
                .peek(att -> att.setScheduleId(scheduleId))
                .collect(Collectors.toList());

        attendanceRepository.saveBatchAttendance(updated);
    }

    @Override
    public List<ScheduleDTO> getSchedulesForToday() {
        return attendanceRepository.getSchedulesForToday();
    }
}