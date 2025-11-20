package org.example.quan_ly_khoa_hoc.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession; // CẦN THIẾT
import org.example.quan_ly_khoa_hoc.dto.ScheduleDTO;
import org.example.quan_ly_khoa_hoc.dto.StudentDetailDTO;
import org.example.quan_ly_khoa_hoc.dto.TeacherClassDTO;
import org.example.quan_ly_khoa_hoc.dto.TeacherInfoDTO; // CẦN THIẾT
import org.example.quan_ly_khoa_hoc.entity.Attendance;
import org.example.quan_ly_khoa_hoc.entity.User; // CẦN THIẾT
import org.example.quan_ly_khoa_hoc.repository.ClassRepository;
import org.example.quan_ly_khoa_hoc.repository.repositoryInterface.IClassRepository;
import org.example.quan_ly_khoa_hoc.service.AttendanceService;
import org.example.quan_ly_khoa_hoc.service.TeacherService; // CẦN THIẾT
import org.example.quan_ly_khoa_hoc.service.serviceInterface.IAttendanceService;
import org.example.quan_ly_khoa_hoc.service.serviceInterface.ITeacherService; // CẦN THIẾT

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@WebServlet(name = "AttendanceController", value = "/attendance")
public class AttendanceController extends HttpServlet {

    private IAttendanceService attendanceService = new AttendanceService();
    private IClassRepository classRepository = new ClassRepository();
    private ITeacherService teacherService = new TeacherService(); // KHAI BÁO TeacherService

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
                    showAttendanceForm(req, resp, false);
                    break;
                case "edit":
                    showAttendanceForm(req, resp, true);
                    break;
                default:
                    showTodaySchedules(req, resp);
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/attendance?msg=system_error");
        }
    }

    // ----------------------------------------------------
    // PHƯƠNG THỨC showTodaySchedules ĐÃ SỬA LỖI LỌC THEO GIÁO VIÊN
    // ----------------------------------------------------
    private void showTodaySchedules(HttpServletRequest req, HttpServletResponse resp) {
        try {
            // --- 1. Lấy thông tin Giáo viên đang đăng nhập ---
            HttpSession session = req.getSession();
            User currentUser = (User) session.getAttribute("currentUser");

            if (currentUser == null) {
                // Nếu chưa đăng nhập, chuyển hướng đến trang đăng nhập
                resp.sendRedirect(req.getContextPath() + "/login?msg=session_expired");
                return;
            }

            TeacherInfoDTO teacherInfo = teacherService.findStaffByEmail(currentUser.getEmail());

            if (teacherInfo == null) {
                // Nếu người dùng không phải là Giáo viên (không tìm thấy Staff ID)
                req.setAttribute("errorMessage", "Bạn không có quyền truy cập chức năng này.");
                req.getRequestDispatcher("/views/error.jsp").forward(req, resp);
                return;
            }

            int teacherStaffId = teacherInfo.getStaffId();

            // --- 2. Gọi Service với Staff ID ---
            // CHÚ Ý: Cần cập nhật IAttendanceService/AttendanceService để chấp nhận tham số này!
            List<ScheduleDTO> todaySchedules = attendanceService.getSchedulesForToday(teacherStaffId);

            // --- 3. Gắn trạng thái đã điểm danh ---
            for (ScheduleDTO schedule : todaySchedules) {
                boolean isTaken = attendanceService.isAttendanceTaken(schedule.getScheduleId());
                schedule.setAttendanceTaken(isTaken);
            }

            req.setAttribute("todaySchedules", todaySchedules);
            req.setAttribute("nameTeacher", teacherInfo.getFullName());
            req.getRequestDispatcher("/views/teacher/today-schedules.jsp").forward(req, resp);
        } catch (Exception e) {
            System.out.println("Lỗi khi hiển thị lịch học hôm nay: " + e.getMessage());
            e.printStackTrace();
            try {
                resp.sendRedirect(req.getContextPath() + "/attendance?msg=error_load");
            } catch (IOException ioException) {
                ioException.printStackTrace();
            }
        }
    }

    // ----------------------------------------------------
    // showAttendanceForm (Giữ nguyên)
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

        Map<Integer, Attendance> oldAttendanceMap = new HashMap<>();
        if (isEdit) {
            List<Attendance> oldAttendanceList = attendanceService.getAttendanceByScheduleId(scheduleId);
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
        request.setAttribute("oldAttendanceMap", oldAttendanceMap);

        request.getRequestDispatcher("/views/teacher/attendance-form.jsp").forward(request, response);
    }

    // ----------------------------------------------------
    // doPost (Giữ nguyên)
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

                    String note = req.getParameter("note_" + studentId);
                    Attendance att = new Attendance(0, studentId, status, note);

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