package org.example.quan_ly_khoa_hoc.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.quan_ly_khoa_hoc.dto.ScheduleDTO;
import org.example.quan_ly_khoa_hoc.entity.Schedule;
import org.example.quan_ly_khoa_hoc.service.ScheduleService;
import org.example.quan_ly_khoa_hoc.service.serviceInterface.IScheduleService;

import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;

@WebServlet(name = "ScheduleController", value = "/schedule")
public class ScheduleController extends HttpServlet {
    private final IScheduleService scheduleService = new ScheduleService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException {
        String action = req.getParameter("action");
        int classId;
        if (req.getParameter("classId") != null) {
            classId = Integer.parseInt(req.getParameter("classId"));
            req.setAttribute("classId", classId); // truyền lại cho JSP
        }

        try {
            switch (action == null ? "" : action) {
                case "add":
                    showAddForm(req, resp);
                    break;
                case "edit":
                    showEditForm(req, resp);
                    break;
                case "delete":
                    delete(req, resp);
                    break;
                default:
                    list(req, resp);
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException {
        String action = req.getParameter("action");
        try {
            switch (action == null ? "" : action) {
                case "add":
                    insert(req, resp);
                    break;
                case "edit":
                    update(req, resp);
                    break;
                default:
                    // safe default: redirect to list (preserve classId if present)
                    String classIdParam = req.getParameter("classId");
                    String redirect = "schedule";
                    if (classIdParam != null && !classIdParam.isEmpty()) {
                        redirect += "?classId=" + classIdParam;
                    }
                    resp.sendRedirect(redirect);
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    // === LIST ===
    private void list(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        // Lấy classId từ parameter
        final int classId;
        if (req.getParameter("classId") != null) {
            classId = Integer.parseInt(req.getParameter("classId"));
            req.setAttribute("classId", classId);
        } else {
            classId = 0;
        }

        // Lấy danh sách lịch
        List<ScheduleDTO> list = scheduleService.findScheduleDTOByClassId(classId);


        req.setAttribute("list", list);

        // Lấy thông báo từ session
        Object successMsg = req.getSession().getAttribute("successMsg");
        Object errorMsg = req.getSession().getAttribute("errorMsg");
        if (successMsg != null) {
            req.setAttribute("successMsg", successMsg.toString());
            req.getSession().removeAttribute("successMsg");
        }
        if (errorMsg != null) {
            req.setAttribute("errorMsg", errorMsg.toString());
            req.getSession().removeAttribute("errorMsg");
        }

        // Chuyển tiếp tới JSP hiển thị danh sách
        req.getRequestDispatcher("/views/schedules/schedule-list.jsp").forward(req, resp);
    }

    // === SHOW ADD FORM ===
    private void showAddForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/views/schedules/schedule-form.jsp").forward(req, resp);
    }

    // === INSERT ===
    private void insert(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        Schedule schedule = new Schedule();
        schedule.setClassId(Integer.parseInt(req.getParameter("classId")));
        schedule.setLessonId(Integer.parseInt(req.getParameter("lessonId")));

        String startStr = req.getParameter("timeStart");
        String endStr = req.getParameter("timeEnd");
        schedule.setTimeStart(Timestamp.valueOf(LocalDateTime.parse(startStr)));
        schedule.setTimeEnd(Timestamp.valueOf(LocalDateTime.parse(endStr)));

        schedule.setRoom(req.getParameter("room"));

        boolean success = scheduleService.add(schedule);
        if (success) {
            req.getSession().setAttribute("successMsg", "Thêm buổi học thành công!");
        } else {
            req.getSession().setAttribute("errorMsg", "Thêm buổi học thất bại!");
        }

        resp.sendRedirect("schedule?classId=" + schedule.getClassId());
    }

    // === SHOW EDIT FORM ===
    private void showEditForm(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        int scheduleId = Integer.parseInt(req.getParameter("schedule_id"));
        Schedule schedule = scheduleService.findScheduleById(scheduleId);
        req.setAttribute("schedule", schedule);
        req.getRequestDispatcher("/views/schedules/schedule-form.jsp").forward(req, resp);
    }

    // === UPDATE ===
    private void update(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        int scheduleId = Integer.parseInt(req.getParameter("schedule_id"));
        Schedule schedule = scheduleService.findScheduleById(scheduleId);

        schedule.setClassId(Integer.parseInt(req.getParameter("classId")));
        schedule.setLessonId(Integer.parseInt(req.getParameter("lessonId")));
        schedule.setTimeStart(Timestamp.valueOf(LocalDateTime.parse(req.getParameter("timeStart"))));
        schedule.setTimeEnd(Timestamp.valueOf(LocalDateTime.parse(req.getParameter("timeEnd"))));
        schedule.setRoom(req.getParameter("room"));

        boolean success = scheduleService.editById(scheduleId, schedule);
        if (success) {
            req.getSession().setAttribute("successMsg", "Cập nhật buổi học thành công!");
        } else {
            req.getSession().setAttribute("errorMsg", "Cập nhật buổi học thất bại!");
        }

        resp.sendRedirect("schedule?classId=" + schedule.getClassId());
    }

    // === DELETE ===
    private void delete(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        int scheduleId = Integer.parseInt(req.getParameter("schedule_id"));
        boolean success = scheduleService.deleteById(scheduleId);

        if (success) {
            req.getSession().setAttribute("successMsg", "Xóa buổi học thành công!");
        } else {
            req.getSession().setAttribute("errorMsg", "Xóa buổi học thất bại!");
        }

        String classIdParam = req.getParameter("classId");
        String redirect = "schedule";
        if (classIdParam != null && !classIdParam.isEmpty()) {
            redirect += "?classId=" + classIdParam;
        }
        resp.sendRedirect(redirect);
    }
}