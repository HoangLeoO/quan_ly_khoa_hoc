package org.example.quan_ly_khoa_hoc.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.quan_ly_khoa_hoc.dto.NewAttendanceFormDTO; // CẦN THIẾT CHO LUỒNG MỚI
import org.example.quan_ly_khoa_hoc.dto.ScheduleDTO;
import org.example.quan_ly_khoa_hoc.dto.StudentDetailDTO;
import org.example.quan_ly_khoa_hoc.dto.TeacherClassDTO;
import org.example.quan_ly_khoa_hoc.dto.TeacherInfoDTO;
import org.example.quan_ly_khoa_hoc.entity.Attendance;
import org.example.quan_ly_khoa_hoc.entity.User;
import org.example.quan_ly_khoa_hoc.repository.ClassRepository;
import org.example.quan_ly_khoa_hoc.repository.repositoryInterface.IClassRepository;
import org.example.quan_ly_khoa_hoc.service.AttendanceService;
import org.example.quan_ly_khoa_hoc.service.TeacherService;
import org.example.quan_ly_khoa_hoc.service.serviceInterface.IAttendanceService;
import org.example.quan_ly_khoa_hoc.service.serviceInterface.ITeacherService;
import java.time.format.DateTimeFormatter;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.time.LocalDateTime; // CẦN THIẾT CHO LUỒNG MỚI
import java.util.*;
import java.util.stream.Collectors;

@WebServlet(name = "AttendanceController", value = "/attendance")
public class AttendanceController extends HttpServlet {

    private IAttendanceService attendanceService = new AttendanceService();
    private IClassRepository classRepository = new ClassRepository();
    private ITeacherService teacherService = new TeacherService();

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
                    showNewAttendanceForm(req, resp); // <-- Xử lý tạo mới
                    break;
                case "edit":
                    showEditAttendanceForm(req, resp); // <-- Xử lý chỉnh sửa
                    break;
                default:
                    showTodaySchedules(req, resp);
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/attendance?msg=system_error");
        }
    }

    // Phương thức showTodaySchedules giữ nguyên
    private void showTodaySchedules(HttpServletRequest req, HttpServletResponse resp) {
        // ... (Logic showTodaySchedules giữ nguyên) ...
        try {
            HttpSession session = req.getSession();
            User currentUser = (User) session.getAttribute("currentUser");

            if (currentUser == null) {
                resp.sendRedirect(req.getContextPath() + "/login?msg=session_expired");
                return;
            }

            TeacherInfoDTO teacherInfo = teacherService.findStaffByEmail(currentUser.getEmail());

            if (teacherInfo == null) {
                req.setAttribute("errorMessage", "Bạn không có quyền truy cập chức năng này.");
                req.getRequestDispatcher("/views/error.jsp").forward(req, resp);
                return;
            }

            int teacherStaffId = teacherInfo.getStaffId();
            List<ScheduleDTO> todaySchedules = attendanceService.getSchedulesForToday(teacherStaffId);

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
    // PHƯƠNG THỨC MỚI: HIỂN THỊ FORM TẠO MỚI (Dựa trên Class ID)
    // ----------------------------------------------------
    private void showNewAttendanceForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String classIdStr = request.getParameter("classId");
        if (classIdStr == null || classIdStr.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/attendance?msg=missing_class");
            return;
        }
        int classId = Integer.parseInt(classIdStr);

        TeacherClassDTO currentClass = classRepository.findClassById(classId);
        List<StudentDetailDTO> studentList = classRepository.findStudentsByClassId(classId);

        if (currentClass == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy thông tin lớp học.");
            return;
        }

        request.setAttribute("currentClass", currentClass);
        request.setAttribute("studentList", studentList);
        request.setAttribute("isNewForm", true);

        // 1. Tính toán thời gian mặc định
        LocalDateTime now = LocalDateTime.now();
        LocalDateTime defaultTimeStart = now;

        // Mặc định: timeEnd bằng timeStart cộng thêm 1 giờ
        LocalDateTime defaultTimeEnd = now.plusHours(1); // <-- THÊM LOGIC NÀY

        // 2. Định dạng LocalDateTime sang String chuẩn yyyy-MM-ddTHH:mm
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");

        String formattedTimeStart = defaultTimeStart.format(formatter);
        String formattedTimeEnd = defaultTimeEnd.format(formatter); // <-- FORMAT TIME END

        request.setAttribute("currentDateTimeStart", formattedTimeStart); // ĐỔI TÊN ATTRIBUTE ĐỂ RÕ RÀNG HƠN
        request.setAttribute("currentDateTimeEnd", formattedTimeEnd);     // <-- GỬI TIME END MẶC ĐỊNH SANG JSP

        request.getRequestDispatcher("/views/teacher/attendance-form.jsp").forward(request, response);
    }

    // ----------------------------------------------------
    // PHƯƠNG THỨC CŨ (ĐỔI TÊN): HIỂN THỊ FORM CHỈNH SỬA (Dựa trên Schedule ID)
    // ----------------------------------------------------
    private void showEditAttendanceForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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

        // Cần import java.time.format.DateTimeFormatter;
        // =============================================================
        // BƯỚC SỬA: FORMAT THỜI GIAN VỚI KIỂM TRA NULL AN TOÀN
        // =============================================================
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");

        // Khai báo biến chuỗi để lưu giá trị đã format
        String formattedTimeStart = "";
        String formattedTimeEnd = "";

        // Kiểm tra NULL trước khi format timeStart
        if (scheduleInfo.getTimeStart() != null) {
            // Lưu ý: Đảm bảo getTimeStart() trả về LocalDateTime, không phải LocalTime
            formattedTimeStart = scheduleInfo.getTimeStart().format(formatter);
        }

        // Kiểm tra NULL trước khi format timeEnd
        if (scheduleInfo.getTimeEnd() != null) {
            // Lỗi của bạn xảy ra tại đây: scheduleInfo.getTimeEnd() bị null
            formattedTimeEnd = scheduleInfo.getTimeEnd().format(formatter);
        }

        // Truyền các giá trị đã được format (có thể là chuỗi rỗng nếu giá trị gốc là null)
        request.setAttribute("scheduleTimeStart", formattedTimeStart);
        request.setAttribute("scheduleTimeEnd", formattedTimeEnd);
        // =============================================================

        int classId = scheduleInfo.getClassId();
        TeacherClassDTO currentClass = classRepository.findClassById(classId);
        List<StudentDetailDTO> studentList = classRepository.findStudentsByClassId(classId);

        Map<Integer, Attendance> oldAttendanceMap = new HashMap<>();
        List<Attendance> oldAttendanceList = attendanceService.getAttendanceByScheduleId(scheduleId);

        // Logic an toàn để tạo Map
        if (oldAttendanceList != null && !oldAttendanceList.isEmpty()) {
            try {
                oldAttendanceMap = oldAttendanceList.stream()
                        .collect(Collectors.toMap(
                                Attendance::getStudentId,
                                att -> att
                        ));
            } catch (IllegalStateException e) {
                System.err.println("Lỗi dữ liệu: Trùng lặp studentId trong bảng điểm danh. " + e.getMessage());
            }
        }

        request.setAttribute("currentClass", currentClass);
        request.setAttribute("currentSchedule", scheduleInfo);
        request.setAttribute("studentList", studentList);
        request.setAttribute("scheduleId", scheduleId);
        request.setAttribute("oldAttendanceMap", oldAttendanceMap);
        request.setAttribute("isNewForm", false);

        request.getRequestDispatcher("/views/teacher/attendance-form.jsp").forward(request, response);
    }


    // ----------------------------------------------------
    // doPost: XỬ LÝ LƯU (PHÂN TÁCH ACTION)
    // ----------------------------------------------------
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            req.setCharacterEncoding("UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
            throw new RuntimeException("Lỗi thiết lập mã hóa ký tự UTF-8", e);
        }

        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }

        try {
            if ("saveNewAttendance".equals(action)) {
                // Xử lý tạo Schedule mới và lưu điểm danh
                handleSaveNewAttendance(req, resp);
            } else if ("saveAttendance".equals(action)) {
                // Xử lý cập nhật điểm danh cho Schedule đã tồn tại
                handleUpdateAttendance(req, resp);
            } else {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Hành động POST không hợp lệ.");
            }
        } catch (IllegalStateException e) {
            // BƯỚC SỬA: Bắt lỗi nghiệp vụ (ví dụ: Lịch học bị trùng lặp trong ngày)
            e.printStackTrace();
            // Lưu thông báo lỗi chi tiết (ví dụ: "Lớp này đã có buổi học...")
            req.getSession().setAttribute("errorMessage", e.getMessage());
            // Chuyển hướng với cờ báo hiệu lỗi trùng lặp
            resp.sendRedirect(req.getContextPath() + "/attendance?msg=duplicate_schedule");
        } catch (Exception e) {
            // Bắt các lỗi hệ thống, I/O, SQL không mong muốn
            e.printStackTrace();
            req.getSession().setAttribute("errorMessage", "Lỗi xử lý điểm danh: " + e.getMessage());
            resp.sendRedirect(req.getContextPath() + "/attendance?msg=error");
        }
    }

    /**
     * Xử lý tạo Schedule mới và lưu điểm danh (Logic mới)
     */
    private void handleSaveNewAttendance(HttpServletRequest req, HttpServletResponse resp) throws Exception {

        // 1. Thu thập thông tin Schedule mới
        String classIdStr = req.getParameter("classId");
        // Giả định classIdStr luôn có giá trị hợp lệ
        int classId = Integer.parseInt(classIdStr);

        Integer lessonId = null;
        String lessonIdStr = req.getParameter("lessonId");
        if (lessonIdStr != null && !lessonIdStr.isEmpty()) {
            // Giả định NumberFormatException sẽ được doPost bắt
            lessonId = Integer.parseInt(lessonIdStr);
        }

        // --- BƯỚC SỬA: Lấy chuỗi và kiểm tra/parse thời gian ---
        LocalDateTime timeStart;
        LocalDateTime timeEnd;

        String timeStartStr = req.getParameter("timeStart");
        String timeEndStr = req.getParameter("timeEnd");

        try {
            // Kiểm tra null/empty trước khi parse
            if (timeStartStr == null || timeStartStr.trim().isEmpty() ||
                    timeEndStr == null || timeEndStr.trim().isEmpty()) {
                // Ném lỗi để được catch ngay bên dưới, giúp hiển thị thông báo lỗi
                throw new IllegalArgumentException("Thời gian bắt đầu và kết thúc không được để trống.");
            }

            // Parse thành LocalDateTime (có thể ném DateTimeParseException)
            timeStart = LocalDateTime.parse(timeStartStr);
            timeEnd = LocalDateTime.parse(timeEndStr);

        } catch (Exception e) {
            // Bắt lỗi parsing (DateTimeParseException) hoặc lỗi trống (IllegalArgumentException)
            e.printStackTrace();
            req.getSession().setAttribute("errorMessage", "Lỗi định dạng thời gian hoặc thiếu thông tin. Vui lòng kiểm tra lại ngày/giờ.");
            resp.sendRedirect(req.getContextPath() + "/attendance?msg=error");
            return; // Dừng xử lý
        }

        String room = req.getParameter("room");

        // 2. Thu thập danh sách điểm danh (scheduleId = 0, sẽ được service cập nhật sau)
        // Giả định bạn có phương thức collectAttendanceData(req, 0)
        List<Attendance> attendanceList = collectAttendanceData(req, 0);

        // 3. Đóng gói DTO
        NewAttendanceFormDTO formDTO = new NewAttendanceFormDTO(
                classId, lessonId, timeStart, timeEnd, room, attendanceList
        );

        // 4. Gọi Service để tạo Schedule và lưu Attendance
        // NOTE: IllegalStateException (Lỗi trùng lặp) sẽ được ném và được doPost bắt.
        attendanceService.createScheduleAndSaveAttendance(formDTO);

        // 5. Chuyển hướng THÀNH CÔNG (Chỉ chạy khi Service không ném Exception)
        String mess = "saved_new_schedule";
        resp.sendRedirect(req.getContextPath() + "/attendance?msg=" + mess);
    }

    /**
     * Xử lý cập nhật điểm danh cho Schedule đã tồn tại (Logic cũ)
     */
    private void handleUpdateAttendance(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        String scheduleIdStr = req.getParameter("scheduleId");
        if (scheduleIdStr == null || scheduleIdStr.isEmpty()) {
            throw new IllegalArgumentException("Thiếu scheduleId từ form điểm danh (cập nhật).");
        }
        int scheduleId = Integer.parseInt(scheduleIdStr);

        List<Attendance> attendanceList = collectAttendanceData(req, scheduleId);

        attendanceService.submitAttendance(scheduleId, attendanceList);

        String mess = "updated";
        resp.sendRedirect(req.getContextPath() + "/attendance?msg=" + mess);
    }

    /**
     * Phương thức chung để thu thập dữ liệu điểm danh từ Request
     */
    private List<Attendance> collectAttendanceData(HttpServletRequest req, int scheduleId) {
        List<Attendance> attendanceList = new ArrayList<>();
        Enumeration<String> params = req.getParameterNames();

        while (params.hasMoreElements()) {
            String p = params.nextElement();
            if (p.startsWith("status_")) {
                int studentId = Integer.parseInt(p.split("_")[1]);
                String status = req.getParameter(p);
                String note = req.getParameter("note_" + studentId);

                Attendance att = new Attendance();
                att.setScheduleId(scheduleId);
                att.setStudentId(studentId);
                att.setStatus(status);
                att.setNote(note);

                attendanceList.add(att);
            }
        }
        return attendanceList;
    }
}