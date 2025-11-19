package org.example.quan_ly_khoa_hoc.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.example.quan_ly_khoa_hoc.dto.StudentDetailDTO;
import org.example.quan_ly_khoa_hoc.dto.TeacherClassDTO;
import org.example.quan_ly_khoa_hoc.entity.Attendance;
import org.example.quan_ly_khoa_hoc.entity.Lesson;
import org.example.quan_ly_khoa_hoc.entity.Module;
import org.example.quan_ly_khoa_hoc.repository.ClassRepository;
import org.example.quan_ly_khoa_hoc.repository.repositoryInterface.IClassRepository;
import org.example.quan_ly_khoa_hoc.service.AttendanceService;
import org.example.quan_ly_khoa_hoc.service.serviceInterface.IAttendanceService;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

@WebServlet(name = "AttendanceController", value = "/attendance")
public class AttendanceController extends HttpServlet {

    private IAttendanceService attendanceService = new AttendanceService();
    private IClassRepository classRepository = new ClassRepository();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        // Nếu action là view-form (hoặc null) thì gọi hàm hiển thị form
        if ("view-form".equals(action) || action == null) {
            try {
                showAttendanceForm(req, resp);
            } catch (Exception e) {
                e.printStackTrace();
                resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi tải form điểm danh");
            }
        }
    }

    // Hàm logic chính để xử lý việc Reload trang (No-JS)
    private void showAttendanceForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int classId = Integer.parseInt(request.getParameter("classId"));
        TeacherClassDTO currentClass = classRepository.findClassById(classId);

        List<Module> moduleList = attendanceService.getModulesByCourse(currentClass.getCourseId());


        String moduleIdStr = request.getParameter("moduleId");
        List<Lesson> lessonList = new ArrayList<>(); // Mặc định rỗng

        if (moduleIdStr != null && !moduleIdStr.isEmpty()) {
            int moduleId = Integer.parseInt(moduleIdStr);
            lessonList = attendanceService.getLessonsByModule(moduleId);
        }

        String lessonIdStr = request.getParameter("lessonId");
        List<StudentDetailDTO> studentList = new ArrayList<>();

        if (lessonIdStr != null && !lessonIdStr.isEmpty()) {
            studentList = classRepository.findStudentsByClassId(classId);
        }

        request.setAttribute("currentClass", currentClass);
        request.setAttribute("moduleList", moduleList);
        request.setAttribute("lessonList", lessonList);
        request.setAttribute("studentList", studentList);
        request.setAttribute("selectedModuleId", moduleIdStr);
        request.setAttribute("selectedLessonId", lessonIdStr);
        request.getRequestDispatcher("/views/teacher/attendance-form.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp){
        try {
            req.setCharacterEncoding("UTF-8");
        } catch (UnsupportedEncodingException e) {
            throw new RuntimeException(e);
        }
        try {
            int classId = Integer.parseInt(req.getParameter("classId"));
            int lessonId = Integer.parseInt(req.getParameter("lessonId"));
            LocalDate date = LocalDate.parse(req.getParameter("attendanceDate"));
            List<Attendance> attendanceList = new ArrayList<>();
            Enumeration<String> params = req.getParameterNames();
            while (params.hasMoreElements()) {
                String p = params.nextElement();
                if (p.startsWith("status_")) {
                    int studentId = Integer.parseInt(p.split("_")[1]);
                    String status = req.getParameter(p);
                    String note = req.getParameter("note_" + studentId);
                    attendanceList.add(new Attendance(0, studentId, status, note));
                }
            }

            attendanceService.submitAttendance(classId, date, lessonId, attendanceList);

            resp.sendRedirect(req.getContextPath() + "/teacher?msg=saved");

        } catch (Exception e) {
            e.printStackTrace();
            try {
                resp.sendRedirect(req.getContextPath() + "/teacher?msg=error");
            } catch (IOException ex) {
                throw new RuntimeException(ex);
            }
        }
    }
}