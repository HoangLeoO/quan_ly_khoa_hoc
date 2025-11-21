package org.example.quan_ly_khoa_hoc.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.quan_ly_khoa_hoc.dto.ClassDTO;
import org.example.quan_ly_khoa_hoc.dto.ClassLogDTO;
import org.example.quan_ly_khoa_hoc.dto.TeacherInfoDTO;
import org.example.quan_ly_khoa_hoc.entity.ClassLog;
import org.example.quan_ly_khoa_hoc.entity.User;
import org.example.quan_ly_khoa_hoc.service.ClassLogService;
import org.example.quan_ly_khoa_hoc.service.ClassService;
import org.example.quan_ly_khoa_hoc.service.TeacherService;
import org.example.quan_ly_khoa_hoc.service.serviceInterface.IClassLogService;
import org.example.quan_ly_khoa_hoc.service.serviceInterface.IClassService;
import org.example.quan_ly_khoa_hoc.service.serviceInterface.ITeacherService;

import java.io.IOException;
import java.util.List;

// Ánh xạ URL: /class-log là entry point chính
@WebServlet(name = "ClassLogController", value = "/class-log")
public class ClassLogController extends HttpServlet {
    // Service cho Teacher/Staff (để lấy thông tin người dùng hiện tại)
    private ITeacherService teacherService = new TeacherService();

    // Dependency Injection (khởi tạo thủ công)
    private final IClassLogService classLogService = new ClassLogService();
    private final IClassService classService = new ClassService();

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
                    showEditJournalForm(req, resp);
                    break;
                case "write-class-journal":
                    showWriteJournalForm(req,resp);
                    break;
                default:
                    showList(req, resp);
                    break;
            }
        } catch (Exception e) {
            System.out.println("lỗi");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }

        try {
            switch (action) {
                case "create":
                    saveClassLog(req, resp);
                    break;
                case "update":
                    updateClassLog(req, resp);
                    break;
                case "delete":
                    deleteClassLog(req, resp);
                    break;
            }
        } catch (Exception e) {
            req.setAttribute("errorMessage", "Lỗi xử lý dữ liệu POST: " + e.getMessage());
            req.getRequestDispatcher("/views/error.jsp").forward(req, resp);
        }
    }


    // ----------------------------------------------------------------------
    // PHƯƠNG THỨC XỬ LÝ (CRUD)
    // ----------------------------------------------------------------------

    /**
     * READ: Hiển thị danh sách nhật ký của một lớp (Tham số: classId)
     */
    private void showList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String classIdParam = req.getParameter("classId");
        if (classIdParam == null || classIdParam.isEmpty()) {
            throw new IllegalArgumentException("Thiếu tham số Class ID.");
        }
        int classId = Integer.parseInt(classIdParam);
        TeacherInfoDTO currentStaffId = null;
        HttpSession session = req.getSession(false);
        if (session != null) {
            User u = (User) session.getAttribute("currentUser");
            if (u != null) {
                currentStaffId = teacherService.findStaffByEmail(u.getEmail());
            }
        }
        req.setAttribute("teacherId", currentStaffId.getStaffId());
        List<ClassLogDTO> logs = classLogService.findByClassId(classId);
        ClassDTO dto = classService.findByClassID(classId);
        req.setAttribute("className",dto.getClassName());
        req.setAttribute("classLogs", logs);
        req.setAttribute("classId", classId);
        req.getRequestDispatcher("/views/teacher/class-log.jsp").forward(req, resp);
    }

    /**
     * CREATE: Hiển thị Form viết nhật ký (Tham số: classId, teacherId)
     */
    private void showWriteJournalForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String classIdParam = req.getParameter("classId");
        String teacherIdParam = req.getParameter("teacherId");

        int classId= Integer.parseInt(req.getParameter("classId"));
        ClassDTO dto= classService.findByClassID(classId);
        if (classIdParam == null || teacherIdParam == null || teacherIdParam.isEmpty() || teacherIdParam.equals("0")) {
            req.setAttribute("errorMessage", "Thiếu thông tin lớp học hoặc ID giáo viên không hợp lệ. Vui lòng thử đăng nhập lại.");
            req.getRequestDispatcher("/views/error.jsp").forward(req, resp);
            return;
        }
        req.setAttribute("className", dto.getClassName());
        req.getRequestDispatcher("/views/teacher/class-log-write-journal.jsp").forward(req, resp);
    }

    /**
     * UPDATE: Hiển thị Form chỉnh sửa nhật ký (Tham số: logId)
     */
    private void showEditJournalForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int logId = Integer.parseInt(req.getParameter("logId"));
            int classId = Integer.parseInt(req.getParameter("classId"));

            // 1. Lấy dữ liệu nhật ký hiện tại
            ClassLogDTO existingLogDTO = classLogService.findById(logId);
            if (existingLogDTO == null) {
                throw new RuntimeException("Không tìm thấy nhật ký để chỉnh sửa (ID: " + logId + ")");
            }

            // 2. Lấy tên lớp
            ClassDTO classDTO = classService.findByClassID(classId);

            req.setAttribute("classLog", existingLogDTO);
            req.setAttribute("className", classDTO.getClassName());

            req.getRequestDispatcher("/views/teacher/class-log-edit.jsp").forward(req, resp);

        } catch (NumberFormatException e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID nhật ký hoặc lớp học không hợp lệ.");
        } catch (RuntimeException e) {
            req.getSession().setAttribute("errorMessage", e.getMessage());
            // Quay lại trang lịch sử nếu không tìm thấy
            resp.sendRedirect(req.getContextPath() + "/class-log?action=history&classId=" + req.getParameter("classId"));
        }
    }

    /**
     * CREATE: Xử lý lưu nhật ký mới (POST /class-log?action=create)
     */
    private void saveClassLog(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        int classId = Integer.parseInt(req.getParameter("classId"));
        int authorStaffId = Integer.parseInt(req.getParameter("teacherId"));
        String content = req.getParameter("content");
        ClassLog newLog = new ClassLog();
        newLog.setClassId(classId);
        newLog.setAuthorStaffId(authorStaffId);
        newLog.setContent(content);

        try {
            classLogService.save(newLog);
            req.getSession().setAttribute("message", "Ghi nhật ký thành công.");
        } catch (IllegalArgumentException e) {
            // Bắt validation error từ Service
            req.getSession().setAttribute("errorMessage", "Lỗi dữ liệu: " + e.getMessage());

            // Redirect về form để người dùng sửa lại
            resp.sendRedirect(req.getContextPath() + "/class-log?classId=" + classId);
            return;
        } catch (Exception e) {
            req.getSession().setAttribute("errorMessage", "Lỗi hệ thống khi lưu nhật ký.");
        }

        // Redirect về trang danh sách nhật ký của lớp đó sau khi thành công
        resp.sendRedirect(req.getContextPath() + "/class-log?classId=" + classId);
    }

    /**
     * READ: Hiển thị chi tiết nhật ký (Tham số: logId)
     */
    private void showLogDetail(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int logId = Integer.parseInt(req.getParameter("logId"));
        ClassLogDTO log = classLogService.findById(logId);
        int classId= Integer.parseInt(req.getParameter("classId"));
        ClassDTO dto= classService.findByClassID(classId);
        HttpSession session = req.getSession(false);
        if (session != null) {
            User u = (User) session.getAttribute("currentUser");
            String email = u.getEmail();
            req.setAttribute("staffId", teacherService.findStaffByEmail(email));
        }
        if (log == null) {
            throw new RuntimeException("Không tìm thấy nhật ký có ID: " + logId);
        }

        req.setAttribute("classLog", log);
        req.setAttribute("className", dto.getClassName());
        req.getRequestDispatcher("/views/teacher/class-log-detail.jsp").forward(req, resp);
    }

    /**
     * UPDATE: Xử lý cập nhật nhật ký (POST /class-log?action=update)
     */
    private void updateClassLog(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int logId = Integer.parseInt(req.getParameter("logId"));
        int classId = Integer.parseInt(req.getParameter("classId"));
        String newContent = req.getParameter("content");

        ClassLog logToUpdate = new ClassLog();
        logToUpdate.setLogId(logId);
        logToUpdate.setContent(newContent);

        try {
            boolean success = classLogService.update(logToUpdate);
            if (success) {
                req.getSession().setAttribute("message", "Cập nhật nhật ký thành công.");
            } else {
                req.getSession().setAttribute("errorMessage", "Không tìm thấy nhật ký để cập nhật hoặc lỗi DB.");
            }
        } catch (Exception e) {
            req.getSession().setAttribute("errorMessage", "Lỗi cập nhật: " + e.getMessage());
        }

        // Chuyển hướng về trang danh sách
        resp.sendRedirect(req.getContextPath() + "/class-log?classId=" + classId);
    }

    /**
     * DELETE: Xử lý xóa nhật ký (POST /class-log?action=delete)
     */
    private void deleteClassLog(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int logId = Integer.parseInt(req.getParameter("logId"));
        int classId = Integer.parseInt(req.getParameter("classId"));

        try {
            boolean success = classLogService.delete(logId);
            if (success) {
                req.getSession().setAttribute("message", "Xóa nhật ký thành công.");
            } else {
                req.getSession().setAttribute("errorMessage", "Không tìm thấy nhật ký để xóa.");
            }
        } catch (Exception e) {
            req.getSession().setAttribute("errorMessage", "Lỗi hệ thống khi xóa nhật ký.");
        }

        // Chuyển hướng về trang danh sách
        resp.sendRedirect(req.getContextPath() + "/class-log?classId=" + classId);
    }
}