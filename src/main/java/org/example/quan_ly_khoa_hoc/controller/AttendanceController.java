package org.example.quan_ly_khoa_hoc.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.example.quan_ly_khoa_hoc.dto.ScheduleDTO;
import org.example.quan_ly_khoa_hoc.dto.StudentDetailDTO;
import org.example.quan_ly_khoa_hoc.dto.TeacherClassDTO;
import org.example.quan_ly_khoa_hoc.entity.Attendance;
import org.example.quan_ly_khoa_hoc.repository.ClassRepository;
import org.example.quan_ly_khoa_hoc.repository.repositoryInterface.IClassRepository;
import org.example.quan_ly_khoa_hoc.service.AttendanceService;
import org.example.quan_ly_khoa_hoc.service.serviceInterface.IAttendanceService;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap; // THÊM IMPORT
import java.util.List;
import java.util.Map; // THÊM IMPORT
import java.util.stream.Collectors; // THÊM IMPORT

@WebServlet(name = "AttendanceController", value = "/attendance")
public class AttendanceController extends HttpServlet {

    private IAttendanceService attendanceService = new AttendanceService();
    private IClassRepository classRepository = new ClassRepository();

    // ----------------------------------------------------
    // PHƯƠNG THỨC doGet (ĐÃ CẬP NHẬT PHÂN LUỒNG)
    // ----------------------------------------------------
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null || action.isEmpty()) {
            action = "listToday";
        }

        try {
            switch (action) {
                case "listToday":
                    showTodaySchedules(req, resp);
                    break;
                case "takeNew":
                    // Sử dụng cờ false cho Điểm danh mới
                    showAttendanceForm(req, resp, false);
                    break;
                case "edit":
                    // Sử dụng cờ true cho Chỉnh sửa
                    showAttendanceForm(req, resp, true);
                    break;
                default:
                    showTodaySchedules(req, resp);
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Xử lý lỗi hệ thống
            resp.sendRedirect(req.getContextPath() + "/attendance?msg=system_error");
        }
    }

    // ----------------------------------------------------
    // PHƯƠNG THỨC showTodaySchedules (ĐÃ THÊM LOGIC KIỂM TRA TRẠNG THÁI)
    // ----------------------------------------------------
    private void showTodaySchedules(HttpServletRequest req, HttpServletResponse resp) {
        try {
            List<ScheduleDTO> todaySchedules = attendanceService.getSchedulesForToday();

            // SỬ DỤNG LOGIC MỚI: Gắn trạng thái đã điểm danh vào từng Schedule
            for (ScheduleDTO schedule : todaySchedules) {
                boolean isTaken = attendanceService.isAttendanceTaken(schedule.getScheduleId());
                schedule.setAttendanceTaken(isTaken); // PHẢI CÓ trong ScheduleDTO
            }

            req.setAttribute("todaySchedules", todaySchedules);
            req.getRequestDispatcher("/views/teacher/today-schedules.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // ----------------------------------------------------
    // PHƯƠNG THỨC showAttendanceForm (HỢP NHẤT logic NEW và EDIT)
    // ----------------------------------------------------
    private void showAttendanceForm(HttpServletRequest request, HttpServletResponse response, boolean isEdit) throws ServletException, IOException {
        String scheduleIdStr = request.getParameter("scheduleId");
        if (scheduleIdStr == null || scheduleIdStr.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Thiếu ID lịch học (scheduleId).");
            return;
        }
        int scheduleId = Integer.parseInt(scheduleIdStr);
        ScheduleDTO scheduleInfo = attendanceService.getScheduleById(scheduleId);

        if (scheduleInfo == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy thông tin chi tiết lịch học.");
            return;
        }

        int classId = scheduleInfo.getClassId();
        TeacherClassDTO currentClass = classRepository.findClassById(classId);
        List<StudentDetailDTO> studentList = classRepository.findStudentsByClassId(classId);

        // LOGIC MỚI: Tải dữ liệu điểm danh cũ nếu đang ở chế độ chỉnh sửa
        Map<Integer, Attendance> oldAttendanceMap = new HashMap<>();
        if (isEdit) {
            List<Attendance> oldAttendanceList = attendanceService.getAttendanceByScheduleId(scheduleId);

            // Chuyển List thành Map để JSP dễ tra cứu bằng StudentId
            oldAttendanceMap = oldAttendanceList.stream()
                    .collect(Collectors.toMap(
                            Attendance::getStudentId,
                            att -> att
                    ));
        }

        request.setAttribute("currentClass", currentClass);
        request.setAttribute("currentSchedule", scheduleInfo);
        request.setAttribute("studentList", studentList);
        request.setAttribute("scheduleId", scheduleId);
        request.setAttribute("oldAttendanceMap", oldAttendanceMap); // Gửi map dữ liệu cũ (rỗng nếu là NEW)

        request.getRequestDispatcher("/views/teacher/attendance-form.jsp").forward(request, response);
    }

    // ----------------------------------------------------
    // PHƯƠNG THỨC doPost (ĐÃ LOẠI BỎ NOTE)
    // ----------------------------------------------------
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp){
        try {
            req.setCharacterEncoding("UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
            throw new RuntimeException("Lỗi thiết lập mã hóa ký tự UTF-8", e);
        }

        try {
            String scheduleIdStr = req.getParameter("scheduleId");
            if (scheduleIdStr == null || scheduleIdStr.isEmpty()) {
                throw new IllegalArgumentException("Thiếu scheduleId từ form điểm danh.");
            }
            int scheduleId = Integer.parseInt(scheduleIdStr);

            List<Attendance> attendanceList = new ArrayList<>();
            Enumeration<String> params = req.getParameterNames();

            while (params.hasMoreElements()) {
                String p = params.nextElement();
                if (p.startsWith("status_")) {
                    int studentId = Integer.parseInt(p.split("_")[1]);
                    String status = req.getParameter(p);

                    // >>> KHÔI PHỤC LOGIC LẤY VÀ LƯU GHI CHÚ <<<
                    String note = req.getParameter("note_" + studentId);
                    Attendance att = new Attendance(0, studentId, status, note);
                    // >>> END KHÔI PHỤC <<<

                    att.setScheduleId(scheduleId);

                    attendanceList.add(att);
                }
            }

            attendanceService.submitAttendance(scheduleId, attendanceList);
            String mess = "saved";
            resp.sendRedirect(req.getContextPath() + "/attendance?msg=" + mess);

        } catch (Exception e) {
            e.printStackTrace();
            try {
                resp.sendRedirect(req.getContextPath() + "/attendance?msg=error");
            } catch (IOException ex) {
                throw new RuntimeException(ex);
            }
        }
    }
}