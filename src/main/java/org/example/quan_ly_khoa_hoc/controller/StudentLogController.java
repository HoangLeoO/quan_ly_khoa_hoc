package org.example.quan_ly_khoa_hoc.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.quan_ly_khoa_hoc.dto.StudentLogDTO;
import org.example.quan_ly_khoa_hoc.dto.TeacherInfoDTO;
import org.example.quan_ly_khoa_hoc.entity.StudentLog;
import org.example.quan_ly_khoa_hoc.entity.User;
import org.example.quan_ly_khoa_hoc.service.StudentLogService;
import org.example.quan_ly_khoa_hoc.service.StudentService;
import org.example.quan_ly_khoa_hoc.service.TeacherService;
import org.example.quan_ly_khoa_hoc.service.serviceInterface.IStudentLogService;
import org.example.quan_ly_khoa_hoc.service.serviceInterface.IStudentService;
import org.example.quan_ly_khoa_hoc.service.serviceInterface.ITeacherService;

import java.io.IOException;
import java.util.List;

// Ánh xạ URL: /student-log là entry point chính
@WebServlet(name = "StudentLogController", value = "/student-log")
public class StudentLogController extends HttpServlet {

    // Khai báo Services
    private final IStudentLogService studentLogService=new StudentLogService();
    private final ITeacherService teacherService=new TeacherService(); // Dùng để lấy thông tin Staff/Teacher hiện tại
    private final IStudentService studentService = new StudentService();
    // ----------------------------------------------------------------------
    // PHƯƠNG THỨC GET
    // ----------------------------------------------------------------------
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }

        try {
            switch (action) {
                case "detail":
                    showLogDetail(req, resp);
                    break;
                case "edit":
                    showEditLogForm(req, resp);
                    break;
                case "write": // Hành động hiển thị form ghi nhật ký mới
                    showWriteLogForm(req, resp);
                    break;
                default:
                    showList(req, resp); // Mặc định hiển thị danh sách nhật ký của 1 học sinh
                    break;
            }
        } catch (Exception e) {
            System.err.println("Lỗi xử lý GET StudentLogController: " + e.getMessage());
            req.setAttribute("errorMessage", "Lỗi xử lý yêu cầu: " + e.getMessage());
            req.getRequestDispatcher("/views/error.jsp").forward(req, resp);
        }
    }

    // Thêm phương thức này vào StudentLogController.java
    private void showLogDetail(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int logId = Integer.parseInt(req.getParameter("logId"));
        int studentId = Integer.parseInt(req.getParameter("studentId"));
        StudentLogDTO log = studentLogService.findById(logId);
        try {
            // Lấy logId và studentId từ tham số URL

            if (log == null) {
                // Nếu không tìm thấy log, ném ngoại lệ Runtime
                throw new RuntimeException("Không tìm thấy nhật ký có ID: " + logId);
            }

            // 2. Lấy Staff ID của người dùng hiện tại (để kiểm tra quyền sửa/xóa trên JSP)
            int currentStaffId = getCurrentStaffId(req);

            // ⭐ LỖI ĐƯỢC SỬA: Thay thế studentLogService.findById(studentId)
            String studentName = studentLogService.findFullNameById(studentId);

            req.setAttribute("studentName", studentName); // ⭐ Đặt tên học sinh chính xác
            req.setAttribute("studentLog", log);
            req.setAttribute("studentId", studentId);
            req.setAttribute("currentStaffId", currentStaffId);
            // 4. Chuyển tiếp đến trang JSP hiển thị chi tiết
            req.getRequestDispatcher("/views/teacher/student-log-detail.jsp").forward(req, resp);

        } catch (NumberFormatException e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID nhật ký hoặc học sinh không hợp lệ.");
        } catch (RuntimeException e) {
            // Xử lý khi không tìm thấy log hoặc lỗi khác
            req.getSession().setAttribute("errorMessage", e.getMessage());
            // Quay lại trang danh sách nhật ký của học sinh đó
            resp.sendRedirect(req.getContextPath() + "/student-log?studentId=" + req.getParameter("studentId"));
        }

    }

    // ----------------------------------------------------------------------
    // PHƯƠNG THỨC POST
    // ----------------------------------------------------------------------
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }

        try {
            switch (action) {
                case "create":
                    saveStudentLog(req, resp);
                    break;
                case "update":
                    updateStudentLog(req, resp);
                    break;
                case "delete":
                    deleteStudentLog(req, resp);
                    break;
                default:
                    resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Hành động POST không hợp lệ.");
                    break;
            }
        } catch (Exception e) {
            System.err.println("Lỗi xử lý POST StudentLogController: " + e.getMessage());
            req.setAttribute("errorMessage", "Lỗi xử lý dữ liệu POST: " + e.getMessage());
            req.getRequestDispatcher("/views/error.jsp").forward(req, resp);
        }
    }


    // ----------------------------------------------------------------------
    // 1. READ: Hiển thị danh sách nhật ký của một Học sinh (Tham số: studentId)
    // ----------------------------------------------------------------------
    private void showList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int studentIdParam = Integer.parseInt(req.getParameter("studentId"));

        // ⭐ BƯỚC 1: Lấy Staff ID của người dùng hiện tại
        int currentStaffId = getCurrentStaffId(req);

        // Lấy tên học sinh và danh sách logs
        String studentName = studentLogService.findFullNameById(studentIdParam);
        List<StudentLogDTO> logs = studentLogService.findByStudentId(studentIdParam);

        req.setAttribute("studentLogs", logs);
        req.setAttribute("studentId", studentIdParam);
        req.setAttribute("studentName", studentName);

        // ⭐ BƯỚC 2: Đặt Staff ID vào Request Scope để JSP có thể dùng
        req.setAttribute("currentStaffId", currentStaffId);

        // Chuyển đến trang JSP hiển thị danh sách
        req.getRequestDispatcher("/views/teacher/student-log-list.jsp").forward(req, resp);
    }

    // ----------------------------------------------------------------------
    // 2. CREATE: Hiển thị Form viết nhật ký mới
    // ----------------------------------------------------------------------
    private void showWriteLogForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String studentIdParam = req.getParameter("studentId");

        // ⭐ LỖI ĐƯỢC SỬA: Thay thế studentLogService.findById(Integer.parseInt(studentIdParam))
        if (studentIdParam == null || studentIdParam.isEmpty()) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Thiếu tham số Student ID.");
            return;
        }

        int studentId = Integer.parseInt(studentIdParam);
        int authorStaffId = getCurrentStaffId(req);

        // Lấy tên học sinh
        String studentName = studentLogService.findFullNameById(studentId);

        if (authorStaffId <= 0) {
            req.setAttribute("errorMessage", "Thông tin Staff không hợp lệ. Vui lòng đăng nhập lại.");
            req.getRequestDispatcher("/views/error.jsp").forward(req, resp);
            return;
        }

        // Gán thông tin cần thiết vào request scope để JSP sử dụng
        req.setAttribute("studentName", studentName); // ⭐ Sửa để truyền tên học sinh
        req.setAttribute("studentId", studentId);
        req.setAttribute("authorStaffId", authorStaffId);

        req.getRequestDispatcher("/views/teacher/student-log-write.jsp").forward(req, resp);
    }

    // ----------------------------------------------------------------------
    // 3. CREATE: Xử lý lưu nhật ký mới
    // ----------------------------------------------------------------------
    private void saveStudentLog(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        // Lấy các tham số từ form
        int studentId = Integer.parseInt(req.getParameter("studentId"));
        int authorStaffId = Integer.parseInt(req.getParameter("authorStaffId"));
        String content = req.getParameter("content");

        StudentLog newLog = new StudentLog();
        newLog.setStudentId(studentId);
        newLog.setAuthorStaffId(authorStaffId);
        newLog.setContent(content);

        try {
            studentLogService.save(newLog);
            req.getSession().setAttribute("message", "Ghi nhật ký học sinh thành công.");
        } catch (IllegalArgumentException e) {
            // Bắt validation error từ Service
            req.getSession().setAttribute("errorMessage", "Lỗi dữ liệu: " + e.getMessage());
            // Redirect về form để người dùng sửa lại
            resp.sendRedirect(req.getContextPath() + "/student-log?action=write&studentId=" + studentId);
            return;
        } catch (Exception e) {
            req.getSession().setAttribute("errorMessage", "Lỗi hệ thống khi lưu nhật ký: " + e.getMessage());
        }

        // Redirect về trang danh sách nhật ký của học sinh đó sau khi thành công
        resp.sendRedirect(req.getContextPath() + "/student-log?studentId=" + studentId);
    }

    // ----------------------------------------------------------------------
    // 4. UPDATE: Hiển thị Form chỉnh sửa nhật ký
    // ----------------------------------------------------------------------
    private void showEditLogForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int logId = Integer.parseInt(req.getParameter("logId"));
            int studentId = Integer.parseInt(req.getParameter("studentId"));

            // 1. Lấy dữ liệu nhật ký hiện tại
            StudentLogDTO existingLogDTO = studentLogService.findById(logId);
            if (existingLogDTO == null) {
                throw new RuntimeException("Không tìm thấy nhật ký để chỉnh sửa (ID: " + logId + ")");
            }

            // Kiểm tra quyền chỉnh sửa (Chỉ Staff là tác giả mới được sửa)
            int currentStaffId = getCurrentStaffId(req);
            if (existingLogDTO.getAuthorStaffId() != currentStaffId) {
                req.getSession().setAttribute("errorMessage", "Bạn không có quyền chỉnh sửa nhật ký này.");
                resp.sendRedirect(req.getContextPath() + "/student-log?studentId=" + studentId);
                return;
            }

            // ⭐ BỔ SUNG: Lấy tên học sinh
            String studentName = studentLogService.findFullNameById(studentId);

            req.setAttribute("studentLog", existingLogDTO);
            req.setAttribute("studentId", studentId);
            // ⭐ BỔ SUNG: Đặt tên học sinh vào Request Scope
            req.setAttribute("studentName", studentName);

            req.getRequestDispatcher("/views/teacher/student-log-edit.jsp").forward(req, resp);

        } catch (NumberFormatException e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID nhật ký hoặc học sinh không hợp lệ.");
        } catch (RuntimeException e) {
            req.getSession().setAttribute("errorMessage", e.getMessage());
            // Quay lại trang danh sách nếu không tìm thấy
            resp.sendRedirect(req.getContextPath() + "/student-log?studentId=" + req.getParameter("studentId"));
        }
    }

    // ----------------------------------------------------------------------
    // 5. UPDATE: Xử lý cập nhật nhật ký
    // ----------------------------------------------------------------------
    private void updateStudentLog(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int logId = Integer.parseInt(req.getParameter("logId"));
        int studentId = Integer.parseInt(req.getParameter("studentId"));
        String newContent = req.getParameter("content");

        StudentLog logToUpdate = new StudentLog();
        logToUpdate.setLogId(logId);
        logToUpdate.setContent(newContent);

        try {
            boolean success = studentLogService.update(logToUpdate);
            if (success) {
                req.getSession().setAttribute("message", "Cập nhật nhật ký thành công.");
            } else {
                req.getSession().setAttribute("errorMessage", "Không tìm thấy nhật ký để cập nhật hoặc lỗi DB.");
            }
        } catch (Exception e) {
            req.getSession().setAttribute("errorMessage", "Lỗi cập nhật: " + e.getMessage());
        }

        // Chuyển hướng về trang danh sách
        resp.sendRedirect(req.getContextPath() + "/student-log?studentId=" + studentId);
    }

    // ----------------------------------------------------------------------
    // 6. DELETE: Xử lý xóa nhật ký
    // ----------------------------------------------------------------------
    private void deleteStudentLog(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int logId = Integer.parseInt(req.getParameter("logId"));
        int studentId = Integer.parseInt(req.getParameter("studentId"));

        try {
            boolean success = studentLogService.delete(logId);
            if (success) {
                req.getSession().setAttribute("message", "Xóa nhật ký thành công.");
            } else {
                req.getSession().setAttribute("errorMessage", "Không tìm thấy nhật ký để xóa.");
            }
        } catch (Exception e) {
            req.getSession().setAttribute("errorMessage", "Lỗi hệ thống khi xóa nhật ký: " + e.getMessage());
        }

        // Chuyển hướng về trang danh sách
        resp.sendRedirect(req.getContextPath() + "/student-log?studentId=" + studentId);
    }

    // ----------------------------------------------------------------------
    // PHƯƠNG THỨC HỖ TRỢ: Lấy Staff ID từ Session
    // ----------------------------------------------------------------------
    private int getCurrentStaffId(HttpServletRequest req) {
        HttpSession session = req.getSession(false);
        if (session != null) {
            User u = (User) session.getAttribute("currentUser");
            if (u != null) {
                // Giả định findStaffByEmail trả về TeacherInfoDTO có staffId
                TeacherInfoDTO staffInfo = teacherService.findStaffByEmail(u.getEmail());
                if (staffInfo != null) {
                    return staffInfo.getStaffId();
                }
            }
        }
        return 0; // Trả về 0 nếu không tìm thấy Staff ID
    }
}