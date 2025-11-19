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
        if (action == null) {
            action = "listToday";
        }

        try {
            switch (action) {
                case "listToday":
                    showTodaySchedules(req, resp);
                    break;
                case "takeNew":
                    showAttendanceForm(req, resp);
                    break;
                default:
                    showTodaySchedules(req, resp);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void showTodaySchedules(HttpServletRequest req, HttpServletResponse resp) {
        try {
            List<ScheduleDTO> todaySchedules = attendanceService.getSchedulesForToday();
            req.setAttribute("todaySchedules", todaySchedules);
            req.getRequestDispatcher("/views/teacher/today-schedules.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();

        }
    }

    private void showAttendanceForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String scheduleIdStr = request.getParameter("scheduleId");
        if (scheduleIdStr == null || scheduleIdStr.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Thiếu ID lịch học (scheduleId) để điểm danh.");
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
        request.setAttribute("currentClass", currentClass);
        request.setAttribute("currentSchedule", scheduleInfo);
        request.setAttribute("studentList", studentList);

        request.setAttribute("scheduleId", scheduleId);

        request.getRequestDispatcher("/views/teacher/attendance-form.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp){
        try {
            req.setCharacterEncoding("UTF-8");
        } catch (UnsupportedEncodingException e) {
            // Log the exception for better debugging if necessary
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
            resp.sendRedirect(req.getContextPath() + "/attendance?msg=saved");

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