package org.example.quan_ly_khoa_hoc.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.quan_ly_khoa_hoc.dto.StudentDetailDTO;
import org.example.quan_ly_khoa_hoc.dto.TeacherInfoDTO;
import org.example.quan_ly_khoa_hoc.entity.User;
import org.example.quan_ly_khoa_hoc.service.ClassService;
import org.example.quan_ly_khoa_hoc.service.TeacherService;
import org.example.quan_ly_khoa_hoc.service.serviceInterface.IClassService;
import org.example.quan_ly_khoa_hoc.service.serviceInterface.ITeacherService;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ClassController", value = "/class") // URL mapping: /class
public class ClassController extends HttpServlet {
    private ITeacherService teacherService = new TeacherService();
    // Khai báo ClassService để xử lý logic liên quan đến lớp học
    private final IClassService classService = new ClassService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }

        switch (action) {
            case "detail":
                // Xử lý logic hiển thị chi tiết lớp học và danh sách sinh viên
                showClassDetail(req, resp);
                break;
            default:
                // Trả về lỗi 404 nếu không có action hợp lệ
                resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    /**
     * Hiển thị chi tiết của một lớp học, bao gồm danh sách sinh viên và điểm danh.
     */
    private void showClassDetail(HttpServletRequest req, HttpServletResponse resp) {
        HttpSession session = req.getSession(false);
        if (session != null) {
            User u = (User) session.getAttribute("currentUser");
            String email = u.getEmail();
            req.setAttribute("teacher", teacherService.findStaffByEmail(email));
        }
        try {
            // Lấy tham số từ request (classId, courseId, className)
            int classId = Integer.parseInt(req.getParameter("classId"));
            int courseId = Integer.parseInt(req.getParameter("courseId"));
            String className = req.getParameter("className");

            // Gọi Service để lấy danh sách sinh viên với điểm danh (đã áp dụng logic lọc theo Module gần nhất)
            List<StudentDetailDTO> studentList = classService.findStudentsByClassId(classId);

            // Đặt thuộc tính cho JSP
            req.setAttribute("classId", classId);
            req.setAttribute("courseId", courseId);
            req.setAttribute("className", className);
            req.setAttribute("studentList", studentList);


            req.getRequestDispatcher("/views/teacher/class-detail.jsp").forward(req, resp);
        } catch (NumberFormatException e) {
            System.out.println("Lỗi NumberFormatException: classId hoặc courseId không hợp lệ.");
            e.printStackTrace();

            try {
                resp.sendRedirect(req.getContextPath() + "/teacher");
            } catch (IOException ioException) {
                ioException.printStackTrace();
            }
        } catch (Exception e) {
            System.out.println("Lỗi khi hiển thị chi tiết lớp học: " + e.getMessage());
            e.printStackTrace();
        }
    }
}